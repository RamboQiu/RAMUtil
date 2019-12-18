//
//  RAMFrameBoundsController.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2019/12/18.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import "RAMFrameBoundsController.h"

@interface RAMFrameBoundsController ()<
UIScrollViewDelegate
>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollview;

@property (nonatomic, strong) UIView *testView;
@property (nonatomic, strong) UIView *testView2;


@property (nonatomic, strong) UIButton *testButton;

@end

@implementation RAMFrameBoundsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleText?:@"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 300, 1000)];
    self.imageView.image = [UIImage imageNamed:@"1"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.scrollview.contentSize = self.imageView.frame.size;
    [self.scrollview addSubview:self.imageView];
    [self.view addSubview:self.scrollview];
    
    self.testView = [[UIView alloc] init];
    self.testView.frame = CGRectMake(15, 250, 200, 200);
    self.testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.testView];
    
    self.testView2 = [[UIView alloc] init];
    self.testView2.frame = CGRectMake(0, 0, 100, 100);
    self.testView2.backgroundColor = [UIColor yellowColor];
    [self.testView addSubview:self.testView2];
    
    self.testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.testButton addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    [self.testButton setTitle:@"测试" forState:UIControlStateNormal];
    [self.testButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:self.testButton];
    self.testButton.frame = CGRectMake(15, 500, 50, 100);
    
    [self.testView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self.testView addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (UIScrollView *)scrollview {
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 100, 300, 100)];
        _scrollview.delegate = self;
    }
    return _scrollview;
}

- (void)dealloc {
    [self.testView removeObserver:self forKeyPath:@"frame"];
    [self.testView removeObserver:self forKeyPath:@"bounds"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"frame"]) {
        NSLog(@"newFrame:%@", [change objectForKey:NSKeyValueChangeNewKey]);
    } else if ([keyPath isEqualToString:@"bounds"]) {
        NSLog(@"newBounds:%@", [change objectForKey:NSKeyValueChangeNewKey]);
    }
}

- (void)test:(id)sender {
    self.testView.bounds = CGRectMake(0, 50, self.testView.bounds.size.width, self.testView.bounds.size.height);
 
//    self.testView.transform = CGAffineTransform;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollview[contentoffset:%@---frame:%@------bounds:%@",
          NSStringFromCGPoint(scrollView.contentOffset),
          NSStringFromCGRect(self.scrollview.frame),
          NSStringFromCGRect(self.scrollview.bounds));
    NSLog(@"imageview[frame:%@------bounds:%@",
          NSStringFromCGRect(self.imageView.frame),
          NSStringFromCGRect(self.imageView.bounds));
}

@end
