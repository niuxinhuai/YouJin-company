//
//  CityShopCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CityShopCell.h"

@implementation CityShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCell];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell {
    [self.logoImageView makeCornerWithCornerRadius:8];
}


#pragma mark - helpMethid

- (void)updateCityShopModel:(CityShopModel *)model {
    self.model = model;
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"] options:SDWebImageCacheMemoryOnly];
    self.nameLable.text = model.name;
    [self.locationButton setTitle:model.addr forState:UIControlStateNormal];
    self.earnCountLabel.text = [self earnStringWithMinCount:model.apr_min max:model.apr_max];
}


- (NSString *)earnStringWithMinCount:(NSNumber *)min max:(NSNumber *)max {
    return [NSString stringWithFormat:@"%@%%~%@%%",min,max];
}

@end
