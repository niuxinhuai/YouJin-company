//
//  CarLoanRankCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/23.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CarLoanRankCell.h"
#import "CarLoanRankModel.h"

@interface CarLoanRankCell ()
@property (nonatomic, weak) UIImageView *imageV;
@property (nonatomic, weak) UILabel *turnoverLabel;
@property (nonatomic, weak) UILabel *borrowerLabel;
@property (nonatomic, weak) UILabel *investorLabel;
@property (nonatomic, strong) UIView *lineView;
@end
@implementation CarLoanRankCell

#pragma mark - 自定义carLoanCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加最左边的图标
        UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 15 * BOScreenH / BOPictureH, 6 * BOScreenW / BOPictureW, 20 * BOScreenH / BOPictureH)];
        self.indicatorView = indicatorView;
        // 添加图片View
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(14 * BOScreenW / BOPictureW, 7 * BOScreenH / BOPictureH, 65 * BOScreenW / BOPictureW, 30 * BOScreenH / BOPictureH)];
        self.imageV = imageV;
        imageV.image = [UIImage imageNamed:@"logo_youjin"];
        imageV.layer.cornerRadius = 4;
        imageV.layer.masksToBounds = YES;
        // 添加利率的label
        UILabel *ratelabel = [[UILabel alloc] initWithFrame:CGRectMake(100 * BOScreenW / BOPictureW, 8 * BOScreenH / BOPictureH, 65 * BOScreenW / BOPictureW, 30 * BOScreenH / BOPictureH)];
        ratelabel.text = @"12.6%";
        self.ratelabel = ratelabel;
        [ratelabel setFont:[UIFont systemFontOfSize:14]];
        // 添加成交量的label
        UILabel *turnoverLabel = [[UILabel alloc] initWithFrame:CGRectMake(165 * BOScreenW / BOPictureW, 8 * BOScreenH / BOPictureH, 70 * BOScreenW / BOPictureW, 30  * BOScreenH / BOPictureH)];
        self.turnoverLabel = turnoverLabel;
        turnoverLabel.text = @"26000万";
        [turnoverLabel setFont:[UIFont systemFontOfSize:14]];
        // 添加借款人的label
        UILabel *borrowerLabel = [[UILabel alloc] initWithFrame:CGRectMake(247 * BOScreenW / BOPictureW , 8 * BOScreenH / BOPictureH, 65 * BOScreenW / BOPictureW, 30 * BOScreenH / BOPictureH)];
        self.borrowerLabel = borrowerLabel;
        borrowerLabel.text = @"173672";
        [borrowerLabel setFont:[UIFont systemFontOfSize:14]];
        
        // 添加投资人的label
        UILabel *investorLabel = [[UILabel alloc] initWithFrame:CGRectMake(315 * BOScreenW / BOPictureW, 8 * BOScreenH / BOPictureH, 65 * BOScreenW / BOPictureW, 30 * BOScreenH / BOPictureH)];
        self.investorLabel = investorLabel;
        investorLabel.text = @"612900";
        [investorLabel setFont:[UIFont systemFontOfSize:14]];
        
        [self addSubview:indicatorView];
        [self addSubview:imageV];
        [self addSubview:ratelabel];
        [self addSubview:turnoverLabel];
        [self addSubview:borrowerLabel];
        [self addSubview:investorLabel];
        [self addlineView];
    }
    ;
    return self;
}

- (void)addlineView {
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

- (void)setItem:(CarLoanRankModel *)item {
    _item = item;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:perchImage];
    self.ratelabel.text = [NSString stringWithFormat:@"%@%%",item.apr];
    self.turnoverLabel.text = [NSString stringWithFormat:@"%@亿",item.trade];
    self.borrowerLabel.text = item.borrower_num;
    self.investorLabel.text = item.tender_num;
}
@end
