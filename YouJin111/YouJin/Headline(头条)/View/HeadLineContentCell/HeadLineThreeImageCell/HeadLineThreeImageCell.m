//
//  HeadLineThreeImageCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineThreeImageCell.h"

@implementation HeadLineThreeImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCell];
}

- (void)configureCell {
    [self.firstImageView makeCornerWithCornerRadius:5];
    [self.secondImageView makeCornerWithCornerRadius:5];
    [self.thirdImageView makeCornerWithCornerRadius:5];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateContent:(TopContentModel *)content{
    [super updateContent:content];
    [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:[content.cover[0] objectForKey:@"cover"]]  placeholderImage:[UIImage imageNamed:@"top_place_image"] options:SDWebImageCacheMemoryOnly];
    [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:[content.cover[1] objectForKey:@"cover"]]  placeholderImage:[UIImage imageNamed:@"top_place_image"] options:SDWebImageCacheMemoryOnly];
    [self.thirdImageView sd_setImageWithURL:[NSURL URLWithString:[content.cover[2] objectForKey:@"cover"]]  placeholderImage:[UIImage imageNamed:@"top_place_image"] options:SDWebImageCacheMemoryOnly];
}




@end
