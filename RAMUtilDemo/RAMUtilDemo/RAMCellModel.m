//
//  RAMCellModel.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2018/12/24.
//  Copyright © 2018 裘俊云. All rights reserved.
//

#import "RAMCellModel.h"

@implementation RAMCellModel
- (instancetype)initWithTitle:(NSString *)title
                         desc:(NSString *)desc {
    if (self = [super init]) {
        _title = title;
        _desc = desc;
    }
    return self;
}
@end
