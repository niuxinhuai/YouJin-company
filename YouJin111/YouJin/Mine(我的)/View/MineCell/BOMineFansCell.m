//
//  BOMineFansCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOMineFansCell.h"

@implementation BOMineFansCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 设置头像imageView
        CGFloat iconX = 10 * BOWidthRate;
        CGFloat iconY = 15 * BOHeightRate;
        CGFloat iconWH = 45 * BOWidthRate;
        UIImageView *iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconWH, iconWH)];
        self.iconImageV = iconImageV;
        iconImageV.layer.cornerRadius = 24.5 * BOWidthRate;
        iconImageV.layer.masksToBounds = YES;
        [self.contentView addSubview:iconImageV];
        // 设置titleLabel
        CGFloat titleX = CGRectGetMaxX(iconImageV.frame) + 12 * BOWidthRate;
        CGFloat titleY = 12 * BOHeightRate;
        CGFloat titleW = 100 * BOWidthRate;
        CGFloat titleH = 20 * BOHeightRate;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        self.titleLabel = titleLabel;
        titleLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:titleLabel];
        // 添加subtitleLabel
        CGFloat subTitleX = titleX;
        CGFloat subTitleY = CGRectGetMaxY(titleLabel.frame) + 10 * BOHeightRate;
        CGFloat subTitleW = BOScreenW - 141 * BOWidthRate;
        CGFloat subTitleH = 15 * BOHeightRate;
        UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(subTitleX, subTitleY, subTitleW, subTitleH)];
        self.subTitleLabel = subTitleLabel;
        subTitleLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        [subTitleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:subTitleLabel];
        // 添加关注的Button
        CGFloat attentionX = 295 * BOWidthRate;
        CGFloat attentionY = 25.5 * BOHeightRate;
        CGFloat attentionW = 80 * BOWidthRate;
        CGFloat attentionH = 23 * BOHeightRate;
        UIButton *attentionBtn = [[UIButton alloc] initWithFrame:CGRectMake(attentionX, attentionY, attentionW, attentionH)];
        [attentionBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [attentionBtn setImage:[UIImage imageNamed:@"common_btn_guanzhu_nor"] forState:UIControlStateNormal];
        [attentionBtn setImage:[UIImage imageNamed:@"common_btn_guanzhu_prer"] forState:UIControlStateSelected];
        [attentionBtn setTitleColor:BOColor(189, 218, 162) forState:UIControlStateNormal];
        [attentionBtn setTitleColor:BOColor(147, 148, 150) forState:UIControlStateSelected];
        [self.contentView addSubview:attentionBtn];
        // 添加底部的线View
        CGFloat bottomX = 0;
        CGFloat bottomY = 74 * BOHeightRate;
        CGFloat bottomW = BOScreenW;
        CGFloat bottomH = 1;
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(bottomX, bottomY, bottomW, bottomH)];
        bottomView.backgroundColor = BOColor(233, 234, 235);
        [self.contentView addSubview:bottomView];
    }
    return self;
}
#pragma mark - 关注按钮的点击事件
- (void)btnClick: (UIButton *)btn {
    if (!btn.selected) {
        btn.selected = YES;
    }else if (btn.selected) {
        btn.selected = NO;
    }
}
@end
