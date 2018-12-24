//
//  RAMExportViewController.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2018/12/24.
//  Copyright © 2018 裘俊云. All rights reserved.
//

#import "RAMExportViewController.h"

@interface RAMExportViewController ()
@property (nonatomic, strong) UITextView *descView;
@end

@implementation RAMExportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleText?:@"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _descView = [[UITextView alloc] init];
    [self.view addSubview:_descView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    _descView.frame = self.view.bounds;
}


@end
