//
//  RAMTapGestureHackViewController.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2019/7/2.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import "RAMTapGestureHackViewController.h"

@interface TmpView : UIView
@property (nonatomic, strong) NSString *title;
@end

@implementation TmpView
- (NSString *)description {
    return [NSString stringWithFormat:@"%@", _title];
}

@end

@interface RAMTapGestureHackViewController () <
UIGestureRecognizerDelegate
>
// blue 1
@property (nonatomic, strong) TmpView *view1;
// yellow 2
@property (nonatomic, strong) TmpView *view2;
// red 2
@property (nonatomic, strong) TmpView *view3;

@property (nonatomic, strong) TmpView *view33;
@end

@implementation RAMTapGestureHackViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleText?:@"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view1 = [[TmpView alloc] init];
    self.view1.backgroundColor = [UIColor blueColor];
    self.view1.title = @"blue";
    [self.view addSubview:self.view1];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized1:)];
    [self.view1 addGestureRecognizer:tapGR];
    
    self.view2 = [[TmpView alloc] init];
    self.view2.backgroundColor = [UIColor yellowColor];
    self.view2.title = @"yellow";
    [self.view addSubview:self.view2];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(tapGestureRecognized2:)];
    [self.view2 addGestureRecognizer:tap];
    
    self.view3 = [[TmpView alloc] init];
    self.view3.backgroundColor = [UIColor redColor];
    self.view3.title = @"red";
    [self.view addSubview:self.view3];
    UITapGestureRecognizer *tap3 = UITapGestureRecognizer.new;
    tap3.delegate = self;
    [tap3 addTarget:self action:@selector(tapGestureRecognized3:)];
    [self.view3 addGestureRecognizer:tap3];
    
    
    self.view33 = [[TmpView alloc] init];
    self.view33.backgroundColor = [UIColor greenColor];
    self.view33.title = @"green";
    [self.view3 addSubview:self.view33];
    UITapGestureRecognizer *tap33 = UITapGestureRecognizer.new;
    tap33.delegate = self;
    [tap33 addTarget:self action:@selector(tapGestureRecognized33:)];
    [self.view33 addGestureRecognizer:tap33];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.view1.frame = CGRectMake(30, 100, 50, 50);
    
    
    self.view2.frame = CGRectMake(30, 200, 50, 50);
    self.view3.frame = CGRectMake(30, 300, 50, 50);
    
    self.view33.frame = CGRectMake(10, 10, 25, 25);
}

- (void)tapGestureRecognized1:(id)sender {
    NSLog(@"tapGestureRecognized1111111");
}

- (void)tapGestureRecognized2:(id)sender {
    NSLog(@"tapGestureRecognized2222222");
}

- (void)tapGestureRecognized3:(id)sender {
    NSLog(@"tapGestureRecognized3333333");
}

- (void)tapGestureRecognized33:(id)sender {
    NSLog(@"tapGestureRecognized33-3333333");
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

@end
