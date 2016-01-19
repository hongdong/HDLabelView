//
//  HDLabelViewCell.m
//  HDLabelView
//
//  Created by 洪东 on 16/1/19.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "HDLabelViewCell.h"
#import "HDLabelViewConfig.h"

@interface HDLabelViewCell ()

@property (nonatomic,strong) UILabel *titleLabel;


@end

@implementation HDLabelViewCell

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [HDLabelViewConfig sharedHDLabelViewConfig].itemColor;
        _titleLabel.textColor = [HDLabelViewConfig sharedHDLabelViewConfig].textColor;
        _titleLabel.font = [HDLabelViewConfig sharedHDLabelViewConfig].textFont;
        _titleLabel.layer.cornerRadius = [HDLabelViewConfig sharedHDLabelViewConfig].itemCornerRaius;
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)configCellWithTitle:(NSString *)title {
    self.titleLabel.frame = self.bounds;
    self.titleLabel.text = title;
}

@end
