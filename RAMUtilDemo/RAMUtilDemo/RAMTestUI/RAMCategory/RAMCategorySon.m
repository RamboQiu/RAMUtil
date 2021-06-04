//
//  RAMCategorySon.m
//  RAMUtilDemo
//
//  Created by rambo on 2021/6/4.
//  Copyright © 2021 裘俊云. All rights reserved.
//

#import "RAMCategorySon.h"
#import "RAMCategoryFather+RAMCategory.h"

@implementation RAMCategorySon
- (void)sonEat {
    NSLog(@"son eat meet.");
}

//- (void)tegotherEat {
//    NSLog(@"儿子说一起吃");
//}

- (void)drinkWater {
    [super drinkWater];
    NSLog(@"儿子喝水");
}

- (NSString *)test {
    NSString *supT = super.test;
    super.test = [NSString stringWithFormat:@"儿子帮%@", supT];
    return super.test;
}
@end
