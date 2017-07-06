//
//  MessageBaseController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/3.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LackVIew.h"
#import "NSMutableDictionary+Utilities.h"
#import "BaseViewController.h"

@interface MessageBaseController : BaseViewController<UITableViewDelegate, UITableViewDataSource>



@property (nonatomic, retain) LackVIew *lackView;
@property (nonatomic, retain) UITableView *tableView;


@property (nonatomic, retain) AFHTTPSessionManager *manager;
@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL isNoMoreData;
@property (nonatomic, retain) NSMutableArray *dataArray;


- (void)configureViews;

- (void)hiddenLackView:(BOOL)hidden;
- (void)messageBottomRefreshing;
- (void)messageTopRefreshing;
- (void)tableViewEndRefreshing;
- (void)handleNewDataArray:(NSArray *)array;
- (void)configureBars;

@end
