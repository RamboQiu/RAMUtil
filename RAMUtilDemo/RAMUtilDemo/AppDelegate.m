//
//  AppDelegate.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2018/12/12.
//  Copyright © 2018 裘俊云. All rights reserved.
//

#import "AppDelegate.h"
#import <WeexSDK/WeexSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // App configuration
    [WXAppConfiguration setAppGroup:@"rambo"];
    [WXAppConfiguration setAppName:@"RAMUtilDemo"];
    [WXAppConfiguration setAppVersion:@"1.0.0"];
    
    //Initialize WeexSDK
    [WXSDKEngine initSDKEnvironment];

    //Register custom modules and components, optional.
//    [WXSDKEngine registerComponent:@"myview" withClass:[MyViewComponent class]];
    [WXSDKEngine registerModule:@"RAMStatistics" withClass:NSClassFromString(@"RAMStatisticsModule")];
    

    //Register the implementation of protocol, optional.
//    [WXSDKEngine registerHandler:[WXAppNavigationImpl new] withProtocol:@protocol(WXNavigationProtocol)];

    //Set the log level, optional
    [WXLog setLogLevel: WXLogLevelWarning];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
