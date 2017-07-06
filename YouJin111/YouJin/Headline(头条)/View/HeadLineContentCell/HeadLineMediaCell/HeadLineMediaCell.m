//
//  HeadLineMediaCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineMediaCell.h"

@implementation HeadLineMediaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCell];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.coverImageView makeCornerWithCornerRadius:5];
    [self.extensionLable makeCornerBorderWithWidth:1 cornerRadius:4 borderColor:[UIColor redColor]];
}


#pragma mark - publicMethod

- (void)updateAdvertisement:(AdvertisementModel *)model {
    self.model = model;
    self.titleLabel.text = model.desc;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.img_url] placeholderImage:[UIImage placeholderImage] options:SDWebImageCacheMemoryOnly];
    self.sourceLable.text = model.pname;
}



@end
