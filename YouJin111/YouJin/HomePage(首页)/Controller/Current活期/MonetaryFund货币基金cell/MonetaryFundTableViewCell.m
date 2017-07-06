//
//  MonetaryFundTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MonetaryFundTableViewCell.h"
#import "MonetaryFundModel.h"

@implementation MonetaryFundTableViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    self.colorsView.hidden = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setItem:(MonetaryFundModel *)item
{
    _item = item;
    self.upFundLabel.text = item.name;
    self.downFundLabel.text = item.duijie_pt;
    self.funsLabel.text = item.company;
    self.anAnnualLabel.text = [NSString stringWithFormat:@"%@%@",item.week_lixi,@"%"];
    self.ofIncomeLabel.text = [NSString stringWithFormat:@"%@元",item.wf_lixi];
}

- (void)updateIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    switch (indexPath.row) {
        case 0: self.colorsView.backgroundColor = [UIColor colorWithIntRed:225 green:220 blue:98 alpha:1];
            break;
        case 1: self.colorsView.backgroundColor = [UIColor colorWithIntRed:208 green:208 blue:217 alpha:1];
            break;
        case 2: self.colorsView.backgroundColor = [UIColor colorWithIntRed:255 green:176 blue:109 alpha:1];
            break;
        default:
            break;
    }
    self.colorsView.hidden = indexPath.row > 2;
}

@end
