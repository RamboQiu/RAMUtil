#import "UIColor+RAMHEX.h"

@implementation UIColor (RAM)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(float)aAlpha {
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor clearColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:aAlpha];
}

+ (UIColor *)colorWithHexAlphaColor:(NSString *)colorString {
    UIColor *colorResult = [UIColor clearColor];
    if (colorString.length == 8) {
        CGFloat alpha = 1;
        NSString *alphaString = [colorString substringWithRange:NSMakeRange(0, 2)];
        NSScanner *scanner = [NSScanner scannerWithString:alphaString];
        unsigned int result = 0;
        [scanner scanHexInt:&result];
        
        if (result < 255) {
            alpha = result/255.0;
        } else {
            alpha = 1;
        }
        
        NSString *tempColorString = [colorString substringWithRange:NSMakeRange(2, 6)];
        colorResult = [UIColor colorWithHexString:tempColorString alpha:alpha];
    } else if (colorString.length == 6) {
        colorResult = [UIColor colorWithHexString:colorString alpha:1];
    }
    return colorResult;
}

@end
