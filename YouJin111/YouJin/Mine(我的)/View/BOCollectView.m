//
//  BOCollectView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOCollectView.h"
#import "MineHomePageModel.h"
#import "NSString+Utilities.h"
@interface BOCollectView ()

/**U币数量的label*/
@property (nonatomic, weak) UILabel *coinNumberLabel;
/**U币的label*/
@property (nonatomic, weak) UILabel *coinLabel;
/**收藏数量的label*/
@property (nonatomic, weak) UILabel *collectNumberLabel;
/**收藏的label*/
@property (nonatomic, weak) UILabel *collectLabel;
/**关注数量的label*/
@property (nonatomic, weak) UILabel *attentionNumLabel;
/**关注的label*/
@property (nonatomic, weak) UILabel *attentionLabel;
/**粉丝数量的label*/
@property (nonatomic, weak) UILabel *fansNumberLabel;
/**粉丝的label*/
@property (nonatomic, weak) UILabel *fansLabel;

@end
@implementation BOCollectView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 创建U币数量的label
        UILabel *coinNumberLabel = [[UILabel alloc] init];
        _coinNumberLabel = coinNumberLabel;
        // 创建U币的label
        UILabel *coinLabel = [[UILabel alloc] init];
        _coinLabel = coinLabel;
        // 创建收藏数量的label
        UILabel *collectNumberLabel = [[UILabel alloc] init];
        _collectNumberLabel = collectNumberLabel;
        // 创建收藏的label
        UILabel *collectLabel = [[UILabel alloc] init];
        _collectLabel = collectLabel;
        // 创建关注数量的label
        UILabel *attentionNumLabel = [[UILabel alloc] init];
        _attentionNumLabel = attentionNumLabel;
        // 创建关注的label
        UILabel *attentionLabel = [[UILabel alloc] init];
        _attentionLabel = attentionLabel;
        // 粉丝数量的label
        UILabel *fansNumberLabel = [[UILabel alloc] init];
        _fansNumberLabel = fansNumberLabel;
        // 创建粉丝的label
        UILabel *fansLabel = [[UILabel alloc] init];
        _fansLabel = fansLabel;
        
        [self addSubview:coinNumberLabel];
        [self addSubview:coinLabel];
        [self addSubview:collectNumberLabel];
        [self addSubview:collectLabel];
        [self addSubview:attentionNumLabel];
        [self addSubview:attentionLabel];
        [self addSubview:fansNumberLabel];
        [self addSubview:fansLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat labelW = 40 * BOScreenW / BOPictureW;
    CGFloat margin = (BOScreenW - 4 * labelW) / 4;
    // 设置U币数量的label
    CGFloat coinNumX = 0.5 * margin;
    CGFloat coinNumY = 14 * BOScreenH / BOPictureH;
    CGFloat coinNumH = 20 * BOScreenH / BOPictureH;
    _coinNumberLabel.frame = CGRectMake(coinNumX, coinNumY, labelW, coinNumH);
    _coinNumberLabel.textAlignment = NSTextAlignmentCenter;
    _coinNumberLabel.text = @"-";
    [_coinNumberLabel setFont:[UIFont systemFontOfSize:14]];
    // 设置U币的label
    CGFloat coinX = coinNumX;
    CGFloat coinH = 15 * BOScreenH / BOPictureH;
    _coinLabel.frame = CGRectMake(coinX, CGRectGetMaxY(_coinNumberLabel.frame), labelW, coinH);
    _coinLabel.textAlignment = NSTextAlignmentCenter;
    _coinLabel.text = @"U币";
    [_coinLabel setFont:[UIFont systemFontOfSize:12]];
    _coinLabel.textColor = BOColor(168, 178, 185);
    // 设置收藏数量的label
    CGFloat collectNumX = CGRectGetMaxX(_coinNumberLabel.frame) + margin;
    CGFloat collectNumY = coinNumY;
    CGFloat collectNumH = coinNumH;
    _collectNumberLabel.frame = CGRectMake(collectNumX, collectNumY, labelW, collectNumH);
    _collectNumberLabel.textAlignment = NSTextAlignmentCenter;
    _collectNumberLabel.text = @"-";
    [_collectNumberLabel setFont:[UIFont systemFontOfSize:14]];
    // 设置收藏的label
    CGFloat collectX = collectNumX;
    CGFloat collectY = CGRectGetMaxY(_collectNumberLabel.frame) ;
    CGFloat collectW = labelW;
    CGFloat collectH = coinH;
    _collectLabel.frame = CGRectMake(collectX, collectY, collectW, collectH);
    _collectLabel.textAlignment = NSTextAlignmentCenter;
    _collectLabel.text = @"收藏";
    [_collectLabel setFont:[UIFont systemFontOfSize:12]];
    _collectLabel.textColor = BOColor(168, 178, 185);
    // 设置关注数量的label
    CGFloat attentionNumX = CGRectGetMaxX(_collectNumberLabel.frame) + margin;
    CGFloat attentionNumY = coinNumY;
    CGFloat attentionNumW = labelW;
    CGFloat attentionNumH = coinNumH;
    _attentionNumLabel.frame = CGRectMake(attentionNumX, attentionNumY, attentionNumW, attentionNumH);
    _attentionNumLabel.textAlignment = NSTextAlignmentCenter;
    _attentionNumLabel.text = @"-";
    [_attentionNumLabel setFont:[UIFont systemFontOfSize:14]];
    // 设置关注的label
    CGFloat attentionX = attentionNumX;
    CGFloat attentionY = CGRectGetMaxY(_attentionNumLabel.frame);
    CGFloat attentionW = labelW;
    CGFloat attentionH = coinH;
    _attentionLabel.frame = CGRectMake(attentionX, attentionY, attentionW, attentionH);
    _attentionLabel.textAlignment = NSTextAlignmentCenter;
    _attentionLabel.text = @"关注";
    [_attentionLabel setFont:[UIFont systemFontOfSize:12]];
    _attentionLabel.textColor = BOColor(168, 178, 185);
    // 设置粉丝数量的label
    CGFloat fansNumberX = CGRectGetMaxX(_attentionNumLabel.frame) + margin;
    CGFloat fansNumberY = coinNumY;
    CGFloat fansNumberW = labelW;
    CGFloat fansNumberH = coinNumH;
    _fansNumberLabel.frame = CGRectMake(fansNumberX, fansNumberY, fansNumberW, fansNumberH);
    _fansNumberLabel.textAlignment = NSTextAlignmentCenter;
    _fansNumberLabel.text = @"-";
    [_fansNumberLabel setFont:[UIFont systemFontOfSize:14]];
    // 设置粉丝的label
    CGFloat fansX = fansNumberX;
    CGFloat fansY = CGRectGetMaxY(_fansNumberLabel.frame);
    CGFloat fansW = labelW;
    CGFloat fansH = coinH;
    _fansLabel.frame = CGRectMake(fansX, fansY, fansW, fansH);
    _fansLabel.textAlignment = NSTextAlignmentCenter;
    _fansLabel.text = @"粉丝";
    [_fansLabel setFont:[UIFont systemFontOfSize:12]];
    _fansLabel.textColor = BOColor(168, 178, 185);
}

- (void)setItem:(MineHomePageModel *)item {
    _item = item;
    if (USERSid) {
        self.coinNumberLabel.text = [NSString balanceStringWithBalance:[item.balance integerValue]];
        self.collectNumberLabel.text = [NSString stringWithCount:[item.collection integerValue]];
        self.fansNumberLabel.text = [NSString stringWithCount:[item.fans integerValue]];
        self.attentionNumLabel.text = [NSString stringWithCount:[item.focus_num integerValue]];
    }else {
        self.coinNumberLabel.text = @"-";
        self.collectNumberLabel.text = @"-";
        self.fansNumberLabel.text = @"-";
        self.attentionNumLabel.text = @"-";

    }
}
@end
