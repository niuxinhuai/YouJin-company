//
//  BOUMoneyRuleCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOUMoneyRuleCell.h"

@implementation BOUMoneyRuleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加编号label
        CGFloat numberX = 15 * BOWidthRate;
        CGFloat numberY = 12.5 * BOHeightRate;
        CGFloat numberW = 30 * BOWidthRate;
        CGFloat numberH = 15 * BOHeightRate;
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(numberX, numberY, numberW, numberH)];
        self.numberLabel = numberLabel;
        numberLabel.text = @"编号";
        [numberLabel setFont:[UIFont systemFontOfSize:14]];
        [numberLabel setTextColor:[UIColor colorWithHexString:@"#737373" alpha:1]];
        [self.contentView addSubview:numberLabel];
        // 添加项目的label
        CGFloat projectX = 75 * BOWidthRate;
        CGFloat projectY = numberY;
        CGFloat projectW = 100 * BOWidthRate;
        CGFloat projectH = numberH;
        UILabel *projectLabel = [[UILabel alloc] initWithFrame:CGRectMake(projectX, projectY, projectW, projectH)];
        self.projectLabel = projectLabel;
        projectLabel.text = @"项目";
        [projectLabel setFont:[UIFont systemFontOfSize:14]];
        [projectLabel setTextColor:[UIColor colorWithHexString:@"#737373" alpha:1]];
        [self.contentView addSubview:projectLabel];
        // 添加U币数的label
        CGFloat uMoneyX = 210 * BOWidthRate;
        CGFloat uMoneyY = numberY;
        CGFloat uMoneyW = 70 * BOWidthRate;
        CGFloat uMoneyH = numberH;
        UILabel *uMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(uMoneyX, uMoneyY, uMoneyW, uMoneyH)];
        self.uMoneyLabel = uMoneyLabel;
        uMoneyLabel.text = @"U币数";
        [uMoneyLabel setFont:[UIFont systemFontOfSize:14]];
        [uMoneyLabel setTextColor:[UIColor colorWithHexString:@"#737373" alpha:1]];
        [self.contentView addSubview:uMoneyLabel];
        // 添加每日上限的label
        CGFloat limitX = 300 * BOWidthRate;
        CGFloat limitY = numberY;
        CGFloat limitW = 60 * BOWidthRate;
        CGFloat limitH = numberH;
        UILabel *limitLabel = [[UILabel alloc] initWithFrame:CGRectMake(limitX, limitY, limitW, limitH)];
        self.limitLabel = limitLabel;
        limitLabel.text = @"每日上限";
        [limitLabel setFont:[UIFont systemFontOfSize:14]];
        [limitLabel setTextColor:[UIColor colorWithHexString:@"#737373" alpha:1]];
        [self.contentView addSubview:limitLabel];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
@end
