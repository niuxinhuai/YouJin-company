//
//  CarLoanRankView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CarLoanRankView.h"
#import "BOLcationButton.h"
@implementation CarLoanRankView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat heightY = 10 * BOScreenH / BOPictureH;
        CGFloat heightH = 21 * BOScreenH / BOPictureH;
        // 添加头部view的子控件
        UILabel *platformLabel = [[UILabel alloc] initWithFrame:CGRectMake(14 * BOScreenW / BOPictureW, heightY, 46 * BOScreenW / BOPictureW, heightH)];
        platformLabel.text = @"平台";
        [platformLabel setFont:[UIFont systemFontOfSize:13]];
        platformLabel.textColor = BOColor(148, 149, 150);
        [self addSubview:platformLabel];
        // 添加头部view中的利率button
        BOLcationButton *rateBtn = [[BOLcationButton alloc] initWithFrame:CGRectMake(90 * BOScreenW / BOPictureW, heightY, 50 * BOScreenW / BOPictureW, heightH)];
        [rateBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [rateBtn setTitle:@"利率" forState:UIControlStateNormal];
        [rateBtn setTitleColor:BOColor(148, 149, 150) forState:UIControlStateNormal];
        [rateBtn setImage:[UIImage imageNamed:@"common_icon_paixu_nor"] forState:UIControlStateNormal];
        [self addSubview:rateBtn];
        // 添加头部的成交量button
        BOLcationButton *turnoverBtn = [[BOLcationButton alloc] initWithFrame:CGRectMake(158 * BOScreenW / BOPictureW, heightY, 60 * BOScreenW / BOPictureW, heightH)];
        [turnoverBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [turnoverBtn setTitle:@"成交量" forState:UIControlStateNormal];
        [turnoverBtn setTitleColor:BOColor(148, 149, 150) forState:UIControlStateNormal];
        [turnoverBtn setImage:[UIImage imageNamed:@"common_icon_paixu_nor"] forState:UIControlStateNormal];
        [self addSubview:turnoverBtn];
        // 添加借款人的button
        BOLcationButton *borrowerBtn = [[BOLcationButton alloc] initWithFrame:CGRectMake(239 * BOScreenW / BOPictureW, heightY, 60 * BOScreenW / BOPictureW, heightH)];
        [borrowerBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [borrowerBtn setTitle:@"借款人" forState:UIControlStateNormal];
        [borrowerBtn setTitleColor:BOColor(148, 149, 150) forState:UIControlStateNormal];
        [borrowerBtn setImage:[UIImage imageNamed:@"common_icon_paixu_nor"] forState:UIControlStateNormal];
        [self addSubview:borrowerBtn];
        // 添加投资人的button
        BOLcationButton *investorBtn = [[BOLcationButton alloc] initWithFrame:CGRectMake(308 * BOScreenW / BOPictureW, heightY, 60 * BOScreenW / BOPictureW, heightH)];
        [investorBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [investorBtn setTitle:@"投资人" forState:UIControlStateNormal];
        [investorBtn setTitleColor:BOColor(148, 149, 150) forState:UIControlStateNormal];
        [investorBtn setImage:[UIImage imageNamed:@"common_icon_paixu_nor"] forState:UIControlStateNormal];
        
        // 设置该View的borde
        self.layer.borderWidth = 1;
        self.layer.borderColor = BOColor(238, 240, 241).CGColor;
        [self addSubview:investorBtn];
    }
    return self;
}

@end
