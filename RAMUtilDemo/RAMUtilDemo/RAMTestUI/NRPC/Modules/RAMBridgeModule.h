//
//  RAMBridgeModule.h
//  RAMUtilDemo
//
//  Created by rambo on 2021/8/25.
//  Copyright © 2021 裘俊云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^NativeBridgeCallback)(id _Nullable data, NSError* _Nullable error);
typedef void (^NativeBridgeHandler)(id data, NativeBridgeCallback responseCallback);

#define NativeBridgeMessaggeSuffix @":nativeBidgeResponseCallback:"
#define NativeBridgeEventSuffix @"NativeBidgeEvent:"


#define RAM_EXPORT_HANDLER(handlerName) \
- (void)handlerName:(id)data nativeBidgeResponseCallback:(NativeBridgeCallback)responseCallback

@interface RAMBridgeModule : NSObject

@end

NS_ASSUME_NONNULL_END
