#import "UIView+Frame.h"
#import <objc/runtime.h>

static char kUIViewFrameOriginalColorKey;
#define kWrongBackgroundColor [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5]

@implementation UIView (Frame)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
    [self changeColorForFrame:frame];
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
    [self changeColorForFrame:frame];
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
    [self changeColorForFrame:frame];
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    [self changeColorForFrame:frame];
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    [self changeColorForFrame:frame];
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    [self changeColorForFrame:frame];
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
    [self changeColorForFrame:frame];
}

- (CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)tail {
    return CGRectGetMaxX(self.frame);
}

- (void)setTail:(CGFloat)tail {
    CGRect frame = self.frame;
    frame.origin.x = tail - frame.size.width;
    self.frame = frame;
    [self changeColorForFrame:frame];
}

- (void)setMiddleX:(CGFloat)middleX {
    CGRect frame = self.frame;
    frame.origin.x = middleX - frame.size.width / 2;
    self.frame = frame;
    [self changeColorForFrame:frame];
}

- (CGFloat)middleX {
    return CGRectGetMidX(self.frame);
}

- (void)setMiddleY:(CGFloat)middleY {
    CGRect frame = self.frame;
    frame.origin.y = middleY - frame.size.height / 2 ;
    self.frame = frame;
    [self changeColorForFrame:frame];
}

- (CGFloat)middleY {
    return CGRectGetMidY(self.frame);
}

-(BOOL)isProperFrame:(CGRect)frame {
    NSInteger scale = [UIScreen mainScreen].scale;
    if (fabs(scale*frame.origin.x - round(scale*frame.origin.x))> 0.1 || abs(scale*frame.origin.y - round(scale*frame.origin.y)> 0.1 )) {
        return NO;
    } else {
        return YES;
    }
}

-(void)changeColorForFrame:(CGRect)frame {
#ifdef DEBUG
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    if (![build isEqualToString:@"12"]) {
        return;
    }
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"kYXFrameDebug"]) {
        return;
    }
    
    if (![self.backgroundColor isEqual:kWrongBackgroundColor]) {
        self.originalColor = self.backgroundColor;
    }
    if ([self isProperFrame:frame]) {
        self.backgroundColor = self.originalColor;
    } else {
        self.backgroundColor = kWrongBackgroundColor;
    }
#endif
    
}

-(void)ceilFrameXY {
    self.x = ceil(self.x);
    self.y = ceil(self.y);
    [self changeColorForFrame:self.frame];
}

-(UIColor *)originalColor {
    return objc_getAssociatedObject(self, &kUIViewFrameOriginalColorKey);
}

-(void)setOriginalColor:(UIColor *)originalColor {
    objc_setAssociatedObject(self, &kUIViewFrameOriginalColorKey, originalColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
