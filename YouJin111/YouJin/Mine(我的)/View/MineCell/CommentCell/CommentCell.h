//
//  CommentCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/11.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
#import "CommentModel.h"

@interface CommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet TTTAttributedLabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagetTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagetNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetTimeLabel;


@property (nonatomic, retain) CommentModel *model;


- (void)updateCommentModel:(CommentModel *)model;




@end
