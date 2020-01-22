//
//  RAMSubDemoObject+RAMDemoCategory.m
//  RAMUtilDemo
//
//  Created by rambo on 2019/11/26.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import "RAMSubDemoObject+RAMDemoCategory.h"

@implementation RAMSubDemoObject (RAMDemoCategory)
+ (void)load {
    NSLog(@"a sub catogory %@", NSStringFromSelector(_cmd));
}

+(void)initialize {
    NSLog(@"a sub catogory %@", NSStringFromSelector(_cmd));
}
@end
