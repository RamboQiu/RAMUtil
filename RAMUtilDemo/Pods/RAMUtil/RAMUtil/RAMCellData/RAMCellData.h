
#import <Foundation/Foundation.h>

@interface RAMCellData : NSObject
@property (nonatomic, copy) Class cellClass;
/// cell构造方法
@property (nonatomic, assign) SEL cellCustomSEL;
/// cell点选方法
@property (nonatomic, assign) SEL cellSelectSEL;

@property (nonatomic, assign) CGFloat cellHeight;
/// 填充cell的model，用在cellForRow中
@property (nonatomic, strong) id model;
/// 一般可以使用 NSStringFromClass(self.class)
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, assign) NSInteger tag;
/// 当前cell锁在的section
@property (nonatomic, assign) CGFloat sectionHeaderHeight;
@property (nonatomic, assign) CGFloat sectionFooterHeight;
/// 勾选的时候需要使用到的didSelModel，如果没有一般是用model
@property (nonatomic, strong) id didSelModel;
@end
