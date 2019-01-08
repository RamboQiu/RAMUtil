//  参考文章: https://www.jianshu.com/p/9dbbdca2515e
//  github: https://github.com/nicklockwood/MustOverride
//  debug 下才做执行检查

#import "RAMMustOverrider.h"

#if DEBUG

#import <dlfcn.h>
#import <objc/runtime.h>

#import <mach-o/dyld.h>
#import <mach-o/getsect.h>

static BOOL RAMClassOverridesMethod(Class cls, SEL selector) {
    unsigned int numberOfMethods;
    Method *methods = class_copyMethodList(cls, &numberOfMethods);
    for (unsigned int i = 0; i < numberOfMethods; i++) {
        if (method_getName(methods[i]) == selector) {
            free(methods);
            return YES;
        }
    }
    free(methods);
    return NO;
}

static NSArray *RAMSubclassesOfClass(Class baseClass) {
    static Class *classes;
    static unsigned int classCount;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        classes = objc_copyClassList(&classCount); // 获取项目中所有用到的类
    });
    
    NSMutableArray *subclasses = [NSMutableArray array];
    for (unsigned int i = 0; i < classCount; i++) {
        Class cls = classes[i];
        Class superclass = cls;
        while (superclass) {
            if (superclass == baseClass) {
                [subclasses addObject:cls];
                break;
            }
            superclass = class_getSuperclass(superclass);
        }
    }
    return subclasses;
}

void RAMCheckOverrides(void) {
    Dl_info info;
    dladdr((const void *)&RAMCheckOverrides, &info);
    
#ifdef __LP64__
    typedef uint64_t RAMMustOverrideValue;
    typedef struct section_64 RAMMustOverrideSection;
#define RAMGetSectByNameFromHeader getsectbynamefromheader_64
#else
    typedef uint32_t RAMMustOverrideValue;
    typedef struct section RAMMustOverrideSection;
#define RAMGetSectByNameFromHeader getsectbynamefromheader
#endif
    
    const RAMMustOverrideValue mach_header = (RAMMustOverrideValue)info.dli_fbase;
    const RAMMustOverrideSection *section = RAMGetSectByNameFromHeader((void *)mach_header, "__DATA", "RAMMustOverride");
    if (section == NULL) return;
    
    NSMutableArray *failures = [NSMutableArray array];
    int addrOffset = sizeof(const char **);
    /**
     *  防止address sanitizer报global-buffer-overflow错误
     *  https://github.com/google/sanitizers/issues/355
     *  因为address sanitizer填充了符号地址，使用正确的地址偏移
     */
#if defined(__has_feature)
#  if __has_feature(address_sanitizer)
    addrOffset = 64;
#  endif
#endif
    for (RAMMustOverrideValue addr = section->offset;
         addr < section->offset + section->size;
         addr += addrOffset) {
        NSString *entry = @(*(const char **)(mach_header + addr));
        if (entry.length == 0) {
            continue;
        }
        NSArray *parts = [[entry substringWithRange:NSMakeRange(2, entry.length - 3)] componentsSeparatedByString:@" "];
        if (parts.count < 2 ) {
            continue;
        }
        NSString *className = parts[0];
        NSRange categoryRange = [className rangeOfString:@"("];
        if (categoryRange.length) {
            className = [className substringToIndex:categoryRange.location];
        }
        
        BOOL isClassMethod = [entry characterAtIndex:0] == '+';
        Class cls = NSClassFromString(className);
        SEL selector = NSSelectorFromString(parts[1]);
        
        for (Class subclass in RAMSubclassesOfClass(cls)) {
            if (!RAMClassOverridesMethod(isClassMethod ? object_getClass(subclass) : subclass, selector)) {
                [failures addObject:[NSString stringWithFormat:@"%@ does not implement method %c%@ required by %@",
                                     subclass, isClassMethod ? '+' : '-', parts[1], className]];
            }
        }
    }
    if (failures.count > 0) {
        for (NSString *fail in failures) {
            printf("%s\n", [fail UTF8String]);
        }
        assert(false);
    }
}

@interface RAMMustOverrider : NSObject

@end

@implementation RAMMustOverrider
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        RAMCheckOverrides();        
    });
}
@end

#endif
