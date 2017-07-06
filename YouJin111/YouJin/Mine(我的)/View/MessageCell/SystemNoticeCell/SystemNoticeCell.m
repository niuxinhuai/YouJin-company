//
//  SystemNoticeCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "SystemNoticeCell.h"

@implementation SystemNoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




#pragma mark - publicMethod

- (void)updateSystemNoticeModel:(SystemNoticeModel *)model {
    self.model = model;
    self.timeLabel.text = model.before;
    self.contentLabel.text = model.note;
    self.titleLabel.text = model.title;
    self.statusImageView.image = [model.status integerValue] == 1 ? [UIImage imageNamed:@"icon_wancheng"] : [UIImage imageNamed:@"icon_shiba"];
}



@end
