//
//  NewCarLoanRankViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NewCarLoanRankViewController.h"
#import "CarLoanRankCell.h"
#import "NSMutableDictionary+Utilities.h"

@interface NewCarLoanRankViewController ()

@end

@implementation NewCarLoanRankViewController

+(instancetype)create {
    NewCarLoanRankViewController *vc = [[NewCarLoanRankViewController alloc]init];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTools];
    [self configureViews];
    [self requestForCarLoanRankListWithStart:0 rankKey:self.key];
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
    [self configureSectionView];
}

- (void)configureSectionView {
    self.sectionBar = ({
        ConditionSelectedBar *view = [[ConditionSelectedBar alloc]init];
        view.layout.itemSize = CGSizeMake([UIScreen screenWidth] / 5.0, view.layout.itemSize.height);
        [view updateNomalIcon:@"icon_sorting_no" selectIcon:@"icon_sorting_pre"];
        view.selectedIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        [view updateTitles:self.sectionTitles];
        view.delegate = self;
        view;
    });
}

- (void)configureTableView {
    [self.tableView registerClass:[CarLoanRankCell class] forCellReuseIdentifier:NSStringFromClass([CarLoanRankCell class])];
    self.tableView.delegate = self;
    self.tableView.mj_header.ignoredScrollViewContentInsetTop = -110;
}

- (void)configureTools {
    [self.sectionTitles addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"平台" isCanSelected:NO]];
    [self.sectionTitles addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"利率" isCanSelected:YES]];
    [self.sectionTitles addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"成交量" isCanSelected:YES]];
    [self.sectionTitles addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"借款人" isCanSelected:YES]];
    [self.sectionTitles addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"投资人" isCanSelected:YES]];
}

#pragma mark require

- (void)requestForCarLoanRankListWithStart:(NSInteger)start rankKey:(NSString *)key
{
    self.isRefreshing = YES;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:@(start) forKey:@"start"];
    [param setNewObject:@20 forKey:@"limit"];
    [param setNewObject:key forKey:@"by"];
    [self.manager POST:[NSString stringWithFormat:@"%@WdApi/chedaiList",BASEURL] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            NSArray *array = [CarLoanRankModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
    [self requestForCarLoanRankListWithStart:self.dataArray.count rankKey:self.key];
}

- (void)topRefreshing {
    if (self.isRefreshing) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requestForCarLoanRankListWithStart:0 rankKey:self.key];
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarLoanRankCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CarLoanRankCell class]) forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.indicatorView.backgroundColor = BOColor(252, 219, 109);
    }else if (indexPath.row == 1) {
        cell.indicatorView.backgroundColor = BOColor(206, 209, 216);
    }else if (indexPath.row == 2) {
        cell.indicatorView.backgroundColor = BOColor(251, 176, 164);
    }else {
        cell.indicatorView.backgroundColor = [UIColor clearColor];
    }
    cell.item = self.dataArray[indexPath.row];
    if (indexPath.row == self.dataArray.count - 4) [self bottomRefreshing];
    return cell;
}

#pragma mark - <UITableViewDelegate>
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.sectionBar;
}

#pragma mark - <ConditionSelectedBarDelegate>

- (void)conditionSelectedBar:(ConditionSelectedBar *)conditionBar didSelectedIndexPath:(NSIndexPath *)indexPath {
    ConditionSelectedModel *model = conditionBar.titles[indexPath.row];
    if (model.isCanSelected) {
        if ([model.title isEqualToString:@"利率"]) {
            self.key = @"apr";
        }else if ([model.title isEqualToString:@"成交量"]) {
            self.key = @"trade";
        }else if ([model.title isEqualToString:@"借款人"]) {
            self.key = @"borrower_num";
        }else if ([model.title isEqualToString:@"投资人"]) {
            self.key = @"tender_num";
        }
        [self.tableView.mj_header beginRefreshing];
    }
}

#pragma mark - reget

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)sectionTitles {
    if (!_sectionTitles) {
        _sectionTitles = [NSMutableArray array];
    }
    return _sectionTitles;
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
