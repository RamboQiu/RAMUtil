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
#import <RAMUtil/UIImage+RAMColor.h>
#import "RAMDemoObject.h"

@interface RAMDemoButton : UIButton

@end

@implementation RAMDemoButton

- (instancetype)init {
    if (self = [super init]) {
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor randomRGBColor]] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor randomRGBColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@-hitTest",self.titleLabel.text);
    UIView *bo = [super hitTest:point withEvent:event];
    NSLog(@"%@-hitTestView:%@",self.titleLabel.text,bo);
    return bo;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@:%@",self.titleLabel.text, NSStringFromSelector(_cmd));
    [super touchesBegan:touches withEvent:event];
    // 优先响应的target之后，touch就不会透传到下一个响应者了，但是不会阻挡响应链的往下透传
//    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@-pointInside",self.titleLabel.text);
    BOOL bo = [super pointInside:point withEvent:event];
    NSLog(@"%@-pointInside:%@",self.titleLabel.text,bo?@"YES":@"NO");
    return bo;
}

- (NSString *)description {
    return self.titleLabel.text;
}

@end

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
        _title.textColor = [UIColor randomRGBColor];
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
    NSLog(@"%@-hitTest",self.title.text);
    UIView *bo = [super hitTest:point withEvent:event];
    NSLog(@"%@-hitTestView:%@",self.title.text,bo);
    return bo;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@:%@",self.title.text, NSStringFromSelector(_cmd));
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@-pointInside",self.title.text);
    BOOL bo = [super pointInside:point withEvent:event];
    NSLog(@"%@-pointInside:%@",self.title.text,bo?@"YES":@"NO");
    return bo;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@",self.title.text];
}

@end

@interface RAMUIEventChainViewController ()
@property (nonatomic, strong) NSMutableArray<RAMDemoObject *> *list;
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
    [view1 addSubview:view2];
    view2.x = 50;
    view2.y = 50;
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
    UITapGestureRecognizer *tapc = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [view3 addGestureRecognizer:tapc];
    [view1 addSubview:view3];
    view3.x = 50;
    view3.y = 160;
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
//    view32.userInteractionEnabled = NO;
    UITapGestureRecognizer *tapc2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//    [view32 addGestureRecognizer:tapc2];
    [view3 addSubview:view32];
    view32.x = 50;
    view32.y = 50;
    view32.width = 100;
    view32.height = 100;
    
    RAMDemoButton *c21Btn = [[RAMDemoButton alloc] init];
    [c21Btn setTitle:@"C21" forState:UIControlStateNormal];
    [c21Btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tapc21 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//    tapc21.cancelsTouchesInView = NO;
//    [c21Btn addGestureRecognizer:tapc21];
    c21Btn.width = 30;
    c21Btn.height = 30;
    c21Btn.x = 20;
    c21Btn.y = 20;
    [view32 addSubview:c21Btn];
    
    RAMDemoView *view211 = RAMDemoView.new;
    view211.title.text = @"C211";
    view211.userInteractionEnabled = NO;
    UITapGestureRecognizer *tapc211 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//    [view211 addGestureRecognizer:tapc211];
    [c21Btn addSubview:view211];
    view211.x = 10;
    view211.y = 0;
    view211.width = 10;
    view211.height = 10;
    
    RAMDemoView *view4 = RAMDemoView.new;
    view4.title.text = @"D";
    [self.view addSubview:view4];
    view4.x = 100;
    view4.y = 500;
    view4.width = 200;
    view4.height = 300;
    
//    self.list = [NSMutableArray array];
//    [self.list addObject:[RAMDemoObject initWithType:1]];
//    [self.list addObject:[RAMDemoObject initWithType:2]];
//    [self.list addObject:[RAMDemoObject initWithType:3]];
//    [self.list addObject:[RAMDemoObject initWithType:4]];
//    [self.list addObject:[RAMDemoObject initWithType:5]];
//    [self.list addObject:[RAMDemoObject initWithType:6]];
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    NSLog(@"%@-Action",sender.view);
}

- (void)clickAction {
    NSLog(@"C21-clickAction");
    
//    for (int i = 0; i < self.list.count; i ++) {
//        RAMDemoObject *tmp = [self.list objectAtIndex:i];
//        if (tmp.type == 2) {
//            [self.list removeObjectAtIndex:i];
//            [self.list insertObject:tmp atIndex:3];
//            break;
//        }
//    }
//    NSLog(@"%@",self.list);
}
@end
