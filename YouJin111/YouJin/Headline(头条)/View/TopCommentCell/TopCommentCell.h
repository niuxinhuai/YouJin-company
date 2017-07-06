//
//  TopCommentCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/19.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
#import "HuifuModel.h"
#import "HeadView.h"

@protocol TopCommentCellDelegate;

@interface TopCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet HeadView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *favourButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (nonatomic, retain) HuifuModel *commentModel;
@property (nonatomic, assign) id<TopCommentCellDelegate> delegate;

- (void)updateCommentModel:(HuifuModel *)model;


@end

@protocol TopCommentCellDelegate <NSObject>

@optional

- (void)topCommentCellDidClickReplyButton:(TopCommentCell *)cell;
- (void)topCommentCellDidClickStarButton:(TopCommentCell *)cell;
- (void)topCommentCellDidClickName:(TopCommentCell *)cell;
- (void)topCommentCellDidClickHeadImageView:(TopCommentCell *)cell;
- (void)topCommentCellAlertToLogin:(TopCommentCell *)cell;

@end

