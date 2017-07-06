//
//  MessageBaseController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/3.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MessageBaseController.h"

@interface MessageBaseController ()

@end

@implementation MessageBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - configureView;

- (void)configureViews {
    [self addLackView];
    [self addTableView];
}


- (void)addLackView {
    self.lackView = ({
        LackVIew *view = [[LackVIew alloc]init];
        [self.view insertSubview:view atIndex:0];
        view.hidden = YES;
        view;
    });
    
    [self.lackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(-64));
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
    }];
}

- (void)addTableView {
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.dataSource = self;
        tableView.delegate = self;
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(messageTopRefreshing)];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        tableView.mj_header = header;
        MJRefreshFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(messageBottomRefreshing)];
        tableView.mj_footer = footer;
        [self.view addSubview:tableView];
        tableView;
    });
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
    }];
}


#pragma mark - reget

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - publicMethod

- (void)hiddenLackView:(BOOL)hidden {
    if (!hidden) [self.view bringSubviewToFront:self.lackView];
    self.lackView.hidden = hidden;
    self.tableView.hidden = !hidden;
}

- (void)tableViewEndRefreshing {
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}

- (void)handleNewDataArray:(NSArray *)array {
    if (!array) return;
    [self.dataArray addObjectsFromArray:array];
    MJRefreshBackStateFooter *foot = (MJRefreshBackStateFooter *)self.tableView.mj_footer;
    if (self.dataArray.count == 0) {
        [self hiddenLackView:NO];
        foot.stateLabel.hidden = self.dataArray.count == 0;
    }
    if (array.count < 20) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        self.isNoMoreData = YES;
    }
    [self.tableView reloadData];
    self.isRefreshing = NO;
}

#pragma mark - actionMethod

- (void)messageTopRefreshing {
}

- (void)messageBottomRefreshing {
}

- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - helpMethod

- (void)configureBars {
    self.navigationController.navigationBar.hidden = NO;
    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // 隐藏底部的tabbar
    //    self.tabBarController.tabBar.hidden = YES;
    
    // 设置navigationItem的左边按钮
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    //    self.navigationItem.leftBarButtonItem = btnItem;
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
}



@end
