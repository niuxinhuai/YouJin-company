//
//  BOMineTaskCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOMineTaskCell.h"
#import "UMoneyRecordItem.h"

@implementation BOMineTaskCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 设置头像imageView
        CGFloat iconX = 15 * BOWidthRate;
        CGFloat iconY = 8 * BOHeightRate;
        CGFloat iconWH = 40 * BOWidthRate;
        UIImageView *iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconWH, iconWH)];
        self.iconImageV = iconImageV;
        iconImageV.layer.cornerRadius = 18 * BOWidthRate;
        iconImageV.layer.masksToBounds = YES;
        [self.contentView addSubview:iconImageV];
        // 设置titleLabel
        CGFloat titleX = CGRectGetMaxX(iconImageV.frame) + 20 * BOWidthRate;
        CGFloat titleY = 15 * BOHeightRate;
        CGFloat titleW = 60 * BOWidthRate;
        CGFloat titleH = 13 * BOHeightRate;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        self.titleLabel = titleLabel;
        titleLabel.textColor = [UIColor blackColor];
        [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        // 添加分割线View
        CGFloat divisionX = CGRectGetMaxX(titleLabel.frame) + 6 * BOWidthRate;
        CGFloat divisionY = titleY;
        CGFloat divisionW = 1;
        CGFloat divisionH = titleH;
        UIView *divisionView = [[UIView alloc] initWithFrame:CGRectMake(divisionX, divisionY, divisionW, divisionH)];
        divisionView.backgroundColor = [UIColor colorWithHexString:@"#A6A6A6" alpha:1];
        [self.contentView addSubview:divisionView];
        // 添加分割线右侧的label
        CGFloat rightX = CGRectGetMaxX(divisionView.frame) + 6 * BOWidthRate;
        CGFloat rightY = titleY;
        CGFloat rightW = 210 * BOWidthRate;
        CGFloat rightH = titleH;
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(rightX, rightY, rightW, rightH)];
        self.rightLabel = rightLabel;
        rightLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
        [rightLabel setFont: [UIFont systemFontOfSize:13]];
        [self.contentView addSubview:rightLabel];
        // 添加subtitleLabel
        CGFloat subTitleX = titleX;
        CGFloat subTitleY = CGRectGetMaxY(titleLabel.frame) + 10 * BOHeightRate;
        CGFloat subTitleW = BOScreenW - 141 * BOWidthRate;
        CGFloat subTitleH = 10 * BOHeightRate;
        UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(subTitleX, subTitleY, subTitleW, subTitleH)];
        self.subTitleLabel = subTitleLabel;
        subTitleLabel.textColor = [UIColor colorWithHexString:@"#B3B3B3" alpha:1];
        [subTitleLabel setFont:[UIFont systemFontOfSize:11]];
        [self.contentView addSubview:subTitleLabel];
        // 添加数量Label
        CGFloat NumX = BOScreenW - 110 * BOWidthRate;
        CGFloat NumY = 30 * BOHeightRate;
        CGFloat NumW = 100 * BOWidthRate;
        CGFloat NumH = 13 * BOHeightRate;
        UILabel *NumLabel = [[UILabel alloc] initWithFrame:CGRectMake(NumX, NumY, NumW, NumH)];
        self.NumLabel = NumLabel;
        NumLabel.textColor = BOColor(247, 67, 0);
        [NumLabel setFont:[UIFont systemFontOfSize:13]];
        NumLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:NumLabel];

    }
    return self;
}
- (void)setItem:(UMoneyRecordItem *)item {
    _item = item;
}

#pragma mark - publicMethod

- (void)updateItems:(UMoneyRecordItem *)item {
    if (item != self.item) {
        self.item = item;
        self.titleLabel.text = item.name;
        self.subTitleLabel.text = item.time_h;
        self.rightLabel.text = item.title;
        self.NumLabel.text = item.slice;
        [self updateTaskStatus:[item.status integerValue]];
    }
}


#pragma mark - helpMethod

- (void)updateTaskStatus:(NSInteger)status {
    if (status == 1) {
        self.iconImageV.image = [UIImage imageNamed:@"icon_chenggong"];
    }else {
        self.iconImageV.image = [UIImage imageNamed:@"icon_shibai"];
    }
}



@end
