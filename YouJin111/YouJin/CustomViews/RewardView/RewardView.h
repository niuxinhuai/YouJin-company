//
//  RewardView.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/31.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineHomePageModel.h"

#define ContainerWidthRate (290 / 375.0)
#define TopBackImageRate (18 / 59)

@protocol RewardViewDelegate;

@interface RewardView : UIView


@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *midFirstContainer;
@property (weak, nonatomic) IBOutlet UIView *midSecondContainer;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *rewardCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *rewardButton;
@property (weak, nonatomic) IBOutlet UILabel *totalCountLabel;
@property (weak, nonatomic) IBOutlet UITextField *rewardTextField;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topContainerHeght;


@property (nonatomic, retain) MineHomePageModel *userInfo;
@property (nonatomic, assign) id<RewardViewDelegate> delegate;
@property (nonatomic, assign) NSInteger rewardCount;



+ (instancetype)create;

- (void)show;
- (void)close;
- (void)closeWithAnimation:(BOOL)animation;
- (void)updateUserInfo:(MineHomePageModel *)model;



@end


@protocol RewardViewDelegate <NSObject>

@optional

- (void)rewardViewDidClosed:(RewardView *)view;
- (void)rewardView:(RewardView *)view rewardCount:(NSInteger)count;

@end

