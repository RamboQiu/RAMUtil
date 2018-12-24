//
//  RAMBaseTableViewCell.h
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2018/12/24.
//  Copyright © 2018 裘俊云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAMCellModel.h"

@interface RAMBaseTableViewCell : UITableViewCell
@property (nonatomic, strong) RAMCellModel *model;

+ (CGFloat)cellHeightWithModel:(RAMCellModel *)model;
@end
