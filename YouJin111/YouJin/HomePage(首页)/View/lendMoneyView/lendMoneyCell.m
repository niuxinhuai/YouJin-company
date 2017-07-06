//
//  lendMoneyCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "lendMoneyCell.h"
#import "LendMoneyModel.h"
#import "LendTypeModel.h"
@interface lendMoneyCell()
/**公司的名称*/
@property (nonatomic, weak) UILabel *nameLabel;

/**显示评分的label*/
@property (nonatomic, weak) UILabel *numberLabel;

/**显示点评的内容label*/
@property (nonatomic, weak) UILabel *contentLabel;

/**显示申请人数的label*/
@property (nonatomic, weak) UILabel *applyNumberLabel;
/**显示贷款额度的label*/
@property (nonatomic, weak) UILabel *limitNumLabel;
/**贷款类型*/
@property (nonatomic, weak) UILabel *loadTypeLabel;
/**最底部的label*/
@property (nonatomic, weak) UILabel *bottomLabel;

/**logo*/
@property (nonatomic, weak) UIImageView *iconImageV;

@property (nonatomic, strong) NSMutableArray *starArrayM;

@end
@implementation lendMoneyCell
- (NSMutableArray *)starArrayM {
    if (_starArrayM == nil) {
        _starArrayM = [NSMutableArray array];
    }
    return _starArrayM;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 创建头像iconImage
        CGFloat iconX = 10 * BOScreenW / BOPictureW;
        CGFloat iconY = 12 * BOScreenH / BOPictureH;
        CGFloat iconWH = 60 * BOScreenW / BOPictureW;
        UIImageView *iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconWH, iconWH)];
        self.iconImageV = iconImageV;
        iconImageV.image = [UIImage imageNamed:@"pic_touxiang"];
        iconImageV.layer.cornerRadius = 7;
        iconImageV.layer.masksToBounds = YES;
        [self.contentView addSubview:iconImageV];
        // 创建贷款名称的label
        CGFloat nameX = 85 * BOScreenW / BOPictureW;
        CGFloat nameY = 16 * BOScreenH / BOPictureH;
        CGFloat nameW = 180 * BOScreenW / BOPictureW;
        CGFloat nameH = 25 * BOScreenH / BOPictureH;
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        self.nameLabel = nameLabel;
        nameLabel.text = @"闪电贷款-现金贷";
        [nameLabel setFont:[UIFont systemFontOfSize:17]];
        [self.contentView addSubview:nameLabel];
        // 添加第一个星星frame
        CGFloat firstX = nameX;
        CGFloat firstY = CGRectGetMaxY(self.nameLabel.frame) + 11 * BOScreenH / BOPictureH;
        CGFloat firstWH = 12.5 * BOScreenW / BOPictureW;
        UIImageView *firstImageV = [[UIImageView alloc] init];
        [self.contentView addSubview:firstImageV];
        firstImageV.frame = CGRectMake(firstX, firstY, firstWH, firstWH);
        [firstImageV setImage:[UIImage imageNamed:@"evaluate_score_d"]];
        [firstImageV setHighlightedImage:[UIImage imageNamed:@"evaluate_score_h"]];
        [self.starArrayM addObject:firstImageV];
        // 添加第二个星星frame
        CGFloat secondX = CGRectGetMaxX(firstImageV.frame) + 4 * BOScreenW / BOPictureW;
        CGFloat secondY = firstY;
        CGFloat secondWH = firstWH;
        UIImageView *secondImageV = [[UIImageView alloc] init];
        [self.contentView addSubview:secondImageV];
        secondImageV.frame = CGRectMake(secondX, secondY, secondWH, secondWH);
        [secondImageV setImage:[UIImage imageNamed:@"evaluate_score_d"]];
        [secondImageV setHighlightedImage:[UIImage imageNamed:@"evaluate_score_h"]];
        [self.starArrayM addObject:secondImageV];
        // 添加第三个星星的frame
        CGFloat thirdX = CGRectGetMaxX(secondImageV.frame) + 4 * BOScreenW / BOPictureW;
        CGFloat thirdY = firstY;
        CGFloat thirdWH = firstWH;
        UIImageView *thirdImageV = [[UIImageView alloc] init];
        [self.contentView addSubview:thirdImageV];
        thirdImageV.frame = CGRectMake(thirdX, thirdY, thirdWH, thirdWH);
        [thirdImageV setImage:[UIImage imageNamed:@"evaluate_score_d"]];
        [thirdImageV setHighlightedImage:[UIImage imageNamed:@"evaluate_score_h"]];
        [self.starArrayM addObject:thirdImageV];
        // 添加第四个星星的frame
        CGFloat fourthX = CGRectGetMaxX(thirdImageV.frame) + 4 * BOScreenW / BOPictureW;
        CGFloat fourthY = firstY;
        CGFloat fourthWH = firstWH;
        UIImageView *fourthImageV = [[UIImageView alloc] init];
        [self.contentView addSubview:fourthImageV];
        fourthImageV.frame = CGRectMake(fourthX, fourthY, fourthWH, fourthWH);
        [fourthImageV setImage:[UIImage imageNamed:@"evaluate_score_d"]];
        [fourthImageV setHighlightedImage:[UIImage imageNamed:@"evaluate_score_h"]];
        [self.starArrayM addObject:fourthImageV];
        // 添加第五个星星的frame
        CGFloat fiveX = CGRectGetMaxX(fourthImageV.frame) + 4 * BOScreenW / BOPictureW;
        CGFloat fiveY = firstY;
        CGFloat fiveWH = firstWH;
        UIImageView *fiveImageV = [[UIImageView alloc] init];
        [self.contentView addSubview:fiveImageV];
        fiveImageV.frame = CGRectMake(fiveX, fiveY, fiveWH, fiveWH);
        [fiveImageV setImage:[UIImage imageNamed:@"evaluate_score_d"]];
        [fiveImageV setHighlightedImage:[UIImage imageNamed:@"evaluate_score_h"]];
        [self.starArrayM addObject:fiveImageV];
        // 添加评分的label的frame
        CGFloat numberX = CGRectGetMaxX(fiveImageV.frame) + 6 * BOScreenW / BOPictureW;
        CGFloat numberY = fiveY;
        CGFloat numberW = 30 * BOScreenW / BOPictureW;
        CGFloat numberH = fiveWH;
        UILabel *numberLabel = [[UILabel alloc] init];
        self.numberLabel = numberLabel;
        [self.contentView addSubview:numberLabel];
        self.numberLabel.frame = CGRectMake(numberX, numberY, numberW, numberH);
        self.numberLabel.text = @"3.0";
        [self.numberLabel setFont:[UIFont systemFontOfSize:13]];
        self.numberLabel.textColor = BOColor(174, 175, 176);
        
        //创建显示申请的label
        CGFloat applyX = 85 * BOScreenW / BOPictureW;
        CGFloat applyY = CGRectGetMaxY(firstImageV.frame) + 14 * BOScreenH / BOPictureH;
        CGFloat applyW = 60 * BOScreenW / BOPictureW;
        CGFloat applyH = 15 * BOScreenH / BOPictureH;
        UILabel *applyForLabel = [[UILabel alloc] initWithFrame:CGRectMake(applyX, applyY, applyW, applyH)];
        [self.contentView addSubview:applyForLabel];
        applyForLabel.text = @"申请人数";
        [applyForLabel setFont:[UIFont systemFontOfSize:13]];
        [applyForLabel setTextColor:BOColor(118, 119, 120)];
        // 创建显示申请人数的label
        CGFloat applyNumX = CGRectGetMaxX(applyForLabel.frame) + 6 * BOScreenW / BOPictureW;
        CGFloat applyNumY = applyY;
        CGFloat applyNumW = 60 * BOScreenW / BOPictureW;
        CGFloat applyNumH = applyH;
        UILabel *applyNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(applyNumX, applyNumY, applyNumW, applyNumH)];
        self.applyNumberLabel = applyNumberLabel;
        [self.contentView addSubview:applyNumberLabel];
        applyNumberLabel.text = @"75942";
        [applyNumberLabel setFont:[UIFont systemFontOfSize:13]];
        applyNumberLabel.textColor = BOColor(226, 0, 0);
        // 创建额度的label
        CGFloat limitX = CGRectGetMaxX(applyNumberLabel.frame)  + 15 * BOScreenW / BOPictureW;
        CGFloat limitY = applyY;
        CGFloat limitW = 30 * BOScreenW / BOPictureW;
        CGFloat limitH = applyH;
        UILabel *limitLabel = [[UILabel alloc] initWithFrame:CGRectMake(limitX, limitY, limitW, limitH)];
        [self.contentView addSubview:limitLabel];
        limitLabel.text = @"额度";
        [limitLabel setFont:[UIFont systemFontOfSize:13]];
        limitLabel.textColor = BOColor(118, 119, 120);
        // 创建显示具体多少额度的label
        CGFloat limitNumX = CGRectGetMaxX(limitLabel.frame) + 6 * BOScreenW / BOPictureW;
        CGFloat limitNumY = applyY;
        CGFloat limitNumW = 150 * BOScreenW / BOPictureW;
        CGFloat limitNumH = applyH;
        UILabel *limitNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(limitNumX, limitNumY, limitNumW, limitNumH)];
        self.limitNumLabel = limitNumLabel;
        [self.contentView addSubview:limitNumLabel];
        limitNumLabel.text = @"0.05~1万";
        [limitNumLabel setFont:[UIFont systemFontOfSize:13]];
        limitNumLabel.textColor = BOColor(226, 0, 0);
        
        // 创建分割线的View
        CGFloat lineX = nameX;
        CGFloat lineY = CGRectGetMaxY(applyForLabel.frame) + 13 * BOScreenH / BOPictureH;
        CGFloat lineW = BOScreenW - 95 * BOScreenW / BOPictureW;
        CGFloat lineH = 1;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        lineView.backgroundColor = BOColor(245, 246, 246);
        [self.contentView addSubview:lineView];
        // 创建底部的label
        CGFloat bottomX = nameX;
        CGFloat bottomY = CGRectGetMaxY(lineView.frame) + 7.5 * BOScreenH / BOPictureH;
        CGFloat bottomW = 200 * BOScreenW / BOPictureW;
        CGFloat bottomH = 15 * BOScreenH / BOPictureH;
        UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(bottomX, bottomY, bottomW, bottomH)];
        self.bottomLabel = bottomLabel;
        bottomLabel.text = @"审核被拒绝就赔钱，可以提现";
        bottomLabel.textColor = BOColor(144, 145, 146);
        [bottomLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:bottomLabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setItem:(LendMoneyModel *)item {
    _item = item;
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:perchImage];
    self.nameLabel.text = item.name;
    for (int i = 0; i < (int)([item.score floatValue] + 0.5); i++) {
        UIImageView *imageView = self.starArrayM[i];
        imageView.highlighted = YES;
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%d.0",(int)([item.score floatValue] + 0.5)];
    self.applyNumberLabel.text = item.nums;
    
    if ([item.max_limit integerValue]%10000 > 0)
    {
        self.limitNumLabel.text = [NSString stringWithFormat:@"%.1lf~%.1lf万", [item.min_limit floatValue] / 10000, [item.max_limit floatValue] / 10000];
    }else
    {
        self.limitNumLabel.text = [NSString stringWithFormat:@"%.1lf~%.0lf万", [item.min_limit floatValue] / 10000, [item.max_limit floatValue] / 10000];
    }
//    self.limitNumLabel.text = [NSString stringWithFormat:@"%.1lf~%.1lf万", [item.min_limit floatValue] / 10000, [item.max_limit floatValue] / 10000];

    self.bottomLabel.text = item.desc;
    
    // 添加贷款类型的label
    CGFloat loadY = 17 * BOScreenH / BOPictureH;
    NSArray *array = item.type;
    LendTypeModel *model = array[0];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10],NSFontAttributeName,[UIColor colorWithHexString:@"#3BB5F4" alpha:1], NSForegroundColorAttributeName, nil];
    CGFloat lableW = [model.desc sizeWithAttributes:dict].width;;
    CGFloat loadW = (lableW + 10) * BOWidthRate;
    CGFloat loadH = 17.5 * BOScreenH / BOPictureH;
    CGFloat loadX = BOScreenW - loadW -10 * BOWidthRate;
    UILabel *loadTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(loadX, loadY, loadW, loadH)];
    self.loadTypeLabel = loadTypeLabel;
    [self.contentView addSubview:loadTypeLabel];
    loadTypeLabel.text = model.desc;
    loadTypeLabel.textColor = BOColor(69, 177, 243);
    loadTypeLabel.layer.borderWidth = 1;
    loadTypeLabel.layer.borderColor = BOColor(153, 206, 250).CGColor;
    loadTypeLabel.layer.cornerRadius = 2;
    loadTypeLabel.layer.masksToBounds = YES;
    loadTypeLabel.textAlignment = NSTextAlignmentCenter;
    [loadTypeLabel setFont:[UIFont systemFontOfSize:10]];
}

@end
