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

- (void)test33 {
    NSArray<NSNumber *> *arcArr = @[@(75), @(25)];
    NSArray<UIColor *> *colorArr = @[[UIColor colorWithRed:0 green:0 blue:255.0f alpha:1], [UIColor greenColor]];
    CGFloat startAngle = - M_PI_2;
    CGFloat radius = 100;
    CGPoint center = CGPointMake(200, 300);
    for (NSInteger i = 0; i < arcArr.count; i++) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.fillColor = colorArr[i].CGColor;
        CGFloat value = [arcArr[i] floatValue];
        CGFloat angle = value/100*2*M_PI;
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:center];
        CGPoint startPoint = CGPointMake(center.x + radius*cos(startAngle), center.y + radius*sin(startAngle));
        [bezierPath addLineToPoint:startPoint];
        [bezierPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:angle+startAngle clockwise:YES];
        [bezierPath closePath];
        shapeLayer.path = bezierPath.CGPath;
        [self.view.layer addSublayer:shapeLayer];

        startAngle += angle;
    }
}

- (void)test3 {
    CGFloat radius = 100;
    CGFloat innerRadius = radius/2.61803f;
    CGFloat startAngle = - M_PI_2;
    CGPoint center = CGPointMake(200, 300);
    CGFloat offsetAngle = M_PI / 5;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    CGPoint startPoint = CGPointMake(center.x + radius*cos(startAngle), center.y + radius*sin(startAngle));
    [bezierPath moveToPoint:startPoint];
    for (int i = 1; i < 10; i ++) {
        CGFloat tmpRadius = i % 2 == 0 ? radius : innerRadius;
        startAngle += offsetAngle;
        CGPoint point = CGPointMake(center.x + tmpRadius*cos(startAngle), center.y + tmpRadius*sin(startAngle));
        [bezierPath addLineToPoint:point];
    }

    [bezierPath closePath];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 1;
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor = UIColor.clearColor.CGColor;
    shapeLayer.strokeColor = UIColor.redColor.CGColor;
    [self.view.layer addSublayer:shapeLayer];
    
    NSLog(@"%ld", (long)[self test:@[@(-5),@(-2),@(1),@(-4)]]);
}

- (NSInteger)test:(NSArray<NSNumber *> *)nums {
    NSAssert(nums.count != 0, @"");
    NSInteger sum = 0;
    NSInteger max = NSIntegerMin;
    for (NSNumber *num in nums) {
        sum += [num integerValue];
        if (max < sum) {
            max = sum;
        }
        if (sum < 0) {
            sum = 0;
        }
    }
    return max;
}


// 给出一个含有正负数的数组，找到其中和最大的一段数据

//int maxSubArray(int[] nums) {
//    int sum = 0;
//    int max = Integer.MIN_VALUE;
//    for (int num : nums) {
//        sum += num;
//
//        if (max < sum) {
//            max = sum;
//        }
//
//        if (sum < 0) {
//            sum = 0;
//        }
//
//
//    }
//    return max;
//}

//public static int findGreatestSumOfSubArray(int[] arr) {
//        // 参数校验
//        if (arr == null || arr.length < 1) {
//            throw new IllegalArgumentException("Array must contain an element");
//        }
//
//        // 记录最大的子数组和，开始时是最小的整数
//        int max = Integer.MIN_VALUE;
//        // 当前的和
//        int curMax = 0;
//        // 数组遍历
//        for (int i : arr) {
//            // 如果当前和小于等于0，就重新设置当前和
//            if (curMax <= 0) {
//                curMax = i;
//            }
//            // 如果当前和大于0，累加当前和
//            else {
//                curMax += i;
//            }
//
//            // 更新记录到的最在的子数组和
//            if (max < curMax) {
//                max = curMax;
//            }
//        }
//
//
//        return max;
//    }
@end
