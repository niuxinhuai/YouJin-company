//
//  BOMineCollectCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOMineCollectCell.h"

@implementation BOMineCollectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 设置头像imageView
        CGFloat iconX = 15 * BOWidthRate;
        CGFloat iconY = 15 * BOHeightRate;
        CGFloat iconWH = 55 * BOWidthRate;
        UIImageView *iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconWH, iconWH)];
        self.iconImageV = iconImageV;
        [self.contentView addSubview:iconImageV];
        // 设置titleLabel
        CGFloat titleX = CGRectGetMaxX(iconImageV.frame) + 15 * BOWidthRate;
        CGFloat titleY = 20 * BOHeightRate;
        CGFloat titleW = 265 * BOWidthRate;
        CGFloat titleH = 20 * BOHeightRate;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        self.titleLabel = titleLabel;
        titleLabel.textColor = [UIColor blackColor];
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.contentView addSubview:titleLabel];
        // 添加subtitleLabel
        CGFloat subTitleX = titleX;
        CGFloat subTitleY = CGRectGetMaxY(titleLabel.frame) + 10 * BOHeightRate;
        CGFloat subTitleW = BOScreenW - 141 * BOWidthRate;
        CGFloat subTitleH = 15 * BOHeightRate;
        UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(subTitleX, subTitleY, subTitleW, subTitleH)];
        self.subTitleLabel = subTitleLabel;
        [self.contentView addSubview:subTitleLabel];
    }
    return self;
}
@end
