//
//  BOAttentionCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/4.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOAttentionCell.h"
#import "UIView+Frame.h"

@implementation BOAttentionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCell];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)configureCell {
    [self.headImageView makeCornerWithCornerRadius:self.headImageView.width / 2.0];
    self.headImageView.clipsToBounds = YES;
}



#pragma mark - publicMethod

- (void)updateModel:(AttentionModel *)model {
    self.model = model;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.head_image]];
    self.nameLabel.text = model.uname;
    self.timeLabel.text = model.time_h;
}




@end
