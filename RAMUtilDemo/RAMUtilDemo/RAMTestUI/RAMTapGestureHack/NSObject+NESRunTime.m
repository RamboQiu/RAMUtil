//
//  NSObject+RunTime.m
//  mail
//
//  Created by leikun on 15/8/17.
//  Copyright (c) 2015年 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import "NSObject+NESRunTime.h"
#import <libkern/OSAtomic.h>


@implementation NSObject (NESRunTime)

#pragma mark
#pragma mark - 公用方法
//保证线程安全
static void runtimeProgram_performBlockWithLock(dispatch_block_t block) {
    static OSSpinLock aspect_lock = OS_SPINLOCK_INIT;
    OSSpinLockLock(&aspect_lock);
    block();
    OSSpinLockUnlock(&aspect_lock);
}

//这个方法用传入的IMP去替换已经存在的SEL的实现，如果SEL存在，返回替换前的IMP；否则返回NULL
static IMP runtimeProgram_replaceMethodToIMP(Class c, SEL selector, IMP overrideIMP) {
    IMP imp = NULL;
    if (overrideIMP) {
        if (class_respondsToSelector(c, selector)) {
            Method method = class_getInstanceMethod(c, selector);
            imp = method_getImplementation(method);
            const char *encoding = method_getTypeEncoding(method);
            //如果selector是c的super class实现的，class_replaceMethod返回NULL
            class_replaceMethod(c, selector, overrideIMP, encoding);
        } else {
            BOOL isMetaClass = class_isMetaClass(c);
            NSCAssert(NO, @"请检查%@:%@是否存在",isMetaClass?@"类方法":@"对象方法", NSStringFromSelector(selector));
        }
    } else {
        NSCAssert(overrideIMP, @"overrideIMP不能为空");
    }
    return imp;
}

#pragma mark - 方法混淆
static void runtimeProgram_methodSwizzle(Class c, SEL origSEL, SEL overrideSEL) {
    runtimeProgram_performBlockWithLock(^{
        Method overrideMethod = class_getInstanceMethod(c, overrideSEL);
        if (overrideMethod) {
            IMP origIMP = runtimeProgram_replaceMethodToIMP(c, origSEL, method_getImplementation(overrideMethod));
            runtimeProgram_replaceMethodToIMP(c, overrideSEL, origIMP);
        } else {
            BOOL isMetaClass = class_isMetaClass(c);
            NSCAssert(overrideMethod != NULL, @"请检查%@:%@是否存在",isMetaClass?@"类方法":@"对象方法", NSStringFromSelector(overrideSEL));
        }
    });
}

- (void)nes_swizzleInstanceMethod:(SEL)origSEL to:(SEL)overrideSEL {
    NSParameterAssert(origSEL);
    NSParameterAssert(overrideSEL);
    runtimeProgram_methodSwizzle(self.class, origSEL, overrideSEL);
}

#pragma mark - 检查方法是否存在
- (BOOL)nes_isContainSel:(SEL)sel inClass:(Class)class {
    Method method = class_getInstanceMethod(class, sel);
    if (method != NULL) {
        return YES;
    }
    return NO;
}
@end
