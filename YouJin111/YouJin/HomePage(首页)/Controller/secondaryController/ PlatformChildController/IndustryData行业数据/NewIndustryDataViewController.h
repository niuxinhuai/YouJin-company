//
//  NewIndustryDataViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeLineHeadBarView.h"
#import "ConditionSelectedBar.h"

@interface NewIndustryDataViewController : BaseViewController

@property (weak, nonatomic) IBOutlet HomeLineHeadBarView *topBar;
@property (weak, nonatomic) IBOutlet ConditionSelectedBar *leftSectionBar;
@property (weak, nonatomic) IBOutlet ConditionSelectedBar *rightSectionBar;
@property (weak, nonatomic) IBOutlet UIView *sectionContainer;
@property (weak, nonatomic) IBOutlet UIButton *redPacket;
@property (nonatomic, strong) UIScrollView *baseScrollView;
@property (nonatomic, strong) UIScrollView *rightScrollView;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightSectionLeadingToLeftSectionRight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redPacketCenterXToSuperRight;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *timeKey;
@property (nonatomic, assign) BOOL isCanLoadMore;
@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL isNoMoreData;



@end
