//
//  RAMCellModel.h
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2018/12/24.
//  Copyright © 2018 裘俊云. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RAMCellModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *classStr;

- (instancetype)initWithTitle:(NSString *)title
                         desc:(NSString *)desc;
@end
