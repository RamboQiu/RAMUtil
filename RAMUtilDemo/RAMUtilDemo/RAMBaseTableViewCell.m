//
//  RAMBaseTableViewCell.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2018/12/24.
//  Copyright © 2018 裘俊云. All rights reserved.
//

#import "RAMBaseTableViewCell.h"
#import <RAMUtil/UIView+Frame.h>

@interface RAMBaseTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@end

@implementation RAMBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel = UILabel.new;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
        
        _descLabel = UILabel.new;
        _descLabel.font = [UIFont systemFontOfSize:12];
        _descLabel.textColor = [UIColor grayColor];
        _descLabel.numberOfLines = 0;
        [self.contentView addSubview:_descLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.x = 15;
    _titleLabel.y = 10;
    
    _descLabel.x = 15;
    _descLabel.y = _titleLabel.bottom + 5;
}

- (void)setModel:(RAMCellModel *)model {
    _model = model;
    if (_model) {
        _titleLabel.text = model.title?:@"";
        [_titleLabel sizeToFit];
        
        _descLabel.text = model.desc?:@"";
        _descLabel.width = [UIScreen mainScreen].bounds.size.width - 30;
        [_descLabel sizeToFit];
        
        [self layoutSubviews];
        [self layoutIfNeeded];
    }
}

+ (CGFloat)cellHeightWithModel:(RAMCellModel *)model {
    CGFloat height = 20;
    UILabel *descTmp = UILabel.new;
    descTmp.font = [UIFont systemFontOfSize:14];
    descTmp.text = model.title?:@"";
    [descTmp sizeToFit];
    height += descTmp.height;
    
    descTmp.numberOfLines = 0;
    descTmp.font = [UIFont systemFontOfSize:12];
    descTmp.text = model.desc?:@"";
    descTmp.width = [UIScreen mainScreen].bounds.size.width - 30;
    [descTmp sizeToFit];
    height += descTmp.height;
    
    return height;
}

@end
