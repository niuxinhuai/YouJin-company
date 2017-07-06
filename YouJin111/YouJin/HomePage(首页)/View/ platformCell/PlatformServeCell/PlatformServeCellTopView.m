//
//  PlatformServeCellTopView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/8.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformServeCellTopView.h"
#import "BODynamicItem.h"
@interface PlatformServeCellTopView()

/**用户的头像View*/
@property (nonatomic, weak) UIImageView *iconImageV;

/**用户的昵称*/
@property (nonatomic, weak) UILabel *nameLabel;

/**第一个星星ImageView*/
@property (nonatomic, weak) UIImageView *firstImageV;

/**第二个星星的imageView*/
@property (nonatomic, weak) UIImageView *secondImageV;

/**第三个星星的imageView*/
@property (nonatomic, weak) UIImageView *thirdImageV;

/**第四个星星的imageView*/
@property (nonatomic, weak) UIImageView *fourthImageV;

/**第五个星星的imageView*/
@property (nonatomic, weak) UIImageView *fiveImageV;

/**显示评分的label*/
@property (nonatomic, weak) UILabel *numberLabel;

/**显示点评的内容label*/
@property (nonatomic, weak) UILabel *contentLabel;

@end
@implementation PlatformServeCellTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 创建用户的头像image
        UIImageView *iconImageV = [[UIImageView alloc] init];
        self.iconImageV = iconImageV;
        [self addSubview:iconImageV];
        // 创建名称的label
        UILabel *nameLabel = [[UILabel alloc] init];
        self.nameLabel = nameLabel;
        [self addSubview:nameLabel];
        // 创建第一个星星imageView
        UIImageView *firstImageV = [[UIImageView alloc] init];
        self.firstImageV = firstImageV;
        [self addSubview:firstImageV];
        // 创建第二字星星imageView
        UIImageView *secondImageV = [[UIImageView alloc] init];
        self.secondImageV = secondImageV;
        [self addSubview:secondImageV];
        // 创建第三个星星imageView
        UIImageView *thirdImageV = [[UIImageView alloc] init];
        self.thirdImageV = thirdImageV;
        [self addSubview:thirdImageV];
        // 创建第四个星星的imageView
        UIImageView *fourthImageV = [[UIImageView alloc] init];
        self.fourthImageV = fourthImageV;
        [self addSubview:fourthImageV];
        // 床架第五个星星的imageVIew
        UIImageView *fiveImageV = [[UIImageView alloc] init];
        self.fiveImageV = fiveImageV;
        [self addSubview:fiveImageV];
        // 创建显示评分的label
        UILabel *numberLabel = [[UILabel alloc] init];
        self.numberLabel = numberLabel;
        [self addSubview:numberLabel];
        // 创建显示点评内容的label
        UILabel *contentLabel = [[UILabel alloc] init];
        self.contentLabel = contentLabel;
        [self addSubview:contentLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置用户的头像的frame
    CGFloat iconX = 15 * BOScreenW / BOPictureW;
    CGFloat iconY = 15 * BOScreenH / BOPictureH;
    CGFloat iconWH = 45 * BOScreenW / BOPictureW;
    self.iconImageV.frame = CGRectMake(iconX, iconY, iconWH, iconWH);
    self.iconImageV.layer.cornerRadius = 22.5 * BOScreenW / BOPictureW;
    self.iconImageV.layer.masksToBounds = YES;
    self.iconImageV.image = [UIImage imageNamed:@"pic_touxiang"];
    // 设置昵称label的frame
    CGFloat nameX = CGRectGetMaxX(self.iconImageV.frame) + 10 * BOScreenW / BOPictureW;
    CGFloat nameY = 20 * BOScreenH / BOPictureH;
    CGFloat nameW = 90 * BOScreenW / BOPictureW;
    CGFloat nameH = 20 * BOScreenH / BOPictureH;
    self.nameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
    self.nameLabel.text = @"昵称ID昵称";
    [self.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    self.nameLabel.textColor = BOColor(77, 130, 189);
    // 添加第一个星星frame
    CGFloat firstX = nameX;
    CGFloat firstY = CGRectGetMaxY(self.nameLabel.frame) + 10 * BOScreenH / BOPictureH;
    CGFloat firstWH = 12.5 * BOScreenW / BOPictureW;
    self.firstImageV.frame = CGRectMake(firstX, firstY, firstWH, firstWH);
    [self.firstImageV setImage:[UIImage imageNamed:@"evaluate_score_d"]];
    [self.firstImageV setHighlightedImage:[UIImage imageNamed:@"evaluate_score_h"]];
    // 添加第二个星星frame
    CGFloat secondX = CGRectGetMaxX(self.firstImageV.frame) + 4 * BOScreenW / BOPictureW;
    CGFloat secondY = firstY;
    CGFloat secondWH = firstWH;
    self.secondImageV.frame = CGRectMake(secondX, secondY, secondWH, secondWH);
    [self.secondImageV setImage:[UIImage imageNamed:@"evaluate_score_d"]];
    [self.secondImageV setHighlightedImage:[UIImage imageNamed:@"evaluate_score_h"]];
    // 添加第三个星星的frame
    CGFloat thirdX = CGRectGetMaxX(self.secondImageV.frame) + 4 * BOScreenW / BOPictureW;
    CGFloat thirdY = firstY;
    CGFloat thirdWH = firstWH;
    self.thirdImageV.frame = CGRectMake(thirdX, thirdY, thirdWH, thirdWH);
    [self.thirdImageV setImage:[UIImage imageNamed:@"evaluate_score_d"]];
    [self.thirdImageV setHighlightedImage:[UIImage imageNamed:@"evaluate_score_h"]];
    // 添加第四个星星的frame
    CGFloat fourthX = CGRectGetMaxX(self.thirdImageV.frame) + 4 * BOScreenW / BOPictureW;
    CGFloat fourthY = firstY;
    CGFloat fourthWH = firstWH;
    self.fourthImageV.frame = CGRectMake(fourthX, fourthY, fourthWH, fourthWH);
    [self.fourthImageV setImage:[UIImage imageNamed:@"evaluate_score_d"]];
    [self.fourthImageV setHighlightedImage:[UIImage imageNamed:@"evaluate_score_h"]];
    // 添加第五个星星的frame
    CGFloat fiveX = CGRectGetMaxX(self.fourthImageV.frame) + 4 * BOScreenW / BOPictureW;
    CGFloat fiveY = firstY;
    CGFloat fiveWH = firstWH;
    self.fiveImageV.frame = CGRectMake(fiveX, fiveY, fiveWH, fiveWH);
    [self.fiveImageV setImage:[UIImage imageNamed:@"evaluate_score_d"]];
    [self.fiveImageV setHighlightedImage:[UIImage imageNamed:@"evaluate_score_h"]];
    // 添加评分的label的frame
    CGFloat numberX = CGRectGetMaxX(self.fiveImageV.frame) + 6 * BOScreenW / BOPictureW;
    CGFloat numberY = fiveY;
    CGFloat numberW = 30 * BOScreenW / BOPictureW;
    CGFloat numberH = fiveWH;
    self.numberLabel.frame = CGRectMake(numberX, numberY, numberW, numberH);
    self.numberLabel.text = @"3.0";
    self.numberLabel.textColor = BOColor(174, 175, 176);
    // 设置点评内容的label的frame
    CGFloat contentX = 15 * BOScreenW / BOPictureW;
    CGFloat contentY = 75 * BOScreenH / BOPictureH;
    CGFloat contentW = BOScreenW - 30 * BOScreenW / BOPictureW;
    CGFloat contentH = 45 * BOScreenH / BOPictureH;
    self.contentLabel.frame = CGRectMake(contentX, contentY, contentW, contentH);
    // 设置内容View的富文本
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 5;
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UIFont systemFontOfSize:12],NSFontAttributeName, paragraph,NSParagraphStyleAttributeName, nil];
    NSString *showString = @"杭州仁润科技股份有限公司是杭州一家专注于“互联网金融”行业系统平台建设与维护、平台运营安全防护、平台业务运营指导为一体的综合解决方案提供商。杭州仁润科技股份有限公司主要重点产品“仁润P2P网贷系统”和“仁润众筹平台系统";
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:showString attributes:dict];
    self.contentLabel.attributedText = attribute;
     self.contentLabel.numberOfLines = 2;
}
@end
