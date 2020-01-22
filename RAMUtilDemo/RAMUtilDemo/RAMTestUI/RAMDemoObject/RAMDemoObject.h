//
//  RAMDemoObject.h
//  RAMUtilDemo
//
//  Created by rambo on 2019/11/26.
//  Copyright © 2019 裘俊云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RAMDemoObject : NSObject

@property (nonatomic, strong) NSString *testProperty;
@property (nonatomic, assign) int type;

- (void)test;

+ (instancetype)initWithType:(int)type;
@end

NS_ASSUME_NONNULL_END
