//
//  TopContentDetailCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopContentModel.h"
#import <WebKit/WebKit.h>
#import "HeadView.h"

@protocol TopContentDetailCellDelegate;

@interface TopContentDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet HeadView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *subscribeButton;
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView;

@property (weak, nonatomic) IBOutlet UIButton *rewardButton;
@property (weak, nonatomic) IBOutlet UILabel *favourCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *rewardCountLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewHeight;



@property (nonatomic, retain) TopContentModel *content;
@property (nonatomic, assign) id<TopContentDetailCellDelegate> delegate;
@property (nonatomic, assign) BOOL isObserving;


+ (instancetype)create;


- (void)updateContent:(TopContentModel *)content;
- (void)updateSubscribeStatus:(BOOL)subscribe;
- (void)updateRewarderCount:(NSInteger)rewarderCount;


@end

@protocol TopContentDetailCellDelegate <NSObject>

@optional

- (void)topContentDetailCell:(TopContentDetailCell *)cell heightChange:(CGFloat)height;
- (void)topContentDetailCell:(TopContentDetailCell *)cell didClickSubscribe:(BOOL)isSubscribe;
- (void)topDetailCellDidClickStarButton:(TopContentDetailCell *)cell;
- (void)topDetailCellAlertToLogin:(TopContentDetailCell *)cell;
- (void)topDetailCellRewardAction:(TopContentDetailCell *)cell;
- (void)topDetailCellDidClickHeadImageView:(TopContentDetailCell *)cell;
- (void)topDetailCellDidClickWrongButton:(TopContentDetailCell *)cell;
@end
