#import <Foundation/Foundation.h>

@interface UIColor (RAMHEX)

/// [UIColor colorWithHexString:@"151515" alpha:1]
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(float)aAlpha;

+ (UIColor *)colorWithHexAlphaColor:(NSString *)colorString;

@end
