//
//  LendRefundRateView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "LendRefundRateView.h"
#import "LendMoneyDetailModel.h"

@interface LendRefundRateView()



/**每月还款的label*/
@property (nonatomic, weak) UILabel *refundLabel;

/**参考月利率数字的Label*/
@property (nonatomic, weak) UILabel *rateNumLabel;

/**参考月利率的label*/
@property (nonatomic, weak) UILabel *rateLabel;

/**放款时间数字的label*/
@property (nonatomic, weak) UILabel *loanTimeNumLabel;

/**放款时间的label*/
@property (nonatomic, weak) UILabel *loanTimeLabel;
@end
@implementation LendRefundRateView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 添加每月还款数的label
        UILabel *refundNumLabel = [[UILabel alloc] init];
        self.refundNumLabel = refundNumLabel;
        [self addSubview:refundNumLabel];
        
        // 添加每月还款的label
        UILabel *refundLabel = [[UILabel alloc] init];
        self.refundLabel = refundLabel;
        [self addSubview:refundLabel];
        
        //添加参考月利率数字的Label
        UILabel *rateNumLabel = [[UILabel alloc] init];
        self.rateNumLabel = rateNumLabel;
        [self addSubview:rateNumLabel];
        
        // 添加参考月利率的label
        UILabel *rateLabel = [[UILabel alloc] init];
        self.rateLabel = rateLabel;
        [self addSubview:rateLabel];
        
        // 添加放款时间数字的label
        UILabel *loanTimeNumLabel = [[UILabel alloc] init];
        self.loanTimeNumLabel = loanTimeNumLabel;
        [self addSubview:loanTimeNumLabel];
        
        // 添加放款时间的label
        UILabel *loanTimeLabel = [[UILabel alloc] init];
        self.loanTimeLabel = loanTimeLabel;
        [self addSubview:loanTimeLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setItem:(LendMoneyDetailModel *)item {
    _item = item;
    // 每个Label的宽度应该是屏幕的1/3,
    CGFloat labelW = 0.33 * BOScreenW;
    // 设置每月还款数的label
    CGFloat refundNumX = 0;
    CGFloat refundNumY = 65 * BOHeightRate;
    CGFloat refundNumW = labelW;
    CGFloat refundNumH = 20 * BOHeightRate;
    self.refundNumLabel.frame = CGRectMake(refundNumX, refundNumY, refundNumW, refundNumH);
    self.refundNumLabel.text = @"-";
    [self.refundNumLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    self.refundNumLabel.textColor = [UIColor colorWithHexString:@"4697FB" alpha:1];
    self.refundNumLabel.textAlignment = NSTextAlignmentCenter;
    // 设置每月还款的label
    CGFloat refundX = 0;
    CGFloat refundY = 96 * BOHeightRate;
    CGFloat refundW = labelW;
    CGFloat refundH = 15 * BOHeightRate;
    self.refundLabel.frame = CGRectMake(refundX, refundY, refundW, refundH);
    self.refundLabel.text = @"每月还款";
    self.refundLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    [self.refundLabel setFont:[UIFont systemFontOfSize:12]];
    self.refundLabel.textAlignment = NSTextAlignmentCenter;
    // 设置参考月利率数字label
    CGFloat rateNumX = labelW;
    CGFloat rateNumY = refundNumY;
    CGFloat rateNumW = labelW;
    CGFloat rateNumH = 20 * BOHeightRate;
    self.rateNumLabel.frame = CGRectMake(rateNumX, rateNumY, rateNumW, rateNumH);
//    self.rateNumLabel.text = @"-";
    self.rateNumLabel.text = [NSString stringWithFormat:@"%@%@",item.month_apr,@"%"];
    self.rateNumLabel.textColor = [UIColor colorWithHexString:@"4697FB" alpha:1];
    [self.rateNumLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    self.rateNumLabel.textAlignment = NSTextAlignmentCenter;
    // 设置参考月利率label
    CGFloat rateX = labelW;
    CGFloat rateY = refundY;
    CGFloat rateW = labelW;
    CGFloat rateH = 15 * BOHeightRate;
    self.rateLabel.frame = CGRectMake(rateX, rateY, rateW, rateH);
    self.rateLabel.text = @"参考月利率";
    self.rateLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    [self.rateLabel setFont:[UIFont systemFontOfSize:12]];
    self.rateLabel.textAlignment = NSTextAlignmentCenter;
    // 设置最快放款时间数字的label
    CGFloat loanTimeNumX = 2 * labelW;
    CGFloat loanTimeNumY = rateNumY;
    CGFloat loanTimeNumW = labelW;
    CGFloat loanTimeNumH = rateNumH;
    self.loanTimeNumLabel.frame = CGRectMake(loanTimeNumX, loanTimeNumY, loanTimeNumW, loanTimeNumH);
//    self.loanTimeNumLabel.text = @"-";
    self.loanTimeNumLabel.text = item.give_money_time;
    [self.loanTimeNumLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    self.loanTimeNumLabel.textColor = [UIColor colorWithHexString:@"4697FB" alpha:1];
    self.loanTimeNumLabel.textAlignment = NSTextAlignmentCenter;
    // 设置最快放款时间的label
    CGFloat loanTimeX = loanTimeNumX;
    CGFloat loanTimeY = rateY;
    CGFloat loanTimeW = labelW;
    CGFloat loanTimeH = 15 * BOHeightRate;
    self.loanTimeLabel.frame = CGRectMake(loanTimeX, loanTimeY, loanTimeW, loanTimeH);
    self.loanTimeLabel.text = @"最快放款时间";
    [self.loanTimeLabel setFont:[UIFont systemFontOfSize:12]];
    self.loanTimeLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    self.loanTimeLabel.textAlignment = NSTextAlignmentCenter;

}
@end
