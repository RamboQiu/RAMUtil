//
//  RAMRuntimeViewController.m
//  RAMUtilDemo
//
//  Created by rambo on 2019/11/27.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import "RAMRuntimeViewController.h"
#import <objc/runtime.h>
#import "UIViewController+RAMSwizzling.h"
#import <RAMUtil/UIView+Frame.h>
#import "UIViewController+RAMPointerSwizzling.h"

@interface XXObject : NSObject

- (void)hello;

@end

@implementation XXObject

- (void)hello {
    NSLog(@"HelloXX");
    NSLog(@"%p", @selector(hello));
}

@end

@interface YYObject : NSObject

- (void)hello;

@end

@implementation YYObject

- (void)hello {
    NSLog(@"HelloYY");
    NSLog(@"%p", @selector(hello));
}

@end

@interface RAMRuntimeViewController ()
@property (nonatomic, strong) UIButton *button;

@end

@implementation RAMRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleText?:@"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.button setTitle:@"点我点我，详细查看项目中的objc源码" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    
    id lengderClass = object_getClass(@"UIView");
    unsigned int outCount, i;
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList(lengderClass, &outCount);
    for (i = 0; i<outCount; i++) {
        Ivar ivar = ivarList[i];
        fprintf(stdout, "Ivar: %s \n", ivar_getName(ivar));
    }
    //获取实例方法列表
    Method *methodList = class_copyMethodList(lengderClass, &outCount);
    for (i = 0; i<outCount; i++) {
        Method method = methodList[i];
        NSLog(@"instanceMethod: %@", NSStringFromSelector(method_getName(method)));
    }
    //获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(lengderClass, &outCount);
    for (i=0; i<outCount; i++) {
        Protocol *protocol = protocolList[i];
        fprintf(stdout, "protocol：%s \n", protocol_getName(protocol));
    }
    
    //获取属性列表
    objc_property_t *properties = class_copyPropertyList(lengderClass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        //第二个输出为属性特性，包含类型编码、读写权限等
        fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
    }
    
//    class_
    
    //注意释放
    free(ivarList);
    free(methodList);
    free(protocolList);
    free(properties);
    
    [self performSelector:@selector(fun)];
    
    NSLog(@"-----------选择子-----");
    
    XXObject *objectXX = [[XXObject alloc] init];
    [objectXX hello];
    YYObject *objectYY = [[YYObject alloc] init];
    [objectYY hello];
    
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(fun)) {
        class_addMethod([self class], sel, (IMP)funMethod, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

void funMethod(id obj, SEL _cmd) {
    NSLog(@"funMethod"); //新的 fun 函数
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.button.width = 100;
    self.button.height = 50;
    self.button.middleX = self.view.width / 2;
    self.button.middleY = self.view.height / 2;
}

- (void)testAction:(id)sender {
    [self originalFunction];
    [self originalFunc:@"arg1"];
}
@end
