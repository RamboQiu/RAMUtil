//
//  RAMRegTestViewController.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2019/7/2.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import "RAMRegTestViewController.h"

@interface RAMRegTestViewController ()
@property (nonatomic, strong) UILabel *regT;
@property (nonatomic, strong) UITextField *reg;
@property (nonatomic, strong) UILabel *testStringT;
@property (nonatomic, strong) UITextField *testString;
@property (nonatomic, strong) UIButton *btn;
@end

@implementation RAMRegTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleText?:@"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.regT = [[UILabel alloc] init];
    self.regT.text = @"正则";
    self.regT.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.regT];
    
    self.reg = [[UITextField alloc] init];
    self.reg.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:self.reg];
    
    self.testStringT = [[UILabel alloc] init];
    self.testStringT.text = @"文案";
    self.testStringT.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.testStringT];
    
    self.testString = [[UITextField alloc] init];
    self.testString.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:self.testString];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setTitle:@"确认" forState:UIControlStateNormal];
    self.btn.backgroundColor = [UIColor redColor];
    [self.btn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.regT.frame = CGRectMake(15, 100, 50, 50);
    self.reg.frame = CGRectMake(80, 100, 200, 50);
    
    self.testStringT.frame = CGRectMake(15, 200, 50, 50);
    self.testString.frame = CGRectMake(80, 200, 200, 50);
    
    self.btn.frame = CGRectMake(30, 300, 50, 30);
    
}

- (void)confirm:(id)sender {
    NSString *testPath = [self.reg.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *testCurrent = [self.testString.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSPredicate *pathRegex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", testPath];
    NSLog(@"%@ %@", testPath, testCurrent);
    if ([pathRegex evaluateWithObject:testCurrent]) {
        NSLog(@"YES");
    } else {
        NSLog(@"NO");
    }
}


@end
