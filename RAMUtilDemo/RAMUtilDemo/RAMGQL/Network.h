//
//  Network.h
//  RAMUtilDemo
//
//  Created by rambo on 2021/1/26.
//  Copyright © 2021 裘俊云. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RAMUtilDemo-Swift.h"
//#import "<#header#>"
//#import <Apollo/Apollo-Swift.h>
//#import "Apollo-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface Network : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, strong) RAMSwiftViewController *vc;
@end

NS_ASSUME_NONNULL_END
