//
//  IncreasesZoneTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/7.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "IncreasesZoneTableViewCell.h"
#import "InterestRatesModel.h"

@implementation IncreasesZoneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_aNoviceLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
    _percentageLabel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:36];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setItem:(InterestRatesModel *)item
{
    _item = item;
    self.financialsLabel.text = item.name;
    self.percentageLabel.text = [NSString stringWithFormat:@"%@%@",item.show_money,@"%"];
    self.registeredsLabel.text = item.desc;
}
@end
