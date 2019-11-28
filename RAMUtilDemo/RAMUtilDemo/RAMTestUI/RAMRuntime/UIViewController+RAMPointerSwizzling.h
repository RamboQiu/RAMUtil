//
//  UIViewController+RAMPointerSwizzling.h
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2019/11/28.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (RAMPointerSwizzling)
- (void)originalFunc:(NSString *)arg1;
@end

NS_ASSUME_NONNULL_END
