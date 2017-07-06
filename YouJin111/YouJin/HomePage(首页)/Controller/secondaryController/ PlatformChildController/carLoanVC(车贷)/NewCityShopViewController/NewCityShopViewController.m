//
//  NewCityShopViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NewCityShopViewController.h"
#import "NSMutableDictionary+Utilities.h"

@interface NewCityShopViewController ()

@end

@implementation NewCityShopViewController

+(instancetype)create {
    NewCityShopViewController *vc = [[NewCityShopViewController alloc]init];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    [self requestForCityShopListWithStart:0 city:self.city];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - configureViews
- (void)configureViews {
    self.isCanRefresh = YES;
    self.isCanLoadMore = YES;
    [self configureTableView];
}


- (void)configureTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"CityShopCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([CityShopCell class])];
    self.tableView.delegate = self;
    self.tableView.mj_header.ignoredScrollViewContentInsetTop = -110;
}


#pragma mark require

- (void)requestForCityShopListWithStart:(NSInteger)start city:(NSString *)city
{
    self.isRefreshing = YES;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:@(start) forKey:@"start"];
    [param setNewObject:@20 forKey:@"limit"];
    [param setNewObject:city forKey:@"city"];
    [self.manager POST:[NSString stringWithFormat:@"%@WdApi/nearStoreList",BASEURL] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            NSArray *array = [CityShopModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self handleRequestForGoldCurrentSuccessWithData:array start:start];
            [self.tableView reloadData];
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
        [self tableViewEndRefreshing];
        self.isRefreshing = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self tableViewEndRefreshing];
        self.isRefreshing = NO;
    }];
}

#pragma mark - ovrride

- (void)bottomRefreshing {
    if (self.isRefreshing || self.isNoMoreData) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requestForCityShopListWithStart:self.dataArray.count city:self.city];
}

- (void)topRefreshing {
    if (self.isRefreshing) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requestForCityShopListWithStart:0 city:self.city];
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityShopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CityShopCell class]) forIndexPath:indexPath];
    [cell updateCityShopModel:self.dataArray[indexPath.row]];
    if (indexPath.row == self.dataArray.count - 4) [self bottomRefreshing];
    return cell;
}

#pragma mark - <UITableViewDelegate>
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112;
}


#pragma mark - reget

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSString *)city {
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"loaction_city"]) {
        return [[NSUserDefaults standardUserDefaults]objectForKey:@"loaction_city"];
    }
    return @"杭州";
}

#pragma mark - helpMethod

- (void)handleRequestForGoldCurrentSuccessWithData:(NSArray *)data start:(NSInteger)start {
    if (start == 0) [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:data];
    MJRefreshBackStateFooter *foot = (MJRefreshBackStateFooter *)self.tableView.mj_footer;
    foot.stateLabel.hidden = self.dataArray.count == 0;
    if (data.count < 20) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        self.isNoMoreData = YES;
    }
}




@end
