//
//  Person+Swizzling.h
//  runtimeTest
//
//  Created by 裘俊云 on 2019/11/28.
//

#import <AppKit/AppKit.h>


#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (Swizzling)
- (void)originalFunc:(NSString *)arg1 :(NSString *)arg2;
@end

NS_ASSUME_NONNULL_END
