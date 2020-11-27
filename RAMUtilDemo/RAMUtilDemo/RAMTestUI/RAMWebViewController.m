//
//  RAMWebViewController.m
//  RAMUtilDemo
//
//  Created by rambo on 2020/6/5.
//  Copyright © 2020 裘俊云. All rights reserved.
//

#import "RAMWebViewController.h"
#import <WebKit/WebKit.h>
#import <RAMUtil/RAMMacros.h>

@interface RAMWebViewController ()
@property (nonatomic, strong) WKWebView *wkWebview;

@end

@implementation RAMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.wkWebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, RAMScreenWidth, RAMScreenHeight)];
    [self.view addSubview:self.wkWebview];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.wkWebview loadRequest:request];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
