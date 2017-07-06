//
//  CurrentSectionHeaderView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CurrentSectionHeaderView.h"

@implementation CurrentSectionHeaderView

+ (instancetype)create {
    CurrentSectionHeaderView *view = [[NSBundle mainBundle]loadNibNamed:@"CurrentSectionHeaderView" owner:nil options:nil].firstObject;
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}



- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.firstButton.imageView.image) {
        [self.firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, self.firstButton.titleLabel.width, 0, -self.firstButton.titleLabel.width)];
        [self.firstButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.firstButton.imageView.width, 0, self.firstButton.imageView.width)];
    }
    if (self.secondButton.imageView.image) {
        [self.secondButton setImageEdgeInsets:UIEdgeInsetsMake(0, self.secondButton.titleLabel.width, 0, -self.secondButton.titleLabel.width)];
        [self.secondButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.secondButton.imageView.width, 0, self.secondButton.imageView.width)];
    }
    if (self.thirdButton.imageView.image) {
        [self.thirdButton setImageEdgeInsets:UIEdgeInsetsMake(0, self.thirdButton.titleLabel.width, 0, -self.thirdButton.titleLabel.width)];
        [self.thirdButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.thirdButton.imageView.width, 0, self.thirdButton.imageView.width)];
    }
    if (self.fouthButton.imageView.image) {
        [self.fouthButton setImageEdgeInsets:UIEdgeInsetsMake(0, self.fouthButton.titleLabel.width, 0, -self.fouthButton.titleLabel.width)];
        [self.fouthButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.fouthButton.imageView.width, 0, self.fouthButton.imageView.width)];
    }
    self.height = 40;
}


- (void)updateSectionHeaderType:(SectionHeaderType)type {
    switch (type) {
        case kEachGoldCurrent:
            [self handleTypeEqualEachGoldCurrent];
            break;
        case kMoneyFund:
            [self handleTypeEqualMoneyFund];
            break;
        default:
            break;
    }
}


#pragma mark - helpMethod
- (void)handleTypeEqualEachGoldCurrent {
    [self.firstButton setTitle:@"产品" forState:UIControlStateNormal];
    [self.secondButton setTitle:@"当日年化" forState:UIControlStateNormal];
    [self.thirdButton setTitle:@"万份收益" forState:UIControlStateNormal];
    [self.fouthButton setTitle:@"提现速度" forState:UIControlStateNormal];
    [self.secondButton setImage:[UIImage imageNamed:@"common_icon_paixu_nor"] forState:UIControlStateNormal];
    [self.thirdButton setImage:[UIImage imageNamed:@"common_icon_paixu_nor"] forState:UIControlStateNormal];
    [self.fouthButton setImage:[UIImage imageNamed:@"common_icon_paixu_nor"] forState:UIControlStateNormal];
}

- (void)handleTypeEqualMoneyFund{
    [self.firstButton setTitle:@"产品" forState:UIControlStateNormal];
    [self.secondButton setTitle:@"发行平台" forState:UIControlStateNormal];
    [self.thirdButton setTitle:@"当日年化" forState:UIControlStateNormal];
    [self.fouthButton setTitle:@"万份收益" forState:UIControlStateNormal];

    [self.thirdButton setImage:[UIImage imageNamed:@"common_icon_paixu_nor"] forState:UIControlStateNormal];
    [self.fouthButton setImage:[UIImage imageNamed:@"common_icon_paixu_nor"] forState:UIControlStateNormal];
}

@end
