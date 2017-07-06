//
//  KeepAccountTableVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/31.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "KeepAccountTableVC.h"
#import "KeepAccountsCell.h"
#import "SystemSafetyModel.h"
#import "PlatformServeDetailVC.h"
static NSString *const ID = @"cell";

@interface KeepAccountTableVC ()
@property (nonatomic, weak) AFHTTPSessionManager *mgr;
@property (nonatomic, strong) NSMutableArray *dataArrayM;
@end

@implementation KeepAccountTableVC

#pragma mark - 懒加载
- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        _dataArrayM = [NSMutableArray array];
    }
    return _dataArrayM;
}
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加上拉加载和下拉刷新
    [self setupRefreshVeiw];
    self.tableView.backgroundColor = BOColor(244, 245, 247);
    // 设置navigationItem
    [self setupNavigationItem];
    [self.tableView registerClass:[KeepAccountsCell class] forCellReuseIdentifier:ID];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.alpha = 1;
}

#pragma mark - 添加上拉加载更多，和下拉刷新
- (void)setupRefreshVeiw
{
    // 添加下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requstNetData)];
    
    // 根据拖拽，自动显示下拉控件
    header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = header;
    
    // 上拉刷新
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requstMoreData)];
    
    // 自动根据有无数据，判断上拉控件是否完全显示
    footer.automaticallyHidden = YES;
    
    self.tableView.mj_footer = footer;
    
}

#pragma mark - 请求网络数据
- (void)requstNetData {
    // 请求最新点评的数据
    NSString *rankString = [NSString stringWithFormat:@"%@WdApi/serviceCompanyList",BASEURL];
    NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
    parameters1[@"at"] = tokenString;
    parameters1[@"start"] = @"0";
    parameters1[@"limit"] = @"10";
    parameters1[@"ty"] = @"4";
    [self.mgr POST:rankString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_header endRefreshing];
        self.dataArrayM = [SystemSafetyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
#pragma mark - 加载更多数据
- (void)requstMoreData {
    // 请求最新点评的数据
    NSString *rankString = [NSString stringWithFormat:@"%@WdApi/serviceCompanyList",BASEURL];
    NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
    parameters1[@"at"] = tokenString;
    parameters1[@"start"] = [NSString stringWithFormat:@"%zd",self.dataArrayM.count + 1];
    parameters1[@"limit"] = @"20";
    parameters1[@"ty"] = @"4";
    __weak __typeof(self) weakSelf = self;
    [self.mgr POST:rankString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf.tableView.mj_footer endRefreshing];
        NSArray *array = [SystemSafetyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        for (SystemSafetyModel *model in array) {
            [weakSelf.dataArrayM addObject:model];
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
#pragma mark - 设置navigationItem
- (void)setupNavigationItem {
    // 设置navigationItem的左边按钮
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(backToLevel)];
    //    self.navigationItem.leftBarButtonItem = btnItem;
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    // 设置标题
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"记账服务"];
    self.navigationItem.titleView = titleView;
//    // 设置navigationItem的右边按钮
//    UIBarButtonItem *rightBtnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"icon_search"] highImage:[UIImage imageNamed:@"icon_search"] target:self action:nil];
//    self.navigationItem.rightBarButtonItem = rightBtnItem;
}
#pragma mark - 返回上一级
- (void)backToLevel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArrayM.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KeepAccountsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.item = self.dataArrayM[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 83 * BOHeightRate;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001 * BOHeightRate;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PlatformServeDetailVC *platformServeDetailVC = [[PlatformServeDetailVC alloc] init];
    SystemSafetyModel *item = self.dataArrayM[indexPath.row];
    platformServeDetailVC.svid = item.svid;
    [self.navigationController pushViewController:platformServeDetailVC animated:YES];
}
@end
