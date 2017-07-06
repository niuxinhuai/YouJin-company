//
//  OfficialMessageCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "OfficialMessageCell.h"

@implementation OfficialMessageCell

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
    [self.contentContainer makeCornerWithCornerRadius:8];
}

#pragma mark - publicMethod

- (void)updateSystemNoticeModel:(SystemNoticeModel *)model {
    self.model = model;
    self.timeLabel.text = model.time_h;
    self.contentLabel.text = model.content;
    self.titleLabel.text = model.title;
}

@end
