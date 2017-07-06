//
//  CurrentGoldViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CurrentGoldViewController.h"
#import "EachGoldTableViewCell.h"
#import "CurrentModel.h"
#import "EachGoldView.h"
#import "CurrentSectionHeaderView.h"
#import "NSMutableDictionary+Utilities.h"

@interface CurrentGoldViewController ()<UITableViewDelegate>

@end

@implementation CurrentGoldViewController

+ (instancetype)createWithTableViewStyle:(UITableViewStyle)style {
    CurrentGoldViewController *vc = [CurrentGoldViewController create];
    vc.tableViewStyle = style;
    return vc;
}

+(instancetype)create {
    CurrentGoldViewController *vc = [[CurrentGoldViewController alloc]init];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTools];
    [self configureViews];
    [self requestForGoldCurrentDataWithStart:0 rankKey:self.key];
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

- (void)configureTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"EachGoldTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([EachGoldTableViewCell class])];
    self.tableView.delegate = self;
    self.tableView.mj_header.ignoredScrollViewContentInsetTop = - 110;
    
}

- (void)configureSectionView {
    self.sectionBar = ({
        ConditionSelectedBar *view = [[ConditionSelectedBar alloc]init];
        view.layout.itemSize = CGSizeMake([UIScreen screenWidth] / 4.0, view.layout.itemSize.height);
        [view updateNomalIcon:@"icon_sorting_no" selectIcon:@"icon_sorting_pre"];
        view.selectedIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [view updateTitles:self.sectionTitles];
        view.delegate = self;
        view;
    });
}

- (void)configureTools {
    self.key = @"today_apr";
    [self.sectionTitles addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"产品" isCanSelected:NO]];
    [self.sectionTitles addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"当日年化" isCanSelected:YES]];
    [self.sectionTitles addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"万份收益" isCanSelected:YES]];
    [self.sectionTitles addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"提现速度" isCanSelected:YES]];
}

#pragma mark require

- (void)requestForGoldCurrentDataWithStart:(NSInteger)start rankKey:(NSString *)key
{
    self.isRefreshing = YES;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:@(start) forKey:@"start"];
    [param setNewObject:@20 forKey:@"limit"];
    [param setNewObject:key forKey:@"by"];
    
    [self.manager POST:[NSString stringWithFormat:@"%@Huoqi/huoqiList",BASEURL] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            NSArray *array = [CurrentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
    [self requestForGoldCurrentDataWithStart:self.dataArray.count rankKey:self.key];
}

- (void)topRefreshing {
    if (self.isRefreshing) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requestForGoldCurrentDataWithStart:0 rankKey:self.key];
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EachGoldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EachGoldTableViewCell class])];
    cell.item = self.dataArray[indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell updateIndexPath:indexPath];
    if (indexPath.row == self.dataArray.count - 4) {
        [self bottomRefreshing];
    }
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
        if ([model.title isEqualToString:@"当日年化"]) {
            self.key = @"today_apr";
        }else if ([model.title isEqualToString:@"万份收益"]) {
            self.key = @"wf_lixi";
        }else if ([model.title isEqualToString:@"提现速度"]) {
            self.key = @"tixian";
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
