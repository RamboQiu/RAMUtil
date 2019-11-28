//
//  UIViewController+RAMSwizzling.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2019/11/28.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import "UIViewController+RAMSwizzling.h"
#import <objc/runtime.h>

@implementation UIViewController (RAMSwizzling)

// 交换 原方法 和 替换方法 的方法实现
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
         // 当前类
        Class class = [self class];
        
        // 原方法名 和 替换方法名
        SEL originalSelector = @selector(originalFunction);
        SEL swizzledSelector = @selector(swizzledFunction);
        
        // 原方法结构体 和 替换方法结构体
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        /* 如果当前类没有 原方法的 IMP，说明在从父类继承过来的方法实现，
         * 需要在当前类中添加一个 originalSelector 方法，
         * 但是用 替换方法 swizzledMethod 去实现它
         */
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            // 原方法的 IMP 添加成功后，修改 替换方法的 IMP 为 原始方法的 IMP
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            // 添加失败（说明已包含原方法的 IMP），调用交换两个方法的实现
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

// 原始方法
- (void)originalFunction {
    NSLog(@"originalFunction");
}

// 替换方法
- (void)swizzledFunction {
    NSLog(@"swizzledFunction");
}

@end
