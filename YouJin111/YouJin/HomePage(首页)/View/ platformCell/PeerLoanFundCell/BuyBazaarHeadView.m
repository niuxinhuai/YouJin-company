//
//  BuyBazaarHeadView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BuyBazaarHeadView.h"

@interface BuyBazaarHeadView ()
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *currentLabel;
@property (nonatomic, weak) UILabel *lastLabel;
@end
@implementation BuyBazaarHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 创建基金公司的label
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel = nameLabel;
        // 创建当月的存量的label
        UILabel *currentLabel = [[UILabel alloc] init];
        _currentLabel = currentLabel;
        // 创建显示上月存量的label
        UILabel *lastLabel = [[UILabel alloc] init];
        _lastLabel = lastLabel;
        [self addSubview:nameLabel];
        [self addSubview:currentLabel];
        [self addSubview:lastLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat labelW = 80 * BOScreenW / BOPictureW;
    // 创建基金公司的label
    CGFloat nameX = 17 * BOScreenW / BOPictureW;
    CGFloat nameY = 5 * BOScreenH / BOPictureH;
    CGFloat nameH = 20 * BOScreenH / BOPictureH;
    _nameLabel.frame = CGRectMake(nameX, nameY, labelW, nameH);
    _nameLabel.text = @"网贷基金";
    [_nameLabel setFont:[UIFont systemFontOfSize:12]];
    [_nameLabel setTextColor:BOColor(161, 161, 161)];
    // 创建当月的存量的label
    CGFloat currentX = CGRectGetMaxX(_nameLabel.frame) + 60 * BOPictureW / BOPictureH;
    CGFloat currentY = nameY;
    CGFloat currentH = nameH;
    _currentLabel.frame = CGRectMake(currentX, currentY, labelW, currentH);
    _currentLabel.text = @"本月存量";
    [_currentLabel setFont:[UIFont systemFontOfSize:12]];
    [_currentLabel setTextColor:BOColor(161, 161, 161)];
    // 创建显示上月存量的label
    CGFloat lastX = CGRectGetMaxX(_currentLabel.frame) + 60 * BOScreenW / BOPictureW;
    CGFloat lastY = nameY;
    CGFloat lastH = nameH;
    _lastLabel.frame = CGRectMake(lastX, lastY, labelW, lastH);
    _lastLabel.text = @"上月存量";
    [_lastLabel setFont:[UIFont systemFontOfSize:12]];
    [_lastLabel setTextColor:BOColor(161, 161, 161)];
}
@end
