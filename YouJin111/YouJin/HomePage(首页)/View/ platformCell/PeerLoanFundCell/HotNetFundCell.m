//
//  HotNetFundCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/24.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HotNetFundCell.h"
#import "HotNetBottomPieView.h"
@implementation HotNetFundCell
#define labelW 80 * BOScreenW / BOPictureW
#define rightLabelW 90 * BOScreenW / BOPictureW
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 创建头像图片
        CGFloat pictureX = 15 * BOScreenW / BOPictureW;
        CGFloat pictureY = 15 * BOScreenH / BOPictureH;
        CGFloat pictureWH = 60 * BOScreenW / BOPictureW;
        UIImageView *pictureImage = [[UIImageView alloc] initWithFrame:CGRectMake(pictureX, pictureY, pictureWH, pictureWH)];
        pictureImage.image = [UIImage imageNamed:@"logo_youjin"];
        pictureImage.layer.cornerRadius = 10;
        // 创建名称label
        CGFloat nameX = 105 * BOScreenW / BOPictureW;
        CGFloat nameY = 20 * BOScreenH / BOPictureH;
        CGFloat nameW = labelW;
        CGFloat nameH = 15 * BOScreenH / BOPictureH;
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        nameLabel.text = @"平台名称";
        [nameLabel setFont:[UIFont systemFontOfSize:12]];
        nameLabel.textColor = BOColor(138, 138, 138);
        // 创建真实名称label
        CGFloat trueNameX = 105 * BOScreenW / BOPictureW;
        CGFloat trueNameY = 45 * BOScreenH / BOPictureH;
        CGFloat trueNameW = labelW;
        CGFloat trueNameH = 20 * BOScreenH / BOPictureH;
        UILabel *trueNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(trueNameX, trueNameY, trueNameW, trueNameH)];
        trueNameLabel.text = @"一两理财";
        [trueNameLabel setFont:[UIFont systemFontOfSize:14]];
        // 创建平台label
        CGFloat flatformX = 105 * BOScreenW / BOPictureW;
        CGFloat flatformY = 84 * BOScreenH / BOPictureH;
        CGFloat flatformW = labelW;
        CGFloat flatformH = 15 * BOScreenH / BOPictureH;
        UILabel *flatformLabel = [[UILabel alloc] initWithFrame:CGRectMake(flatformX, flatformY, flatformW, flatformH)];
        flatformLabel.text = @"在投平台数";
        flatformLabel.textColor = BOColor(158, 158, 158);
        [flatformLabel setFont:[UIFont systemFontOfSize:12]];
        // 创建显示平台数目的label
        CGFloat flatformNumX = 105 * BOScreenW / BOPictureW;
        CGFloat flatformNumY = 109 * BOScreenH / BOPictureH;
        CGFloat flatformNumW = labelW;
        CGFloat flatformNumH = 20 * BOScreenH / BOPictureH;
        UILabel *flatformNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(flatformNumX, flatformNumY, flatformNumW, flatformNumH)];
        flatformNumLabel.text = @"39";
        [flatformNumLabel setFont:[UIFont systemFontOfSize:14]];
        // 创建年化的label
        CGFloat yearX = 194 * BOScreenW / BOPictureW;
        CGFloat yearY = nameY;
        CGFloat yearW = nameW;
        CGFloat yearH = nameH;
        UILabel *yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(yearX, yearY, yearW, yearH)];
        yearLabel.text = @"当日年化";
        yearLabel.textColor = BOColor(158, 158, 158);
        [yearLabel setFont:[UIFont systemFontOfSize:12]];
        // 创建显示年化百分比的label
        CGFloat yearPercentX = yearX;
        CGFloat yearPercentY = trueNameY;
        CGFloat yearPercentW = trueNameW;
        CGFloat yearPercentH = trueNameH;
        UILabel *yearPercentLabel = [[UILabel alloc] initWithFrame:CGRectMake(yearPercentX, yearPercentY, yearPercentW, yearPercentH)];
        yearPercentLabel.text = @"12.66%";
        [yearPercentLabel setFont:[UIFont systemFontOfSize:14]];
        // 创建债券集中度的label
        CGFloat bondX = yearX;
        CGFloat bondY = flatformY;
        CGFloat bondW = flatformW;
        CGFloat bondH = flatformH;
        UILabel *bondLabel = [[UILabel alloc] initWithFrame:CGRectMake(bondX, bondY, bondW, bondH)];
        bondLabel.text = @"债权集中度";
        bondLabel.textColor = BOColor(158, 158, 158);
        [bondLabel setFont:[UIFont systemFontOfSize:12]];
        // 创建显示债权集中度的百分比的label
        CGFloat bondPercentX = yearX;
        CGFloat bondPercentY = flatformNumY;
        CGFloat bondPercentW = flatformNumW;
        CGFloat bondPercentH = flatformNumH;
        UILabel *bondPercentLabel = [[UILabel alloc] initWithFrame:CGRectMake(bondPercentX, bondPercentY, bondPercentW, bondPercentH)];
        bondPercentLabel.text = @"93.92%";
        [bondPercentLabel setFont:[UIFont systemFontOfSize:14]];
        // 创建在投份额的label
        CGFloat shareX = 270 * BOScreenW / BOPictureW;
        CGFloat shareY = nameY;
        CGFloat shareW = rightLabelW;
        CGFloat shareH = nameH;
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(shareX, shareY, shareW, shareH)];
        shareLabel.textAlignment = NSTextAlignmentRight;
        shareLabel.text = @"在投份额(万份)";
        [shareLabel setFont:[UIFont systemFontOfSize:12]];
        shareLabel.textColor = BOColor(158, 158, 158);
        // 创建显示投资份额数量的label
        CGFloat shareNumberX = shareX;
        CGFloat shareNumberY = trueNameY;
        CGFloat shareNumberW = rightLabelW;
        CGFloat shareNumberH = trueNameH;
        UILabel *shareNumberlabel = [[UILabel alloc] initWithFrame:CGRectMake(shareNumberX, shareNumberY, shareNumberW, shareNumberH)];
        shareNumberlabel.textAlignment = NSTextAlignmentRight;
        shareNumberlabel.text = @"236828";
        [shareNumberlabel setFont:[UIFont systemFontOfSize:14]];
        // 创建近期中雷的label
        CGFloat thunderX = shareX;
        CGFloat thunderY = flatformY;
        CGFloat thunderW = rightLabelW;
        CGFloat thunderH = flatformH;
        UILabel *centerThunderL = [[UILabel alloc] initWithFrame:CGRectMake(thunderX, thunderY, thunderW, thunderH)];
        centerThunderL.textAlignment = NSTextAlignmentRight;
        centerThunderL.text = @"近期中雷(元)";
        centerThunderL.textColor = BOColor(158, 158, 158);
        [centerThunderL setFont:[UIFont systemFontOfSize:12]];
        // 显示近期中雷的数量的label
        CGFloat thunderNumX = shareX;
        CGFloat thunderNumY = flatformNumX;
        CGFloat thunderNumW = rightLabelW;
        CGFloat thunderNumH = flatformNumH;
        UILabel *thunderNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(thunderNumX, thunderNumY, thunderNumW, thunderNumH)];
        thunderNumLabel.textAlignment = NSTextAlignmentRight;
        thunderNumLabel.text = @"0.00";
        [thunderNumLabel setFont:[UIFont systemFontOfSize:14]];
        // 创建底部的饼图View
        CGFloat bottomX = 0;
        CGFloat bottomY = 130 * BOScreenH / BOPictureH;
        CGFloat bottomW = BOScreenW;
        CGFloat bottomH = 90 * BOScreenH / BOPictureH;
        HotNetBottomPieView *bottomView = [[HotNetBottomPieView alloc] initWithFrame:CGRectMake(bottomX, bottomY, bottomW, bottomH)];
        bottomView.backgroundColor = BOColor(250, 250, 250);
        [self addSubview:pictureImage];
        [self addSubview:nameLabel];
        [self addSubview:trueNameLabel];
        [self addSubview:flatformLabel];
        [self addSubview:flatformNumLabel];
        [self addSubview:yearLabel];
        [self addSubview:yearPercentLabel];
        [self addSubview:bondLabel];
        [self addSubview:bondPercentLabel];
        [self addSubview:shareLabel];
        [self addSubview:shareNumberlabel];
        [self addSubview:centerThunderL];
        [self addSubview:thunderNumLabel];
        [self addSubview:bottomView];
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
