//
//  RightDayDataTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "RightDayDataTableViewCell.h"
#import "IndustryDataModel.h"

@implementation RightDayDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setItem:(IndustryDataModel *)item
{
    _item = item;
    self.interestLab.text = item.apr;
    self.moneyLab.text = item.input;
    self.peopleLab.text = item.tender;
    self.borrowingLab.text = item.borrower;
    self.clinchLab.text = item.yesterday_done;
    self.totalLab.text = item.sum_borrow;
}
@end
