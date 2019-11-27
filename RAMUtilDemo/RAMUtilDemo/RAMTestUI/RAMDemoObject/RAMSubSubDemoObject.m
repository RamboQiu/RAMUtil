//
//  RAMSubSubDemoObject.m
//  RAMUtilDemo
//
//  Created by rambo on 2019/11/26.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import "RAMSubSubDemoObject.h"

@implementation RAMSubSubDemoObject

//+ (void)load {
//    NSLog(@"a1 sub sub %@", NSStringFromSelector(_cmd));
//}

+ (void)initialize {
    NSLog(@"a1 sub sub %@", NSStringFromSelector(_cmd));
}

@end
