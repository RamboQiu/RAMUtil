//
//  RAMBridgeManager.m
//  RAMUtilDemo
//
//  Created by rambo on 2021/8/25.
//  Copyright © 2021 裘俊云. All rights reserved.
//

#import "RAMBridgeManager.h"
#import <objc/runtime.h>
#import "RAMBridgeModule.h"

@implementation NativeBridgeResponseMessage


@end

@implementation NativeBridgeRequestMessage


@end

static NSMutableDictionary<NSString *, Class> *gMessageModuleClassMap;

@interface RAMBridgeManager ()
@property (nonatomic, strong) NSMutableDictionary *runningModulesMap;

@end

@implementation RAMBridgeManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _runningModulesMap = [NSMutableDictionary new];
                
        if (gMessageModuleClassMap == nil) {
            gMessageModuleClassMap = [NSMutableDictionary new];
            
            int count = objc_getClassList(NULL,0);
            NSMutableArray * moduleClasses = [NSMutableArray new];
            Class *classes = (Class *)malloc(sizeof(Class) * count);
            objc_getClassList(classes, count);
            
            for (int i = 0; i < count; i++) {
                if ([RAMBridgeModule class] == class_getSuperclass(classes[i])) {
                    [moduleClasses addObject:classes[i]];
                }
            }
            free(classes);
            
            for (Class moduleClass in moduleClasses) {
                unsigned int count;
                
                Method *methodList = class_copyMethodList(moduleClass, &count);
                for (unsigned int i = 0; i < count; i++) {
                    Method method = methodList[i];
                    NSString *methodName = NSStringFromSelector(method_getName(method));
                    if ([methodName hasSuffix:NativeBridgeMessaggeSuffix]) {
                        NSArray *components = [methodName componentsSeparatedByString:@":"];
                        NSString *messageName = components.firstObject;
                        if (messageName.length > 0) {
                            [gMessageModuleClassMap setObject:moduleClass forKey:messageName];
                        }
                    }
                }
                free(methodList);
            }
        }
    }
    
    return self;
}


- (BOOL)receiveMessage:(NativeBridgeRequestMessage *)message
{
    NSString *messageName = message.handlerName;
    Class moduleClass = gMessageModuleClassMap[messageName];
    
        
    RAMBridgeModule *nativeModule = [self nativeModuleForClass:moduleClass];
    
    if (!nativeModule) {
        return NO;
    }
    
    NSString *methodString = [NSString stringWithFormat:@"%@%@", messageName, NativeBridgeMessaggeSuffix];
    SEL selector = NSSelectorFromString(methodString);
    NSMethodSignature *signature = [nativeModule methodSignatureForSelector:selector];
    if (!signature) {
        return NO;
    }
    
    id requestData = message.data;
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = nativeModule;
    [invocation setSelector:selector];
    [invocation setArgument:&requestData atIndex:2];
    
    if (message.callback) {
        __weak typeof(self) weakSelf = self;
        NativeBridgeCallback block = ^(id data, NSError* _Nullable error) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf) {
                NativeBridgeResponseMessage *responseMessage = [NativeBridgeResponseMessage new];
                responseMessage.data = data;
                if (error) {
                    responseMessage.code = error.code;
                }
                responseMessage.message = error.localizedDescription;
                message.callback(responseMessage);
            }
        };
        Block_copy((__bridge void *)block);
        [invocation setArgument:&block atIndex:3];
    }
    [invocation invoke];
    
    return YES;

}

- (RAMBridgeModule *)nativeModuleForClass:(Class)moduleClass
{
    if (!moduleClass) {
        return nil;
    }
    if (![moduleClass isSubclassOfClass:[RAMBridgeModule class]]) {
        return nil;
    }
    
    NSString *moduleClassName = NSStringFromClass(moduleClass);
    RAMBridgeModule *nativeModule = [self.runningModulesMap objectForKey:moduleClassName];
    if (nativeModule == nil) {
        nativeModule = [[moduleClass alloc] init];
        [self.runningModulesMap setObject:nativeModule forKey:moduleClassName];
    }
    return nativeModule;
}
@end
