//
//  RAMBridgeManager.h
//  RAMUtilDemo
//
//  Created by rambo on 2021/8/25.
//  Copyright © 2021 裘俊云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface NativeBridgeResponseMessage : NSObject

@property (nonatomic, strong) id _Nullable data;       // 参数 json
@property (nonatomic, assign) NSInteger code;      // 错误码
@property (nonatomic, strong) NSString *message;  // 错误内容

@end

@interface NativeBridgeRequestMessage : NSObject

@property (nonatomic, strong) NSString *handlerName;    // 处理消息的方法名
@property (nonatomic, strong) id _Nullable data; // 参数json

@property (nonatomic, copy) void(^callback)(NativeBridgeResponseMessage *responseMessage);    // 回调

@end

@interface RAMBridgeManager : NSObject

- (BOOL)receiveMessage:(NativeBridgeRequestMessage *)message;

@end

NS_ASSUME_NONNULL_END
