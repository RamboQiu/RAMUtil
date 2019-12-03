//
//  RAMWsViewController.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2019/12/3.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import "RAMWsViewController.h"
#import <RAMUtil/UIView+Frame.h>

@interface RAMWsViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, copy) dispatch_block_t block;
@property (nonatomic, strong) NSString *str;

@end

@implementation RAMWsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleText?:@"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.button setTitle:@"点我点我" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];

    self.str = @"111";
    __weak __typeof__(self) weakSelf = self;
    self.block = ^{
        __strong RAMWsViewController *strongSelf = weakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@", strongSelf.str);
        });
    };
    self.block();
}

- (void)dealloc {
    NSLog(@"RAMWsViewController delloc");
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
