//
//  RAMNativeBridgeWeex.m
//  RAMUtilDemo
//
//  Created by rambo on 2021/8/25.
//  Copyright © 2021 裘俊云. All rights reserved.
//

#import "RAMNativeBridgeWeex.h"
#import "RAMBridgeManager.h"

@interface RAMNativeBridgeWeex ()
@property (nonatomic, strong) RAMBridgeManager *moduleManager;


@end

@implementation RAMNativeBridgeWeex

- (instancetype)init {
    if (self = [super init]) {
        _moduleManager = [[RAMBridgeManager alloc] init];
    }
    return self;
}

// 模拟weex的收到消息
- (void)test:(NSDictionary *)messageData {
//    messageData to NativeBridgeRequestMessage
    NativeBridgeRequestMessage *message = NativeBridgeRequestMessage.new;
    message.handlerName = @"bridge_share";
    message.data = @{@"type":@"wechat"};
    message.callback = ^(NativeBridgeResponseMessage * _Nonnull responseMessage) {
        NSLog(@"%@", responseMessage.message);
    };
    [self.moduleManager receiveMessage:message];
}

@end
