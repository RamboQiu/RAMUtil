//
//  RAMUIEventChainViewController.m
//  RAMUtilDemo
//
//  Created by rambo on 2019/11/25.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import "RAMUIEventChainViewController.h"
#import <RAMUtil/UIView+Frame.h>
#import <RAMUtil/UIColor+RAMHEX.h>

@interface RAMDemoView : UIView
@property (nonatomic, strong) UILabel *title;
@end

@implementation RAMDemoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _title = UILabel.new;
        _title.font = [UIFont systemFontOfSize:12];
        _title.textColor = [UIColor grayColor];
        [self addSubview:_title];
        
        self.backgroundColor = [UIColor randomRGBColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_title sizeToFit];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *bo = [super hitTest:point withEvent:event];
    NSLog(@"%@:%@:%@",self.title.text, bo, NSStringFromSelector(_cmd));
    return bo;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@:%@",self.title.text, NSStringFromSelector(_cmd));
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL bo = [super pointInside:point withEvent:event];
    NSLog(@"%@:%@:%@",self.title.text, bo?@"YES":@"NO", NSStringFromSelector(_cmd));
    return bo;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@",self.title.text];
}

@end

@interface RAMUIEventChainViewController ()

@end

@implementation RAMUIEventChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleText?:@"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    RAMDemoView *view1 = RAMDemoView.new;
    view1.title.text = @"A";
    [self.view addSubview:view1];
    view1.x = 100;
    view1.y = 100;
    view1.width = 200;
    view1.height = 300;
    
    
    RAMDemoView *view2 = RAMDemoView.new;
    view2.title.text = @"B";
    [self.view addSubview:view2];
    view2.x = 150;
    view2.y = 150;
    view2.width = 100;
    view2.height = 100;
    
    
    RAMDemoView *view21 = RAMDemoView.new;
    view21.title.text = @"B1";
    [view2 addSubview:view21];
    view21.x = 10;
    view21.y = 10;
    view21.width = 50;
    view21.height = 50;
    
    
    RAMDemoView *view3 = RAMDemoView.new;
    view3.title.text = @"C";
    [self.view addSubview:view3];
    view3.x = 150;
    view3.y = 260;
    view3.width = 100;
    view3.height = 100;
    
    RAMDemoView *view31 = RAMDemoView.new;
    view31.title.text = @"C1";
    [view3 addSubview:view31];
    view31.x = 10;
    view31.y = 10;
    view31.width = 30;
    view31.height = 30;
    
    
    RAMDemoView *view32 = RAMDemoView.new;
    view32.title.text = @"C2";
    [view3 addSubview:view32];
    view32.x = 50;
    view32.y = 50;
    view32.width = 100;
    view32.height = 100;
    
    
}


@end
