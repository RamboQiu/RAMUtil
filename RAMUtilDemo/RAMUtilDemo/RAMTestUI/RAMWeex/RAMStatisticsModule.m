//
//  RAMStatisticsModule.m
//  RAMUtilDemo
//
//  Created by rambo on 2021/8/9.
//  Copyright © 2021 裘俊云. All rights reserved.
//

#import "RAMStatisticsModule.h"

@implementation RAMStatisticsModule
@synthesize weexInstance;

//+ (NSString *)wx_export_method_15 { return NSStringFromSelector(@selector(recordEvent:)); }
WX_EXPORT_METHOD(@selector(recordEvent:))

-(void)recordEvent:(NSString *)event {
    NSLog(@"[Weex Module] %@", event);
}

@end
