//
//  Network.m
//  RAMUtilDemo
//
//  Created by rambo on 2021/1/26.
//  Copyright © 2021 裘俊云. All rights reserved.
//

#import "Network.h"

@implementation Network
+ (instancetype)sharedInstance {
    static Network* config = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        config = [[Network alloc] init];
    });
    return config;
}
@end
