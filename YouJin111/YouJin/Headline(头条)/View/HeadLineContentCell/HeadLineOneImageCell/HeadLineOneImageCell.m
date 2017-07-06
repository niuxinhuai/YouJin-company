//
//  HeadLineOneImageCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineOneImageCell.h"

@implementation HeadLineOneImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCell];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell {
    [self.coverImageView makeCornerWithCornerRadius:5];
}

#pragma mark - ovvride
- (void)updateContent:(TopContentModel *)content{
    [super updateContent:content];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[content.cover[0] objectForKey:@"cover"]]  placeholderImage:[UIImage imageNamed:@"top_place_image"] options:SDWebImageCacheMemoryOnly];
}

@end
