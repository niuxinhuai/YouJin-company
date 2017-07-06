//
//  NomalCityCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NomalCityCell.h"

@implementation NomalCityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)updateCityDetailModel:(CityDetailModel *)model {
    self.model = model;
    self.nameLabel.text = model.name;
}


@end
