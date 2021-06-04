//
//  RAMBaseViewController.m
//  RAMUtilDemo
//
//  Created by rambo on 2021/6/4.
//  Copyright © 2021 裘俊云. All rights reserved.
//

#import "RAMBaseViewController.h"
#import <RAMUtil/UIView+Frame.h>

@interface RAMBaseViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation RAMBaseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleText?:@"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.button setTitle:@"点我点我" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.button.width = 100;
    self.button.height = 50;
    self.button.middleX = self.view.width / 2;
    self.button.middleY = self.view.height / 2;
}

- (void)testAction:(id)sender {
    
    
}
@end
