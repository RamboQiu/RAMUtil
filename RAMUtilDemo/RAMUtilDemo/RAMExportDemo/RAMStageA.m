//
//  RAMStageA.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2018/12/13.
//  Copyright © 2018 裘俊云. All rights reserved.
//

#import "RAMStageA.h"
#import <RAMUtil/RAMExport.h>

@interface RAMStageA ()
@property (nonatomic, strong) NSString *title;
@end

@implementation RAMStageA

+ (instancetype)sharedInstance {
    static RAMStageA *selfClass = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        selfClass = RAMStageA.new;
        selfClass.title =@"i'm title.";
    });
    return selfClass;
}

RAM_FUNCTION_EXPORT(A)() {
    NSLog(@"RAMStageA:self.title %@", RAMStageA.sharedInstance.title);
    printf("\nRAMStageA:test function A");
}

@end
