//
//  RAMStageB.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2018/12/21.
//  Copyright © 2018 裘俊云. All rights reserved.
//

#import "RAMStageB.h"
#import <RAMUtil/RAMExport.h>

@implementation RAMStageB
RAM_FUNCTION_EXPORT(A)(void) {
    printf("\nRAMStageB:test function A");
}

RAM_FUNCTION_EXPORT(B)(void) {
    printf("\nRAMStageB:test function B");
}
@end
