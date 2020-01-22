//
//  NSObject+RAMDemoCategory2.m
//  RAMUtilDemo
//
//  Created by rambo on 2020/1/5.
//  Copyright © 2020 裘俊云. All rights reserved.
//

#import "RAMSubDemoObject+RAMDemoCategory2.h"

@implementation RAMSubDemoObject (RAMDemoCategory2)

+ (void)load {
    NSLog(@"a sub catogory2 %@", NSStringFromSelector(_cmd));
}

+(void)initialize {
    NSLog(@"a sub catogory2 %@", NSStringFromSelector(_cmd));
}
@end
