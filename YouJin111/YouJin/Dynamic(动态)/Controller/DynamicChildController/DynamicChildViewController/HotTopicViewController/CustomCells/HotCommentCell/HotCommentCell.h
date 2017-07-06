//
//  HotCommentCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotCommentModle.h"
#import "TTTAttributedLabel.h"
#import "HeadView.h"

@protocol HotCommentCellDelegate;

@class StarView;

@interface HotCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet HeadView *headView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentTargetLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet StarView *starView;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *targetLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *targetNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetStatusLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headImageViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLableLeftToHeadImageView;

@property (nonatomic, assign) id<HotCommentCellDelegate> delegate;
@property (nonatomic, retain) HotCommentModle *model;
@property (nonatomic, assign) BOOL showHeadImageView;
@property (nonatomic, assign) BOOL isTransform;

- (void)updateCommentModel:(HotCommentModle *)model;
- (void)updateShowHeadImageView:(BOOL)show;

@end


@protocol HotCommentCellDelegate <NSObject>

@optional

- (void)hotCommentCellDidClickName:(HotCommentCell *)cell;
- (void)hotCommentCellDidClickHeadImageView:(HotCommentCell *)cell;
- (void)hotCommentCellDidClickPlatform:(HotCommentCell *)cell;
- (void)hotCommentCellAlertToPushLogin:(HotCommentCell *)cell;
@end


