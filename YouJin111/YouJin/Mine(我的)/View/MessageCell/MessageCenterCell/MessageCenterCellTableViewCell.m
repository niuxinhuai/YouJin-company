//
//  MessageCenterCellTableViewCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MessageCenterCellTableViewCell.h"

@implementation MessageCenterCellTableViewCell

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
}


- (void)updateMessageModel:(MessageCenterModel *)model messageType:(MessageCenterType)type {
    self.type = type;
    self.model = model;
    switch (type) {
        case kReplyMessage: [self loadMessageWhenIsReplyMessage:model];
            break;
        case kSystemMessage: [self loadMessageWhenIsSystemMessage:model];
            break;
        case kFocusMessage: [self loadMessageWhenIsFocusMessage:model];
            break;
        case kOfficialMessage: [self loadMessageWhenIsOfficialMessage:model];
            break;
        default:
            break;
    }
}


#pragma mark - helpMethod

- (void)loadMessageWhenIsReplyMessage:(MessageCenterModel *)model {
    self.messageImageView.image = [UIImage imageNamed:@"icon_huifu"];
    self.typeLabel.text = @"回复";
    self.contentLabel.text = model.huifu.content;
    self.timeLabel.text = model.huifu.time_h;
}

- (void)loadMessageWhenIsSystemMessage:(MessageCenterModel *)model {
    self.messageImageView.image = [UIImage imageNamed:@"icon_xttz"];
    self.typeLabel.text = @"系统通知";
    self.contentLabel.text = model.sys_notice.title;
    self.timeLabel.text = model.sys_notice.time_h;
}

- (void)loadMessageWhenIsFocusMessage:(MessageCenterModel *)model {
    self.messageImageView.image = [UIImage imageNamed:@"icon_gzwd"];
    self.typeLabel.text = @"关注我的";
    self.contentLabel.text = [model.focus.uname stringByAppendingString:@"关注了你"];
    self.timeLabel.text = model.focus.time_h;
}

- (void)loadMessageWhenIsOfficialMessage:(MessageCenterModel *)model {
    self.messageImageView.image = [UIImage imageNamed:@"icon_gfxx"];
    self.typeLabel.text = @"官方消息";
    self.contentLabel.text = model.offical_notice.title;
    self.timeLabel.text = model.offical_notice.time_h;
}


@end
