//
//  GoldMainViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseViewController.h"
#import "LackVIew.h"
#import "ToApplyForView.h"

@interface GoldMainViewController : BaseViewController

@property (weak, nonatomic) IBOutlet LackVIew *lackView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) ToApplyForView *applyView;
@property (nonatomic, retain) UIButton *applyButton;

@property (nonatomic, retain) AFHTTPSessionManager *manager;
@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL isNoMoreData;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL hasApplyForVip;


+ (instancetype)createWithHasApplyForVip:(BOOL)hasApplyForVip;

- (void)returnAction:(UIButton *)button;
- (void)applyAction:(UIButton *)button;
- (void)lackViewHidden:(BOOL)hidden;
- (void)goldFoucsBottomRefreshing;
- (void)goldFoucsTopRefreshing;


@end
