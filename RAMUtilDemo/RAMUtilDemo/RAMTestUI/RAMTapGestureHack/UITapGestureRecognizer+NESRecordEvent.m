//
//  UITapGestureRecognizer+NESRecordEvent.m
//  NEStatistics
//
//  Created by 裘俊云 on 2018/3/13.
//

#import "UITapGestureRecognizer+NESRecordEvent.h"
#import "NSObject+NESRunTime.h"
//#import "UIView+NESHierarchy.h"
//#import "NEStatistics.h"
//#import "NESPathPersistency.h"

@implementation UITapGestureRecognizer (NESRecordEvent)
+ (void)load {
    [self nes_swizzleInstanceMethod:@selector(initWithTarget:action:) to:@selector(nes_initWithTarget:action:)];
//    [self nes_swizzleInstanceMethod:@selector(setDelegate:) to:@selector(nes_setDelegate:)];
}

- (instancetype)nes_initWithTarget:(nullable id)target action:(nullable SEL)action {
    UITapGestureRecognizer *tmp = [self nes_initWithTarget:self action:@selector(nes_gestureAction:)];
//    tmp.delegate = self;
    [tmp addTarget:target action:action];
    return tmp;
//    if ([NESPathPersistency.sharedInstance globalHackSwitch]) {
//    } else {
//        return [self nes_initWithTarget:target action:action];
//    }
}

- (void)nes_gestureAction:(UIGestureRecognizer *)recognizer {
    if ([recognizer.view isKindOfClass:[UITextField class]]) {
        return;
    }
    NSLog(@"%@", recognizer.view);
//    [NEStatistics.sharedInstance recordView:recognizer.view];
}


//- (void)nes_setDelegate:(id<UIGestureRecognizerDelegate>)delegate {
//    if (![self nes_isContainSel:GET_CLASS_CUSTOM_SEL(@selector(gestureRecognizerShouldBegin:),[delegate class]) inClass:[delegate class]]) {
//        [(UITapGestureRecognizer *)self nes_gestureRecognizerShouldBeginInClass:delegate];
//    }
//    [self nes_setDelegate:delegate];
//
//}
//
//- (void)nes_gestureRecognizerShouldBeginInClass:(id)object {
//    SEL sel = @selector(gestureRecognizerShouldBegin:);
//
//    class_addMethod([object class],
//                    GET_CLASS_CUSTOM_SEL(sel,[object class]),
//                    method_getImplementation(class_getInstanceMethod([self class],@selector(nes_imp_gestureRecognizerShouldBegin:))),
//                    "v@:@@");
//
//    if ([self nes_isContainSel:sel inClass:[object class] ]) {
//        [object nes_swizzleInstanceMethod:sel to:GET_CLASS_CUSTOM_SEL(sel,[object class])];
//    }
//
//}
//
//
//- (BOOL)nes_imp_gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
////    NSArray<NSString *> *callStackSymbols = [NSThread callStackSymbols];
////    NSString *projectPrefix = [NSString stringWithFormat:@"[%@", NESConfig.sharedInstance.projectPrefix?:@""];
////    if ([callStackSymbols[1] containsString:projectPrefix]) {
////        SEL sel = GET_CLASS_CUSTOM_SEL(@selector(gestureRecognizerShouldBegin:),[self class]);
////        if ([self respondsToSelector:sel]) {
////            IMP imp = [self methodForSelector:sel];
////            BOOL (*func)(id, SEL,id) = (BOOL *)imp;
////            return func(self, sel,gestureRecognizer);
////        }
////    }
////    [NEStatistics.sharedInstance recordView:gestureRecognizer.view];
//    NSLog(@"%@", gestureRecognizer.view);
//
//    SEL sel = GET_CLASS_CUSTOM_SEL(@selector(gestureRecognizerShouldBegin:),[self class]);
//    if ([self respondsToSelector:sel]) {
//        IMP imp = [self methodForSelector:sel];
//        BOOL (*func)(id, SEL,id) = (BOOL *)imp;
//        return func(self, sel,gestureRecognizer);
//    } else {
//        return NO;
//    }
////    if (!NESCommon.sharedInstance.vision) {
////    } else {
////        return NO;
////    }
//}
//
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    return YES;//!NESCommon.sharedInstance.vision;
//}
@end
