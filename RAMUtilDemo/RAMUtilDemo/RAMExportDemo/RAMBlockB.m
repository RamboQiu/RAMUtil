//
//  RAMBlockB.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2018/12/21.
//  Copyright © 2018 裘俊云. All rights reserved.
//

#import "RAMBlockB.h"
#import <RAMUtil/RAMExport.h>

@implementation RAMBlockB
RAM_BLOCKS_EXPORT(A, ^(void){
    printf("testB");
})

RAM_BLOCKS_EXPORT(C, ^(void){
    printf("testC");
})
@end
