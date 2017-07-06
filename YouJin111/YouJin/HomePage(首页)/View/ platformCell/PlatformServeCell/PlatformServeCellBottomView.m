//
//  PlatformServeCellBottomView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/8.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformServeCellBottomView.h"
#import "BODynamicItem.h"
#import "DetailButton.h"
@interface PlatformServeCellBottomView()

/**发表时间label*/
@property (nonatomic, weak) UILabel *timeLable;

/**显示是否点赞以及点赞数量的btn*/
@property (nonatomic, weak) DetailButton *praiseBtn;

/**点击评论的btn*/
@property (nonatomic, weak) DetailButton *commentBtn;

@end
@implementation PlatformServeCellBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 创建显示发表时间的label
        UILabel *timeLabel = [[UILabel alloc] init];
        self.timeLable = timeLabel;
        [self addSubview:timeLabel];
        // 创建点赞的btn
        DetailButton *praiseBtn = [[DetailButton alloc] init];
        self.praiseBtn = praiseBtn;
        [self addSubview:praiseBtn];
        // 创建评论的btn
        DetailButton *commentBtn = [[DetailButton alloc] init];
        self.commentBtn = commentBtn;
        [self addSubview:commentBtn];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置发表时间label的frame
    CGFloat timeX = 15 * BOScreenW / BOPictureW;
    CGFloat timeY = 22.5 * BOScreenH / BOPictureH;
    CGFloat timeW = 150 * BOScreenW / BOPictureW;
    CGFloat timeH = 15 * BOScreenH / BOPictureH;
    self.timeLable.frame = CGRectMake(timeX, timeY, timeW, timeH);
    [self.timeLable setFont:[UIFont systemFontOfSize:11]];
    self.timeLable.text = @"2016-08-30";
    self.timeLable.textColor = BOColor(183, 184, 185);
    // 设置点赞的btn的frame
    CGFloat praiseX = 220 * BOScreenW / BOPictureW;
    CGFloat praiseY = 15 * BOScreenH / BOPictureH;
    CGFloat praiseW = 70 * BOScreenW / BOPictureW;
    CGFloat praiseH = 30 * BOScreenH / BOPictureH;
    self.praiseBtn.frame = CGRectMake(praiseX, praiseY, praiseW, praiseH);
    [self.praiseBtn setImage:[UIImage imageNamed:@"nav_icon_zan_nor"] forState:UIControlStateNormal];
    [self.praiseBtn setImage:[UIImage imageNamed:@"nav_icon_zan_pre"] forState:UIControlStateSelected];
    [self.praiseBtn setTitle:@"赞" forState:UIControlStateNormal];
    [self.praiseBtn setTitleColor:BOColor(144, 145, 146) forState:UIControlStateNormal];
    self.praiseBtn.imageEdgeInsets = UIEdgeInsetsMake(6 * BOScreenH / BOPictureH, 13 * BOScreenW / BOPictureW, 6 * BOScreenH / BOPictureH, 2.5 * BOScreenW / BOPictureW);
    // 设置评论的btn的frame
    CGFloat commentX = CGRectGetMaxX(self.praiseBtn.frame) + 5 * BOScreenW / BOPictureW;
    CGFloat commentY = praiseY;
    CGFloat commentW = praiseW;
    CGFloat commentH = praiseH;
    self.commentBtn.frame = CGRectMake(commentX, commentY, commentW, commentH);
    [self.commentBtn setImage:[UIImage imageNamed:@"nav_icon_pinglun"] forState:UIControlStateNormal];
    [self.commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    self.commentBtn.imageEdgeInsets = UIEdgeInsetsMake(5 * BOScreenH / BOPictureH, 10 * BOScreenW / BOPictureW, 5 * BOScreenH / BOPictureH, 2.5 * BOScreenW / BOPictureW);
}
@end
