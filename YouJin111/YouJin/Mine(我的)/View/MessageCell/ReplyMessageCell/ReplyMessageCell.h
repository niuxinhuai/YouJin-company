//
//  ReplyMessageCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
#import "HuifuModel.h"

@interface ReplyMessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetLabel;


@property (nonatomic, retain) HuifuModel *model;


- (void)updateMessgaeModel:(HuifuModel *)model;


@end
