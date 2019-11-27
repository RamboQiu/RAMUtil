//
//  RAMNativeJsViewController.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2019/4/28.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import "RAMNativeJsViewController.h"
#import "RAMJSCoreBridge.h"

@interface RAMNativeJsViewController ()

@end

@implementation RAMNativeJsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleText?:@"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    RAMJSCoreBridge *js = [[RAMJSCoreBridge alloc] init];
    [js test];
}


@end
