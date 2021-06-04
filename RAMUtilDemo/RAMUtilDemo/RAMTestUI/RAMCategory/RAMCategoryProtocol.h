//
//  RAMCategoryProtocol.h
//  RAMUtilDemo
//
//  Created by rambo on 2021/6/4.
//  Copyright © 2021 裘俊云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RAMCategoryProtocol <NSObject>

@optional
@property (nonatomic, strong) NSString *test;

- (void)drinkWater;
@end

NS_ASSUME_NONNULL_END
