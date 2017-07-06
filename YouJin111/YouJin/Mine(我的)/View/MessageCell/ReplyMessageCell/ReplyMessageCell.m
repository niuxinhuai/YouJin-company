//
//  ReplyMessageCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "ReplyMessageCell.h"

@implementation ReplyMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCell];
}


- (void)configureCell {
    [self.headImageView makeCornerWithCornerRadius:self.headImageView.width / 2.0];
    self.contentLabel.lineSpacing = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



#pragma mark - publicMethod

- (void)updateMessgaeModel:(HuifuModel *)model {
    self.model = model;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.head_image] placeholderImage:[UIImage imageNamed:@"pic_touxiang"] options:SDWebImageCacheMemoryOnly];
    self.nameLabel.text = model.uname;
    self.contentLabel.text = model.content;
    self.timeLabel.text = model.time_h;
    self.targetLabel.text = model.from;
}




@end
