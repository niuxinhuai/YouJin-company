//
//  NewIndustryDataViewController+Configuration.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NewIndustryDataViewController.h"
#import "NewIndustryDataViewController+Delegate.h"
#import "IndustryDataModel.h"
#import "DayDataTableViewCell.h"
#import "RightDayDataTableViewCell.h"
#import "NewIndustryDataViewController+LogicalFlow.h"

@interface NewIndustryDataViewController (Configuration)

- (void)configureViews;
- (void)tableViewReloadData;
- (void)endRefreshing;
- (void)topRefreshing;
- (void)bottomRefreshing;

@end
