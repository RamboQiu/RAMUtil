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



void Function_Attributes_section_0 (void)
__attribute__ ((section ("__TEST,new_section")));
void Function_Attributes_section_0 (void) {
    static int aStatic =0;
    aStatic++;
}

/* in RO section */
const int descriptor[3] __attribute__ ((section ("descr,D"))) = { 1,2,3 };

/* in RW section */
long long rw_initialized[10] __attribute__ ((section ("INITIALIZED_RW,C"))) = {5};

/* in RW section */
long long rw[10] __attribute__ ((section ("RW,B")));

/* in ZI section */
long long altstack[10] __attribute__ ((section ("STACK,A"), zero_init));

@end
