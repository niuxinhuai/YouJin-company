//
//  HeadLineMainViewController+Configuration.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineMainViewController.h"
#import "HomeLineHeadBarView.h"
#import "BannerModel.h"
#import "HeadLineDetailViewController.h"


@interface HeadLineMainViewController (Configuration)


- (void)configureViews;
- (void)configureLayoutConstraint;

- (SDCycleScrollView *)getHeadView;
- (HomeLineHeadBarView *)getHeadBarView;




@end
