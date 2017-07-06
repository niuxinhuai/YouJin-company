//
//  BOUMoneyCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOUMoneyCell.h"
#import "UMoneyIncomeItem.h"
#import "NSString+Utilities.h"


@interface BOUMoneyCell()

@property (nonatomic, retain) UIView *lineView;

@end

@implementation BOUMoneyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 设置头像imageView
        self.accessoryType = UITableViewCellAccessoryNone;
        CGFloat iconX = 15 * BOWidthRate;
        CGFloat iconY = 10 * BOHeightRate;
        CGFloat iconWH = 36 * BOWidthRate;
        UIImageView *iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconWH, iconWH)];
        self.iconImageV = iconImageV;
        iconImageV.layer.cornerRadius = 18 * BOWidthRate;
        iconImageV.layer.masksToBounds = YES;
        [self.contentView addSubview:iconImageV];
        // 设置titleLabel
        CGFloat titleX = CGRectGetMaxX(iconImageV.frame) + 15 * BOWidthRate;
        CGFloat titleY = 12 * BOHeightRate;
        CGFloat titleW = 100 * BOWidthRate;
        CGFloat titleH = 15 * BOHeightRate;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        self.titleLabel = titleLabel;
        titleLabel.textColor = [UIColor blackColor];
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.contentView addSubview:titleLabel];
        // 添加subtitleLabel
        CGFloat subTitleX = titleX;
        CGFloat subTitleY = CGRectGetMaxY(titleLabel.frame) + 10 * BOHeightRate;
        CGFloat subTitleW = BOScreenW - 141 * BOWidthRate;
        CGFloat subTitleH = 10 * BOHeightRate;
        UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(subTitleX, subTitleY, subTitleW, subTitleH)];
        self.subTitleLabel = subTitleLabel;
        subTitleLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        [subTitleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:subTitleLabel];
        // 添加U币数量Label
        CGFloat NumX = BOScreenW - 110 * BOWidthRate;
        CGFloat NumY = 18 * BOHeightRate;
        CGFloat NumW = 100 * BOWidthRate;
        CGFloat NumH = 20 * BOHeightRate;
        UILabel *NumLabel = [[UILabel alloc] initWithFrame:CGRectMake(NumX, NumY, NumW, NumH)];
        self.NumLabel = NumLabel;
        NumLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [NumLabel setFont:[UIFont systemFontOfSize:15]];
        NumLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:NumLabel];
        
       // [self addLineView];
    }
    return self;
}


- (void)addLineView {
    self.lineView = ({
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithIntRed:244 green:244 blue:244 alpha:1];
        [self.contentView addSubview:view];
        view;
    });
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@1);
    }];
    
}

- (void)updateItems:(UMoneyIncomeItem *)item add:(BOOL)isAdd {
    if (item != self.item) {
        self.item = item;
        self.titleLabel.text = _item.desc;
        self.subTitleLabel.text = _item.time_h;
        self.NumLabel.text = [NSString stringWithNumber:item.slice add:isAdd];
        self.iconImageV.image = [UIImage imageNamed:[item getIconImageUrlString]];
    }
}

#pragma mark - helpMethod

- (void)loadImageViewWithItem:(UMoneyIncomeItem *)item {
    
}


@end
