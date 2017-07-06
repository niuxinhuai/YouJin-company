//
//  CommentCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/11.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCell];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - configuration

- (void)configureCell {
    self.contentLabel.lineSpacing = 1;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)updateCommentModel:(CommentModel *)model {
    self.model = model;
    self.contentLabel.text = model.content;
    self.timeLabel.text = model.time_h;
    self.tagetTitleLabel.text = model.from;
    self.tagetNameLabel.text = model.uname;
    self.targetTimeLabel.text = [NSString stringWithFormat:@"发表于 %@",model.time_w];
}



@end
