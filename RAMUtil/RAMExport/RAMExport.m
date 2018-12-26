// 参考文章: 
// https://www.jianshu.com/p/9dbbdca2515e
// https://tech.meituan.com/waimai_ios_optimizing_startup.html
// http://www.runoob.com/cprogramming/c-structures.html
// https://blog.csdn.net/Hello_Hwc/article/details/78317863
// https://www.cnblogs.com/windlaughing/archive/2013/04/10/3012012.html
// https://blog.csdn.net/qq_27074387/article/details/79815359
// https://stackoverflow.com/questions/24908713/what-is-the-sizeofstruct
// http://blog.51cto.com/justinxd/567546
// https://blog.csdn.net/zll_liang/article/details/8966106
// https://blog.csdn.net/args_/article/details/53018656
// https://www.jianshu.com/p/f0a56c5bc4fe
// https://www.jianshu.com/p/bdbb0f5f0df5
// http://www.voidcn.com/article/p-zlzztazc-bdh.html
// debug 下才做执行检查

#import "RAMExport.h"

#if DEBUG

#import <dlfcn.h>
#import <objc/runtime.h>

#import <mach-o/dyld.h>
#import <mach-o/getsect.h>
#import <mach-o/ldsyms.h>



#ifdef __LP64__
typedef uint64_t RAMExportValue;
typedef struct section_64 RAMExportSection;
#define RAMGetSectByNameFromHeader getsectbynamefromheader_64
#else
typedef uint32_t RAMExportValue;
typedef struct section RAMExportSection;
#define RAMGetSectByNameFromHeader getsectbynamefromheader
#endif

NSString *extractClassName(NSString *methodName) {
    NSArray *parts = [[methodName substringWithRange:NSMakeRange(2, methodName.length - 3)] componentsSeparatedByString:@" "];
    if (parts.count > 0)
        return parts[0];
    return nil;
}

NSString *extractMethodName(NSString *methodName) {
    NSArray *parts = [[methodName substringWithRange:NSMakeRange(2, methodName.length - 3)] componentsSeparatedByString:@" "];
    if (parts.count > 1)
        return parts[1];
    return nil;
}

#pragma mrak - 获取目标所有类class

NSArray<Class> *ram_classes_export(void) {
    Dl_info info;
    dladdr((const void *)&ram_classes_export, &info);
    const RAMExportValue mach_header = (RAMExportValue)info.dli_fbase;
    const RAMExportSection *section = RAMGetSectByNameFromHeader((void *)mach_header, "__RAM", "__funcName");
    if (section == NULL) return nil;
    
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
    
    NSMutableArray<Class> *classes = [NSMutableArray new];
    for (RAMExportValue addr = section->offset;
         addr < section->offset + section->size;
         addr += addrOffset) {
        
        // Get data entry
        const char **entries = (const char **)(mach_header + addr);
        const char *str = *entries;
        if (str == NULL) {
            continue;
        }
        
        NSString *className = extractClassName(@(str));
        Class class = className ? NSClassFromString(className) : nil;
        if (class){
            [classes addObject:class];
        }
    }
    return classes;
}

#pragma mark -

BOOL RAMHasSection(char *segname, char *sectname) {
//    char *result = malloc(strlen(segname)+strlen(sectname)+1+1);//+1 for the zero-terminator
//    //in real code you would check for errors in malloc here
//    if (result == NULL) exit (1);
//
//    strcpy(result, segname);
//    strcat(result, ",");
//    strcat(result, sectname);
//
//    struct section tmp;
//    strcpy(tmp.segname, segname);
//    strcpy(tmp.sectname, sectname);
//    tmp.flags = S_ZEROFILL;
//    __attribute__ ((section("__DATA,Z"))) static long long altstack[10];
//    int b = sizeof(altstack);
//    return b;
// 官方推荐的方法试了下，并没有用
// http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0474c/CACJAJGD.html
    
    
    Dl_info info;
    dladdr((const void *)&RAMHasSection, &info);

    const RAMExportValue mach_header = (RAMExportValue)info.dli_fbase;
    const RAMExportSection *section = RAMGetSectByNameFromHeader((void *)mach_header, segname, sectname);
    if (section == NULL) return NO;
    else return YES;
}

NSObject * RAMGetString(NSString *key) {
    Dl_info info;
    dladdr((const void *)&RAMGetString, &info);
    
    const RAMExportValue mach_header = (RAMExportValue)info.dli_fbase;
    const RAMExportSection *section = RAMGetSectByNameFromHeader((void *)mach_header, "__RAM", "__ram.data");
    if (section == NULL) return nil;
    
    int addrOffset = sizeof(struct RAM_String);
    for (RAMExportValue addr = section->offset;
         addr < section->offset + section->size;
         addr += addrOffset) {
        struct RAM_String entry = *(struct RAM_String *)(mach_header + addr);
//        if (strcmp(entry.key, key) == 0) {
        NSString *entryKey = (NSString *)entry.key;
        if ([entryKey isEqualToString:key]) {
            return entry.value;
        }
    }
    return nil;
}

void RAMExecuteFunction(char *key) {
    Dl_info info;
    dladdr((const void *)&RAMExecuteFunction, &info);
    
    const RAMExportValue mach_header = (RAMExportValue)info.dli_fbase;
    const RAMExportSection *section = RAMGetSectByNameFromHeader((void *)mach_header, "__RAM", key);
    if (section == NULL) return;

    int addrOffset = sizeof(struct RAM_Function);
    for (RAMExportValue addr = section->offset;
         addr < section->offset + section->size;
         addr += addrOffset) {
        
        struct RAM_Function entry = *(struct RAM_Function *)(mach_header + addr);
        entry.function();
    }
    
    // 也可以使用getsectiondata获取到指定的section
    //    unsigned long size;
    //    struct RAM_Function *ptr = (struct RAM_Function *)getsectiondata(&_mh_execute_header, "__DATA", "__test", &size);
    //    void (*funP)(void);
    //    funP = ptr->functionBlock;
    //    funP();
    //    ptr->functionBlock();
}

void RAMExecuteBlock(char *key) {
    Dl_info info;
    dladdr((const void *)&RAMExecuteBlock, &info);
    
    const RAMExportValue mach_header = (RAMExportValue)info.dli_fbase;
    const RAMExportSection *section = RAMGetSectByNameFromHeader((void *)mach_header, "__RAM", key);
    if (section == NULL) return;
    
    int addrOffset = sizeof(struct RAM_Block);
    for (RAMExportValue addr = section->offset;
         addr < section->offset + section->size;
         addr += addrOffset) {

        struct RAM_Block entry = *(struct RAM_Block *)(mach_header + addr);
        if (entry.block) {
            entry.block();
        }
    }
}

@interface RAMExport ()
@end

@implementation RAMExport

+ (instancetype)sharedInstance {
    static RAMExport *singleTon;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleTon = RAMExport.new;
    });
    return singleTon;
}

- (NSArray<Class> *)classExport {
    return ram_classes_export();
}

- (void)executeArrayForKey:(NSString *)key {
    NSString *fKey = [NSString stringWithFormat:@"__%@.func", key?:@""];
    RAMExecuteFunction((char *)[fKey UTF8String]);
}

- (void)executeBlockForKey:(NSString *)key {
    NSString *fKey = [NSString stringWithFormat:@"__%@.block", key?:@""];
    RAMExecuteBlock((char *)[fKey UTF8String]);
}

- (id)valueForKey:(NSString *)key {
    NSObject *value = RAMGetString(key);
    if ([value isKindOfClass:NSString.class]) {
        return (NSString *)value;
    }
    return @"";
}

- (BOOL)hasPlacedAtSection:(NSString *)section {
    return RAMHasSection("__RAM", (char *)[section UTF8String]);
}
@end

#endif
