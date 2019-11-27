//
//  NSObject+RunTime.h
//  mail
//
//  Created by leikun on 15/8/17.
//  Copyright (c) 2015年 NetEase (Hangzhou) Network Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#define GET_CLASS_CUSTOM_SEL(sel,class)  NSSelectorFromString([NSString stringWithFormat:@"%@_%@",NSStringFromClass(class),NSStringFromSelector(sel)])

@interface NSObject (NESRunTime)

- (BOOL)nes_isContainSel:(SEL)sel inClass:(Class)class;

//方法替换
- (void)nes_swizzleInstanceMethod:(SEL)origSEL to:(SEL)overrideSEL;

@end
