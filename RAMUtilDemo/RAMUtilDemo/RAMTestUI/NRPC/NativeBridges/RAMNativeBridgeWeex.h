//
//  RAMNativeBridgeWeex.h
//  RAMUtilDemo
//
//  Created by rambo on 2021/8/25.
//  Copyright © 2021 裘俊云. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface RAMNativeBridgeWeex : NSObject // <WXModuleProtocol>

- (void)test:(NSDictionary *)messageData;

@end

NS_ASSUME_NONNULL_END
