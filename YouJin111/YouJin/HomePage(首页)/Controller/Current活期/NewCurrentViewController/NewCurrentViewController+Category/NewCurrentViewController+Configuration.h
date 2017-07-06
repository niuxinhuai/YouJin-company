//
//  NewCurrentViewController+Configuration.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NewCurrentViewController.h"
#import "HomeLineHeadBarView.h"
#import "BannerModel.h"
#import "NewCurrentViewController+LogicalFlow.h"
#import "NewCurrentViewController+Delegate.h"

@interface NewCurrentViewController (Configuration)

- (void)configureViews;

- (SDCycleScrollView *)getHeadView;
- (HomeLineHeadBarView *)getHeadBarView;


@end
