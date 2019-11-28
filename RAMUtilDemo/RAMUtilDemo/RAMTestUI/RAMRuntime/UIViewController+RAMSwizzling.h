//
//  UIViewController+RAMSwizzling.h
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2019/11/28.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (RAMSwizzling)
- (void)originalFunction;
@end

NS_ASSUME_NONNULL_END
