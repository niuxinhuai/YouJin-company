//
//  BaseSwipeSubViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseViewController.h"
#import "LackVIew.h"

@protocol BaseSwipeSubViewControllerDelegate;


@interface BaseSwipeSubViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) LackVIew *lackView;

@property (nonatomic, retain) AFHTTPSessionManager *manager;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL isCanRefresh;
@property (nonatomic, assign) BOOL isCanLoadMore;
@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL isNoMoreData;
@property (nonatomic, assign) CGFloat ignoredScrollViewContentInsetBottom;

@property (nonatomic, assign) id<BaseSwipeSubViewControllerDelegate> delegate;

@property (nonatomic, assign) UITableViewStyle tableViewStyle;

- (void)topRefreshing;
- (void)bottomRefreshing;
- (void)tableViewEndRefreshing;
- (void)hiddenLackView:(BOOL)hidden;
+ (instancetype)createWithTableViewStyle:(UITableViewStyle)style;

@end



@protocol BaseSwipeSubViewControllerDelegate <NSObject>

@required
- (void)baseSwipeSubViewController:(BaseSwipeSubViewController *)controller observeContentOffset:(CGPoint)contentOffset;
@optional
- (void)baseSwipeSubViewControllerBeginDragging:(BaseSwipeSubViewController *)controller;
- (void)baseSwipeSubViewControllerEndDragging:(BaseSwipeSubViewController *)controller;
@end
