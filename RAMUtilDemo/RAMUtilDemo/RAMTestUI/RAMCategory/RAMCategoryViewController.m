//
//  RAMCategoryViewController.m
//  RAMUtilDemo
//
//  Created by rambo on 2021/6/4.
//  Copyright © 2021 裘俊云. All rights reserved.
//

#import "RAMCategoryViewController.h"
#import "RAMCategoryFather.h"
#import "RAMCategorySon.h"
#import "RAMCategoryFather+RAMCategory.h"
#import "RAMCategorySon+RAMCategory.h"

@interface RAMCategoryViewController ()

@property (nonatomic, strong) RAMCategoryFather *father;
@property (nonatomic, strong) RAMCategorySon *son;
@end

@implementation RAMCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.father = RAMCategoryFather.new;
    self.son = RAMCategorySon.new;
}

- (void)testAction:(id)sender {
    [self.father fatherEat];
    [self.father tegotherEat];
    [self.son tegotherEat];
    [self.son sonEat];
    NSLog(@"----------华丽的分割线----------");
    [self.son drinkWater];
    NSLog(@"%@", self.son.test);
}


@end
