//
//  NetCreditRatingTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NetCreditRatingTableViewCell.h"
#import "YjRatingModel.h"

@implementation NetCreditRatingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setItem:(YjRatingModel *)item
{
    _item = item;
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:[UIImage imageNamed:@"img_loadinga"]];
    self.platformRatesLabel.text = [NSString stringWithFormat:@"%@%@",item.apr_max,@"%"];
    self.PlatformBackgroundLabel.text = item.tab;
    self.levelLabel.text = item.level;
    self.numberLabel.text = item.seq;
}
@end
