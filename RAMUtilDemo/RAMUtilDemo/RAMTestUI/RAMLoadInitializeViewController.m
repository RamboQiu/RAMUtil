//
//  RAMLoadInitializeViewController.m
//  RAMUtilDemo
//
//  Created by rambo on 2019/11/26.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import "RAMLoadInitializeViewController.h"
#import <RAMUtil/UIView+Frame.h>
#import <RAMUtil/UIColor+RAMHEX.h>
#import "RAMDemoObject/RAMDemoObject.h"
#import "RAMDemoObject/RAMSubDemoObject.h"

@interface RAMLoadInitializeViewController ()
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) RAMDemoObject *test;
@property (nonatomic, strong) RAMSubDemoObject *subTest;
@end

@implementation RAMLoadInitializeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleText?:@"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.button setTitle:@"点我点我" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
//    self.test = RAMDemoObject.new;
    self.subTest = RAMSubDemoObject.new;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.button.width = 100;
    self.button.height = 50;
    self.button.middleX = self.view.width / 2;
    self.button.middleY = self.view.height / 2;
}

- (void)testAction:(id)sender {
//    RAMDemoObject *test = RAMDemoObject.new;
    [self.test test];
}

@end
