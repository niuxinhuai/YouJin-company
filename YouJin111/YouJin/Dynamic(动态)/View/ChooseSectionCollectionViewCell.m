//
//  ChooseSectionCollectionViewCell.m
//  CustomMessageView
//
//  Created by 李智权 on 17/3/23.
//  Copyright © 2017年 ZJS. All rights reserved.
//

#import "ChooseSectionCollectionViewCell.h"
#import "CollectionCellItem.h"

@interface ChooseSectionCollectionViewCell ()


@end

@implementation ChooseSectionCollectionViewCell
@synthesize headImageView = _headImageView;
@synthesize titleLabel = _titleLabel;

#pragma mark - life cycle
- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.titleLabel];
    }
    return (self);
}
#pragma mark -

#pragma mark - override
- (void)layoutSubviews {
    [super layoutSubviews];
    self.headImageView.centerX = self.contentView.centerX;
    self.headImageView.y = 17.0f;
    
    self.titleLabel.width = self.contentView.width;
    self.titleLabel.y = CGRectGetMaxY(self.headImageView.frame);
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.titleLabel.text = nil;
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
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 36.0f, 36.0f)];
    }
    return (_headImageView);
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - self.headImageView.height - 17.0f)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:12.0f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return (_titleLabel);
}

#pragma mark -

@end
