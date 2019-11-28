//
//  Person+Swizzling.m
//  runtimeTest
//
//  Created by 裘俊云 on 2019/11/28.
//

#import "Person+Swizzling.h"
#import <objc/runtime.h>

typedef IMP *IMPPointer;

// 替换方法
static void MethodSwizzle(id self, SEL _cmd, id arg1, id arg2);
// 原始方法函数指针
static void (*MethodOriginal)(id self, SEL _cmd, id arg1, id arg2);

// 交换方法函数
static void MethodSwizzle(id self, SEL _cmd, id arg1, id arg2) {
    // 在这里添加 交换方法的相关代码
    NSLog(@"swizzledFunc");
    
    MethodOriginal(self, _cmd, arg1, arg2);
}

BOOL class_swizzleMethodAndStore(Class class, SEL original, IMP replacement, IMPPointer store) {
    IMP imp = NULL;
    Method method = class_getInstanceMethod(class, original);
    if (method) {
        const char *type = method_getTypeEncoding(method);
        imp = class_replaceMethod(class, original, replacement, type);
        if (!imp) {
            imp = method_getImplementation(method);
        }
    }
    if (imp && store) {
        *store = imp;
    }
    return (imp != NULL);
}

@implementation Person (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzle:@selector(originalFunc:) with:(IMP)MethodSwizzle store:(IMP *)&MethodOriginal];
    });
}

+ (BOOL)swizzle:(SEL)original with:(IMP)replacement store:(IMPPointer)store {
    return class_swizzleMethodAndStore(self, original, replacement, store);
}

- (void)originalFunc:(NSString *)arg1 {
    NSLog(@"originalFunc");
}
@end
