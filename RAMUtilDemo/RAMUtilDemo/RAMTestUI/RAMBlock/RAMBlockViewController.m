//
//  RAMBlockViewController.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2019/12/4.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import "RAMBlockViewController.h"

/// https://juejin.im/post/5b0181e15188254270643e88
/// https://juejin.im/post/5aefbaf36fb9a07a9e4d2269

typedef void(^Blk_t)(void);


@interface PersonTest : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Blk_t blk;
@end

@implementation PersonTest
- (instancetype)initWithBlock:(Blk_t)block {
    if (self = [super init]) {
        _blk = block;
    }
    return self;
}

- (void)Block:(Blk_t)block {
    _blk = block;
    NSLog(@"====%@",block);
}


- (void)execute {
    _blk();
}

void (^block)(void);

- (void)test {
//    void(^block)(void) = ^{
//        NSLog(@"%@",self.name);
//        NSLog(@"%@",_name);
//    };
//    block();
    
    int a = 10;
    block = ^{
        NSLog(@"block----------%d", a);
    };
}

-(void)dealloc {
    NSLog(@"PersonTest释放了");
}
@end
@interface RAMBlockViewController ()
@property (nonatomic, strong) PersonTest *person;
@property (nonatomic, strong) void (^testblock)(void);
@end

void test()
{
    // __NSStackBlock__
    int a = 10;
    block = ^{
        block = nil;
        NSLog(@"block---------%d", a);
    };
}
@implementation RAMBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.title = self.titleText?:@"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak __typeof__(self) weakSelf = self;
    self.testblock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [strongSelf assertNotDealloc];
        });
    };
    
//    __weak typeof(self) weakSelf = self;
//    _person = [[PersonTest alloc] initWithBlock:^() {
//        [weakSelf doSomething];
//    }];
//    [_person execute];
    
//    _person = [[PersonTest alloc] init];
//    [_person test];
//
//    _person.name = @"test";
//    [_person test];
    
    test();
    block();
    self.testblock();
    
//    __weak __typeof__(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf assertNotDealloc];
    });
}

- (void)assertNotDealloc {
    NSLog(@"");
}


- (void)doSomething {
    NSLog(@"doSomething");
}

- (void)dealloc {
    NSLog(@"dealloc");
}
@end
