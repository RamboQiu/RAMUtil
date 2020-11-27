//
//  RAMDemoObject.m
//  RAMUtilDemo
//
//  Created by rambo on 2019/11/26.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import "RAMDemoObject.h"
#import "RAMDemo2Object.h"

@implementation RAMDemoObject
- (void)test {
    NSLog(@"test");
}

+ (void)load {
    NSLog(@"a father %@", NSStringFromSelector(_cmd));
    RAMDemo2Object *obj = RAMDemo2Object.new;
}

+ (void)initialize {
    NSLog(@"a father %@", NSStringFromSelector(_cmd));
}

+ (instancetype)initWithType:(int)type {
    RAMDemoObject *tmp = RAMDemoObject.new;
    tmp.type = type;
    return tmp;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%d",self.type];
}
@end
