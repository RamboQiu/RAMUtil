//
//  RAMDemo2Object.m
//  RAMUtilDemo
//
//  Created by rambo on 2020/1/5.
//  Copyright © 2020 裘俊云. All rights reserved.
//

#import "RAMDemo2Object.h"
#import "RAMDemoObject.h"

@implementation RAMDemo2Object

- (void)test {
    NSLog(@"test");
}

+ (void)load {
    NSLog(@"b father %@", NSStringFromSelector(_cmd));
    RAMDemoObject *obj = RAMDemoObject.new;
}

+ (void)initialize {
    NSLog(@"b father %@", NSStringFromSelector(_cmd));
}
@end
