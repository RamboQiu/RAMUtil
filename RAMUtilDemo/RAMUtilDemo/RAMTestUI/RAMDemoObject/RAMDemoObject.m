//
//  RAMDemoObject.m
//  RAMUtilDemo
//
//  Created by rambo on 2019/11/26.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import "RAMDemoObject.h"

@implementation RAMDemoObject
- (void)test {
    NSLog(@"test");
}

+ (void)load {
    NSLog(@"a father %@", NSStringFromSelector(_cmd));
}

+ (void)initialize {
    NSLog(@"a father %@", NSStringFromSelector(_cmd));
}
@end
