#import <Foundation/Foundation.h>

#if __LP64__
#define NSI "ld"
#define NSU "lu"
#else
#define NSI "d"
#define NSU "u"
#endif

#pragma mark - System Utilities

#ifndef IS_IOS7_OR_LATER
#define IS_IOS7_OR_LATER        (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1)
#endif

#ifndef NSFoundationVersionNumber_iOS_7_1
#define NSFoundationVersionNumber_iOS_7_1 1047.25
#endif

#ifndef IS_IOS8_OR_LATER
#define IS_IOS8_OR_LATER        (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_7_1)
#endif

#ifndef SystemVersionlowerThan
#define SystemVersionlowerThan(version) ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedAscending)
#endif

#ifndef SystemVersionHigherThanOrEqualTo
#define SystemVersionHigherThanOrEqualTo(version) ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] != NSOrderedAscending)
#endif

#pragma mark - Screen Utilities

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH            ([[UIScreen mainScreen] bounds].size.width)
#endif

#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT           ([[UIScreen mainScreen] bounds].size.height)
#endif

#ifndef SCREEN_MAX_LENGTH
#define SCREEN_MAX_LENGTH       (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#endif

#ifndef SCREEN_MIN_LENGTH
#define SCREEN_MIN_LENGTH       (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#endif


#pragma mark - Device Utilities

#ifndef IS_IPHONE
#define IS_IPHONE               ([[[UIDevice currentDevice] model] rangeOfString:@"Phone"].location!=NSNotFound)
#endif

#ifndef IS_IPAD
#define IS_IPAD                 ([[[UIDevice currentDevice] model] rangeOfString:@"Pad"].location!=NSNotFound)
#endif

#ifndef IS_IPHONE5_OR_LATER
#define IS_IPHONE5_OR_LATER     ([[UIScreen mainScreen] bounds].size.height>=568.f)
#endif

#ifndef IS_IPHONE6_OR_LATER
#define IS_IPHONE6_OR_LATER     ([[UIScreen mainScreen] bounds].size.height>=667.f)
#endif

#ifndef IS_IPHONE4
#define IS_IPHONE4              (IS_IPHONE && (SCREEN_MAX_LENGTH<568.f))
#endif

#ifndef IS_IPHONE5
#define IS_IPHONE5              (IS_IPHONE && (SCREEN_MAX_LENGTH==568.f))
#endif

#ifndef IS_IPHONE6
#define IS_IPHONE6              (IS_IPHONE && (SCREEN_MAX_LENGTH==667.f))
#endif

#ifndef IS_IPHONE6P
#define IS_IPHONE6P             (IS_IPHONE && (SCREEN_MAX_LENGTH==736.f))
#endif

#ifndef IS_IPHONEX
#define IS_IPHONEX             (IS_IPHONE && (SCREEN_MAX_LENGTH==812.f || SCREEN_MAX_LENGTH==896.f))
#endif

#pragma mark - Colors Utilities

#ifndef HEX_COLOR_A
#define HEX_COLOR_A(c, a)       ([UIColor colorWithRed:((c>>16)&0xFF)/255.f green:((c>>8)&0xFF)/255.f blue:(c&0xFF)/255.f alpha:a])
#endif

#ifndef HEX_COLOR
#define HEX_COLOR(c)            (HEX_COLOR_A(c, 1.f))
#endif

#ifndef RGB_COLOR
#define RGB_COLOR(r,g,b,a)      ([UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a])
#endif


#pragma mark - Image Reletate

#pragma mark - Log Utilities

#ifndef TIKI
#define TIKI                    NSDate *startDate = [NSDate date]
#endif

// TAKA(@"method name");
#ifndef TAKA
#define TAKA(a)                 NSLog(@"%@ cost: %.2f ms", a, -[startDate timeIntervalSinceNow]*1000)
#endif


#pragma mark - Strong-Weak Dance

#ifndef WEAKIFY_SELF
#define WEAKIFY_SELF            __weak __typeof__(self) weakSelf = self
#endif

#ifndef STRONGIFY_SELF
#define STRONGIFY_SELF          __strong __typeof__(weakSelf) strongSelf = weakSelf
#endif


#pragma mark - Degrees and Radians

#ifndef RADIANS_TO_DEGREES
#define RADIANS_TO_DEGREES(r)   ((r) * (180.0 / M_PI))
#endif

#ifndef DEGREES_TO_RADIANS
#define DEGREES_TO_RADIANS(a)   ((a) / 180.0 * M_PI)
#endif

#pragma mark - Plist related

#ifndef APP_VERSION
#define APP_VERSION             ([[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"])
#endif

#ifndef APP_BUILD_NUMBER
#define APP_BUILD_NUMBER        ([[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"])
#endif

#ifndef APP_DISPLAY_NAME
#define APP_DISPLAY_NAME        ([[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"])
#endif

#define RAMSingletonMethod (instancetype) sharedInstance {static dispatch_once_t onceToken; static id singleton = nil; dispatch_once(&onceToken, ^{ singleton = [self new];}); return singleton;}


#pragma mark - View related


#ifndef VIEW_ROUND_ANGLE
#define VIEW_ROUND_ANGLE(v,r)  v.layer.cornerRadius = r; v.layer.masksToBounds = YES;
#define ALERT_ROUND_ANGLE(v)   VIEW_ROUND_ANGLE(v,4)
#endif

#pragma mark -

#define RAMButtonCornerRadius            2.0
#define RAMStatusBarHeight               (IS_IPHONEX?44.0:20.0)
#define RAMNavigationBarHeight           44.0
#define RAMTopOffset                     (RAMStatusBarHeight + RAMNavigationBarHeight)
#define RAMBottomOffset                  (_RAMBottomOffset())
#define RAMLeftMargin                    15
#define RAMTabbarHeight                  49.0
#define RAMScreenHeight                  [UIScreen mainScreen].bounds.size.height
#define RAMScreenWidth                   [UIScreen mainScreen].bounds.size.width
#define RAMScreenSize                    [UIScreen mainScreen].bounds.size
#define RAMScreenBounds                  [UIScreen mainScreen].bounds
#define RAM_SINGLE_LINE_WIDTH            (1.0/[UIScreen mainScreen].scale)
#define RAM_SINGLE_LINE_ADJUST_OFFSET    ((1.0/[UIScreen mainScreen].scale)/2)

#define RAMStatusBarHeightOfIncall        ([UIApplication sharedApplication].statusBarFrame.size.height-20)

#define kHomePageTopOffset (RAMNavigationBarHeight + RAMHomePageHeaderSegmentsViewHeight+RAMStatusBarHeight)


CGFloat RAMScaledSize(CGFloat width);
///等比例的调整，主要兼容iPad下的适配，例如图片宽度为屏幕宽度，高度要自适应，需使用这个
CGFloat RAMScaledRatioSize(CGFloat width);
CGFloat RAMScaledHeight(CGFloat h);
CGFloat RAMHandlePixel(CGFloat pixel);

CGFloat _RAMBottomOffset();
