//
//  RAMCodeTestViewController.m
//  RAMUtilDemo
//
//  Created by rambo on 2020/4/26.
//  Copyright © 2020 裘俊云. All rights reserved.
//

#import "RAMCodeTestViewController.h"
#import "RAMWebViewController.h"


@interface RAMCodeTestViewController ()

@end

@implementation RAMCodeTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我跳转苏宁" forState:UIControlStateNormal];
    button.backgroundColor = UIColor.blueColor;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.titleLabel.textColor = UIColor.blackColor;
    [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 200, 100, 40);
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"点我跳转严选" forState:UIControlStateNormal];
    button2.backgroundColor = UIColor.blueColor;
    button2.titleLabel.font = [UIFont systemFontOfSize:14];
    button2.titleLabel.textColor = UIColor.blackColor;
    [button2 addTarget:self action:@selector(test1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    button2.frame = CGRectMake(100, 300, 100, 40);
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"点我测试" forState:UIControlStateNormal];
    button3.backgroundColor = UIColor.blueColor;
    button3.titleLabel.font = [UIFont systemFontOfSize:14];
    button3.titleLabel.textColor = UIColor.blackColor;
    [button3 addTarget:self action:@selector(test2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    button3.frame = CGRectMake(100, 400, 100, 40);
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button4 setTitle:@"点我测试2" forState:UIControlStateNormal];
    button4.backgroundColor = UIColor.blueColor;
    button4.titleLabel.font = [UIFont systemFontOfSize:14];
    button4.titleLabel.textColor = UIColor.blackColor;
    [button4 addTarget:self action:@selector(test3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    button4.frame = CGRectMake(100, 500, 100, 40);
}

- (void)test {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://cuxiao.m.suning.com/scms/m0325phoneapp.html?utm_source=jrtt-as-dy2-o2&utm_medium=ab-tx1-0000-l6-08&utm_campaign=&adTypeCode=1002&adId="]];
}

- (void)test1 {
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"yanxuan://homepage"]];
    NSLog(@"%@", canOpen?@"YES":@"NO");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"yanxuan://"] options:@{} completionHandler:nil];
//    if (canOpen) {
//    } else {
//        RAMWebViewController *webViewController = [[RAMWebViewController alloc] init];
//        webViewController.url = @"http://u.163.com/a/uYqOquY0";
//        [self.navigationController pushViewController:webViewController animated:YES];
//    }
}

- (void)test2 {
    // 获取Documents目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];

    // 获取tmp目录
    NSString *tmpPath = NSTemporaryDirectory();

    // 获取Library目录
    NSString *libPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];

    // 获取Library/Caches目录
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];

    // 获取Library/Preferences目录
    NSString *prePath = [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
    //通常情况下，Preferences由系统维护，我们很少去操作TA

    // 获取应用程序包的路径
    NSString *path = [NSBundle mainBundle].resourcePath;
    
    NSString *fileDicPath = [docPath stringByAppendingPathComponent:@"love1.txt"];


    dispatch_async(dispatch_queue_create("test.11", DISPATCH_QUEUE_CONCURRENT), ^{
        for (int i = 0; i < 1000; i ++) {
            NSDictionary *dic = @{@"key":[NSString stringWithFormat:@"%d", i]};
            BOOL result = [dic writeToFile:fileDicPath atomically:YES];
            NSLog(@"%@", result?@"true":@"false");
        }
    });
    dispatch_async(dispatch_queue_create("test.22", DISPATCH_QUEUE_CONCURRENT), ^{
        for (int i = 0; i < 1000; i ++) {
            NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:fileDicPath];
            NSLog(@"%@", resultDic[@"key"]);
        }
    });
}

- (void)test3 {
    
}

@end
