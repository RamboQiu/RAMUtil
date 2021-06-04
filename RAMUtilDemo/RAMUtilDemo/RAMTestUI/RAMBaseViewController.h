//
//  RAMBaseViewController.h
//  RAMUtilDemo
//
//  Created by rambo on 2021/6/4.
//  Copyright © 2021 裘俊云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RAMBaseViewController : UIViewController

@property (nonatomic, strong) NSString *titleText;

- (void)testAction:(id)sender;
@end

NS_ASSUME_NONNULL_END
