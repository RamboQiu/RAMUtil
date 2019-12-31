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

-(void)dealloc {
    NSLog(@"PersonTest释放了");
}
@end
@interface RAMBlockViewController ()
@property (nonatomic, strong) PersonTest *person;
@end

@implementation RAMBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.title = self.titleText?:@"";
    self.view.backgroundColor = [UIColor whiteColor];
    
//    __weak typeof(self) weakSelf = self;
//    _person = [[PersonTest alloc] initWithBlock:^() {
//        [weakSelf doSomething];
//    }];
//    [_person execute];
}


- (void)doSomething {
    NSLog(@"doSomething");
}

- (void)dealloc {
    NSLog(@"dealloc");
}
@end
