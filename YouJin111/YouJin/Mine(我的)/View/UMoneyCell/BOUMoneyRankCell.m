//
//  BOUMoneyRankCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOUMoneyRankCell.h"
#import "UMoneyUserRankItem.h"
@interface BOUMoneyRankCell()

@property (nonatomic, weak) UIImageView *iconImageV;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *uMoneyNumLabel;
@end
@implementation BOUMoneyRankCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加排名ImageView
        CGFloat rankIX = 10 * BOWidthRate;
        CGFloat rankIY = 0;
        CGFloat rankIW = 20 * BOWidthRate;
        CGFloat rankIH = 28 * BOHeightRate;
        UIImageView *rankIcon = [[UIImageView alloc] initWithFrame:CGRectMake(rankIX, rankIY, rankIW, rankIH)];
        self.rankIcon = rankIcon;
        [self.contentView addSubview:rankIcon];
        // 添加排名的数字label
        CGFloat rankNumX = 15 * BOWidthRate;
        CGFloat rankNumY = 25 * BOHeightRate;
        CGFloat rankNumW = 25 * BOWidthRate;
        CGFloat rankNumH = 15 * BOHeightRate;
        UILabel *rankNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(rankNumX, rankNumY, rankNumW, rankNumH)];
        self.rankNumLabel = rankNumLabel;
        [rankNumLabel setFont:[UIFont systemFontOfSize:18]];
        rankNumLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        [self.contentView addSubview:rankNumLabel];
        // 添加头像imageV
        CGFloat iconX = 45 * BOWidthRate;
        CGFloat iconY = 13.5 * BOHeightRate;
        CGFloat iconWH = 38 *BOWidthRate;
        UIImageView *iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconWH, iconWH)];
        self.iconImageV = iconImageV;
        iconImageV.layer.cornerRadius = 19 * BOWidthRate;
        iconImageV.layer.masksToBounds = YES;
        [self.contentView addSubview:iconImageV];
        // 添加名称label
        CGFloat nameX = CGRectGetMaxX(iconImageV.frame) + 12 * BOWidthRate;
        CGFloat nameY = rankNumY;
        CGFloat nameW = 200 * BOWidthRate;
        CGFloat nameH = 15 * BOHeightRate;
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        self.nameLabel = nameLabel;
        nameLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        [nameLabel setFont:[UIFont systemFontOfSize:15]];
        [self.contentView addSubview:nameLabel];
        // 添加U币数量的label
        CGFloat uMoneyX = 300 * BOWidthRate;
        CGFloat uMoneyY = rankNumY;
        CGFloat uMoneyW = BOScreenW - 310 * BOWidthRate;
        CGFloat uMoneyH = 15 * BOHeightRate;
        UILabel *uMoneyNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(uMoneyX, uMoneyY, uMoneyW, uMoneyH)];
        self.uMoneyNumLabel = uMoneyNumLabel;
        uMoneyNumLabel.textColor = [UIColor colorWithHexString:@"#FEAA17" alpha:1];
        [uMoneyNumLabel setFont:[UIFont systemFontOfSize:15]];
        uMoneyNumLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:uMoneyNumLabel];
        [self addLineView];
    }
    return self;
}

- (void)setItem:(UMoneyUserRankItem *)item {
    _item = item;
    if ([item.head_image isEqualToString:@""]) {
        self.iconImageV.image = [UIImage imageNamed:@"pic_touxiang"];
    }else {
       [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:item.head_image] placeholderImage:[UIImage imageNamed:@"pic_touxiang"]];
    }
    self.nameLabel.text = item.uname;
    if ([item.v_tot_get_ubi intValue] / 10000) {
       self.uMoneyNumLabel.text = [NSString stringWithFormat:@"%.2f万",[item.v_tot_get_ubi floatValue]/10000];
    }else {
        self.uMoneyNumLabel.text = [NSString stringWithFormat:@"%d",[item.v_tot_get_ubi intValue]];
    }
    
}

- (void)addLineView {
    self.lineView = ({
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor placeholderColor];
        [self.contentView addSubview:lineView];
        lineView;
    });
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.height.equalTo(@1);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
}
@end
