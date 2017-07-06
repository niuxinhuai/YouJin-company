//
//  MineHomePageViewController+Configuration.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MineHomePageViewController.h"
#import "UserPageHeaderView.h"
#import "MineHomePageViewController+Delegate.h"
#import "MineHomePageViewController+LogicalFlow.h"

@interface MineHomePageViewController (Configuration)


- (void)configureViews;
- (void)updateUserMessage;



- (UserPageBar *)getHeadBar;
- (UserPageHeaderView *)getHeadView;
- (BOOL)isMe;
- (void)updateSubscribeStatus:(BOOL)subscribe;


@end
