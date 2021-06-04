//
//  RAMCategoryFather+RAMCategory.m
//  RAMUtilDemo
//
//  Created by rambo on 2021/6/4.
//  Copyright © 2021 裘俊云. All rights reserved.
//

#import "RAMCategoryFather+RAMCategory.h"
#import <objc/runtime.h>


static const void* const teststringkey = &teststringkey;

@implementation RAMCategoryFather (RAMFatherCategory)

//- (void)tegotherEat {
//    NSLog(@"父亲”又“说一起吃");
//}

- (void)drinkWater {
    NSLog(@"父亲“又”喝水");
}

- (NSString *)test {
    NSString *tmp = objc_getAssociatedObject(self, teststringkey);
    if (!tmp) {
        tmp = @"父亲炒菜";
        objc_setAssociatedObject(self, teststringkey, tmp, OBJC_ASSOCIATION_RETAIN);
    }
    return tmp;
}

- (void)setTest:(NSString *)test {
    objc_setAssociatedObject(self, teststringkey, test, OBJC_ASSOCIATION_RETAIN);
}

@end
