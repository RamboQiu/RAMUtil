#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property (nonatomic , assign) UIColor *originalColor;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat tail;
@property (nonatomic, assign) CGFloat middleX;
@property (nonatomic, assign) CGFloat middleY;

/// 设置uiview x,y为整数值
-(void)ceilFrameXY;

///  判断frame是否存在反锯齿
-(BOOL)isProperFrame:(CGRect)frame;

@end
