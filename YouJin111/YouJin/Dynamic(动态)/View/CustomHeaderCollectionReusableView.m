//
//  CustomHeaderCollectionReusableView.m
//  CustomMessageView
//
//  Created by 李智权 on 17/3/23.
//  Copyright © 2017年 ZJS. All rights reserved.
//

#import "CustomHeaderCollectionReusableView.h"

@interface CustomHeaderCollectionReusableView ()

/**
 *  @brief  图片展示
 */
@property (strong, nonatomic, readonly) UIImageView *headImageView;

/**
 *  @brief  文字展示
 */
@property (strong, nonatomic, readonly) UILabel *titleLabel;

@end

@implementation CustomHeaderCollectionReusableView
@synthesize headImageView = _headImageView;
@synthesize titleLabel = _titleLabel;

#pragma mark - life cycle
- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self addSubview:self.headImageView];
        [self addSubview:self.titleLabel];
    }
    return (self);
}
#pragma mark -
- (void)prepareForReuse {
    [super prepareForReuse];
    self.titleLabel.text = nil;
}
#pragma mark - override
- (void)layoutSubviews {
    [super layoutSubviews];
    self.headImageView.x = 15.0f;
    self.headImageView.height = 13.0f;
    self.headImageView.y = 24.0f;
    self.titleLabel.x = CGRectGetMaxX(self.headImageView.frame) + 5.0f;
    self.titleLabel.width = self.width;
    self.titleLabel.centerY = self.headImageView.centerY;
}
#pragma mark -

#pragma mark - setter
- (void)setItem:(CollectionCellItem *)item {
    self.headImageView.image = [UIImage imageNamed:item.picName ? : @""];
    self.titleLabel.text = item.title ? : @"";
}
#pragma mark -

#pragma mark - getter
- (UIImageView *)headImageView {
    if(!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _headImageView.backgroundColor = [UIColor clearColor];
    }
    return (_headImageView);
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - 24)];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return (_titleLabel);
}

#pragma mark -
@end
