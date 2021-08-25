//
//  RAMBridgeStatisticsModule.m
//  RAMUtilDemo
//
//  Created by rambo on 2021/8/25.
//  Copyright © 2021 裘俊云. All rights reserved.
//

#import "RAMBridgeStatisticsModule.h"

@implementation RAMBridgeStatisticsModule


RAM_EXPORT_HANDLER(bridge_statistics) {
    if(!responseCallback) { return; }
    NSString *type = data[@"type"];
    NSLog(@"%@", type);
    NSMutableDictionary *reponse = NSMutableDictionary.new;
    responseCallback(reponse, nil);
}

@end
