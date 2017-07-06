//
//  CityCollectionCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CityCollectionCell.h"

@implementation CityCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self makeCornerBorderWithWidth:.5 cornerRadius:5 borderColor:[UIColor colorWithIntRed:155 green:155 blue:165 alpha:0.5]];
}

- (void)updateCityDetailModel:(CityDetailModel *)model {
    self.model = model;
    self.nameLabel.text = model.name;
}


@end
