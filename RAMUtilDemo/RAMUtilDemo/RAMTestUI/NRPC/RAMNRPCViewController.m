//
//  RAMNRPCViewController.m
//  RAMUtilDemo
//
//  Created by rambo on 2021/8/25.
//  Copyright © 2021 裘俊云. All rights reserved.
//

#import "RAMNRPCViewController.h"
#import "RAMNativeBridgeWeex.h"

@interface RAMNRPCViewController ()

@end

@implementation RAMNRPCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)testAction:(id)sender {
    RAMNativeBridgeWeex *test = RAMNativeBridgeWeex.new;
    [test test:@{}];
}

@end
