//
//  RAMBlockA.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2018/12/21.
//  Copyright © 2018 裘俊云. All rights reserved.
//

#import "RAMBlockA.h"
#import <RAMUtil/RAMExport.h>

@implementation RAMBlockA
RAM_BLOCKS_EXPORT(A, ^(void) {
    printf("testA");
})
@end
