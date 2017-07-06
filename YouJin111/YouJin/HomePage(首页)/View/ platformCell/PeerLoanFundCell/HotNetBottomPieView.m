//
//  HotNetBottomPieView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HotNetBottomPieView.h"
#import "BOPieView.h"
@interface HotNetBottomPieView ()
@property (nonatomic, weak) BOPieView *pieView;
@property (nonatomic, weak) UIView *smallBlueView;
@property (nonatomic, weak) UILabel *blueLabel;
@property (nonatomic, weak) UIView *smallGreenView;
@property (nonatomic, weak) UILabel *greenLabel;
@property (nonatomic, weak) UIView *smallRedView;
@property (nonatomic, weak) UILabel *redLabel;
@property (nonatomic, weak) UIView *smallOrangeView;
@property (nonatomic, weak) UILabel *orangeLabel;
@end
@implementation HotNetBottomPieView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 创建饼图的View
        BOPieView *pieView = [[BOPieView alloc] init];
        _pieView = pieView;
        // 创建点状蓝色View
        UIView *smallBlueView = [[UIView alloc] init];
        _smallBlueView = smallBlueView;
        // 创建蓝色label
        UILabel *blueLabel = [[UILabel alloc] init];
        _blueLabel = blueLabel;
        // 创建点状绿色View
        UIView *smallGreenView = [[UIView alloc] init];
        _smallGreenView = smallGreenView;
        // 创建绿色label
        UILabel *greenLabel =[[UILabel alloc] init];
        _greenLabel = greenLabel;
        // 创建点状红色View
        UIView *smallRedView = [[UIView alloc] init];
        _smallRedView = smallRedView;
        // 创建红色label
        UILabel *redLabel = [[UILabel alloc] init];
        _redLabel = redLabel;
        // 创建点状橙色View
        UIView *smallOrangeView = [[UIView alloc] init];
        _smallOrangeView = smallOrangeView;
        // 创建橙色label
        UILabel *orangeLabel = [[UILabel alloc] init];
        _orangeLabel = orangeLabel;
        
        [self addSubview:pieView];
        [self addSubview:smallBlueView];
        [self addSubview:blueLabel];
        [self addSubview:smallGreenView];
        [self addSubview:greenLabel];
        [self addSubview:smallRedView];
        [self addSubview:redLabel];
        [self addSubview:smallOrangeView];
        [self addSubview:orangeLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置pieView的frame
    CGFloat pieX = 15 * BOScreenW / BOPictureW;
    CGFloat pieY = 19 * BOScreenH / BOPictureH;
    CGFloat pieWH = 62 * BOScreenW / BOPictureW;
    _pieView.frame = CGRectMake(pieX, pieY, pieWH, pieWH);
    _pieView.backgroundColor = BOColor(252, 252, 252);
    // 设置蓝色View的frame
    CGFloat samllBLueX = 101 * BOScreenW / BOPictureW;
    CGFloat smallBlueY = 27 * BOScreenH / BOPictureH;
    CGFloat samllBlueWH = 7 * BOScreenW / BOPictureW;
    _smallBlueView.frame = CGRectMake(samllBLueX, smallBlueY, samllBlueWH, samllBlueWH);
    _smallBlueView.backgroundColor = BOColor(75, 153, 248);
    _smallBlueView.layer.cornerRadius = 0.5 * samllBlueWH;
    _smallBlueView.layer.masksToBounds = YES;
    // 蓝色view对应的label(除其他外最大的比例)
    CGFloat blueX = CGRectGetMaxX(_smallBlueView.frame) + 6 * BOScreenW / BOPictureW;
    CGFloat blueY = 22 * BOScreenH / BOPictureH;
    CGFloat blueW = 110 * BOScreenW / BOPictureW;
    CGFloat blueH = 15 * BOScreenH / BOPictureH;
    _blueLabel.frame = CGRectMake(blueX, blueY, blueW, blueH);
    _blueLabel.text = @"美利金融  12.01%";
    _blueLabel.textColor = BOColor(152, 152, 152);
    [_blueLabel setFont:[UIFont systemFontOfSize:12]];
    // 设置绿色View的frame
    CGFloat smallGreenX = CGRectGetMaxX(_blueLabel.frame) + 25 * BOScreenW / BOPictureW;
    CGFloat smallGreenY = smallBlueY;
    CGFloat smallGreenWH = samllBlueWH;
    _smallGreenView.frame = CGRectMake(smallGreenX, smallGreenY, smallGreenWH, smallGreenWH);
    _smallGreenView.backgroundColor = BOColor(139, 197, 63);
    _smallGreenView.layer.cornerRadius = 0.5 * samllBlueWH;
    _smallGreenView.layer.masksToBounds = YES;
    // 设置绿色View对应的除其他外第二大的比例
    CGFloat greenX = CGRectGetMaxX(_smallGreenView.frame) + 6 * BOScreenW / BOPictureW;
    CGFloat greenY = blueY;
    CGFloat greenW = blueW;
    CGFloat greenH = blueH;
    _greenLabel.frame = CGRectMake(greenX, greenY, greenW, greenH);
    _greenLabel.text = @"微贷网  8.03%";
    _greenLabel.textColor = BOColor(152, 152, 152);
    [_greenLabel setFont:[UIFont systemFontOfSize:12]];
    // 设置红色的view
    CGFloat smallRedX = samllBLueX;
    CGFloat smallRedY = CGRectGetMaxY(_smallBlueView.frame) + 23 * BOScreenH / BOPictureH;
    CGFloat smallRedWH = samllBlueWH;
    _smallRedView.frame = CGRectMake(smallRedX, smallRedY, smallRedWH, smallRedWH);
    _smallRedView.backgroundColor = BOColor(241, 106, 85);
    _smallRedView.layer.cornerRadius = 0.5 * samllBlueWH;
    _smallRedView.layer.masksToBounds = YES;
    // 设置红色label对应的除其他外最小的比例
    CGFloat redX = CGRectGetMaxX(_smallRedView.frame) + 6 * BOScreenW / BOPictureW;
    CGFloat redY = CGRectGetMaxY(_blueLabel.frame) + 16 * BOScreenH / BOPictureH;
    CGFloat redW = blueW;
    CGFloat redH = blueH;
    _redLabel.frame = CGRectMake(redX, redY, redW, redH);
    _redLabel.text = @"团贷网  34.56%";
    _redLabel.textColor = BOColor(152, 152, 152);
    [_redLabel setFont:[UIFont systemFontOfSize:12]];
    // 设置橙色View
    CGFloat smallOrangeX = smallGreenX;
    CGFloat smallOrangeY = smallRedY;
    CGFloat smallOrangeWH = smallGreenWH;
    _smallOrangeView.frame = CGRectMake(smallOrangeX, smallOrangeY, smallOrangeWH, smallOrangeWH);
    _smallOrangeView.backgroundColor = BOColor(251, 176, 59);
    _smallOrangeView.layer.cornerRadius = 0.5 * samllBlueWH;
    _smallOrangeView.layer.masksToBounds = YES;
    // 设置橙色view对应的label的其他的比例
    CGFloat orangeX = greenX;
    CGFloat orangeY = redY;
    CGFloat orangeW = greenW;
    CGFloat orangeH = greenH;
    _orangeLabel.frame = CGRectMake(orangeX, orangeY, orangeW, orangeH);
    _orangeLabel.text = @"其他 45.3%";
    _orangeLabel.textColor = BOColor(152, 152, 152);
    [_orangeLabel setFont:[UIFont systemFontOfSize:12]];
    
}
@end
