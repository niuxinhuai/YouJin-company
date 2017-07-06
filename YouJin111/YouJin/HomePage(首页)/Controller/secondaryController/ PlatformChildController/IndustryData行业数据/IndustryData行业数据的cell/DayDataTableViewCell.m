//
//  DayDataTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "DayDataTableViewCell.h"
#import "IndustryDataModel.h"

@implementation DayDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setItems:(IndustryDataModel *)items
{
    _items = items;
    self.nameLab.text = items.name;
}
@end
