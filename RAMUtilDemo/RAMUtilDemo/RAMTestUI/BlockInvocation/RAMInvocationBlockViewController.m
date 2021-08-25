//
//  RAMInvocationBlockViewController.m
//  RAMUtilDemo
//
//  Created by rambo on 2021/8/25.
//  Copyright © 2021 裘俊云. All rights reserved.
//

#import "RAMInvocationBlockViewController.h"
#import "NSInvocation+Block.h"

@interface RAMInvocationBlockViewController ()

@end

@implementation RAMInvocationBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)testAction:(id)sender {
    void (^myBlock)(id, NSString*, NSArray*) = ^(id obj1, NSString* name, NSArray* array) {
      NSLog(@"%@",@"Hey!");
    };
    NSInvocation* inv = [NSInvocation invocationWithBlock:myBlock];
    [inv invoke];
}

@end
