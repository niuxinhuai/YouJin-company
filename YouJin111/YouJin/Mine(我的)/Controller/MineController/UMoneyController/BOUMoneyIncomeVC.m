//
//  BOUMoneyIncomeVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOUMoneyIncomeVC.h"
#import "BOUMoneyCell.h"
#import "UMoneyIncomeItem.h"
#import <MJRefresh.h>
static NSString *const ID = @"cell";
@interface BOUMoneyIncomeVC ()
@property (nonatomic, weak) AFHTTPSessionManager *mgr;

@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL isNoMoreData;
@property (nonatomic, assign) BOOL isAdd;
@property (nonatomic, strong) NSMutableDictionary *monthDic;
@property (nonatomic, strong) NSMutableArray *monthKeys;
@property (nonatomic, assign) NSInteger dataCount;

@end

@implementation BOUMoneyIncomeVC

#pragma mark - publicMethod

+ (instancetype)createUMoneyVCWithAdd:(BOOL)isAdd {
    BOUMoneyIncomeVC *vc = [[BOUMoneyIncomeVC alloc]init];
    vc.isAdd = isAdd;
    return vc;
}

#pragma mark - 网络请求对象
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}

- (NSMutableDictionary *)monthDic {
    if (!_monthDic) {
        _monthDic = [NSMutableDictionary dictionary];
    }
    return _monthDic;
}

- (NSMutableArray *)monthKeys {
    if (!_monthKeys) {
        _monthKeys = [NSMutableArray array];
    }
    return _monthKeys;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNetData];
    [self configureViews];
    // 注册cell
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ConfigureViews 

- (void)configureViews {
    [self.tableView registerClass:[BOUMoneyCell class] forCellReuseIdentifier:ID];
    MJRefreshFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(bottomRefreshing)];
    self.tableView.mj_footer = footer;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Action

- (void)bottomRefreshing {
    [self loadMoreDate];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.monthDic.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *dataArrays = self.monthDic[self.monthKeys[section]];
    return dataArrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOUMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    NSArray *dataArrays = self.monthDic[self.monthKeys[indexPath.section]];
    [cell updateItems:dataArrays[indexPath.row] add:self.isAdd];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56 * BOHeightRate;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * BOWidthRate, 0, 60, 25)];
    [headLabel setFont:[UIFont systemFontOfSize:14]];
    headLabel.text = self.monthKeys[section];
    headLabel.textColor = BOColor(125, 126, 128);
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 25)];
    headView.backgroundColor = BOColor(245, 246, 247);
    [headView addSubview:headLabel];
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}
#pragma mark - 加载最新数据
- (void)loadNetData {
    [self loadDataWithStartCount:0 limit:10];
}

#pragma mark - 加载更多数据
- (void)loadMoreDate {
    if (self.isRefreshing && self.isNoMoreData) {
        return;
    }
    [self loadDataWithStartCount:self.dataCount limit:10];
}

- (void)loadDataWithStartCount:(NSInteger)startCount limit:(NSInteger)limitCount {
    self.isRefreshing = YES;
    NSString *url = [NSString stringWithFormat:@"%@Ucenter/getMyFlowList",BASEURL];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"at"] = tokenString;
    dictionary[@"uid"] = USERUID;
    dictionary[@"sid"] = USERSid;
    dictionary[@"type"] = self.isAdd ? @"add" : @"del";
    dictionary[@"start"] = @(startCount);
    dictionary[@"limit"] = @(limitCount);

    [self.mgr POST:url parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            NSDictionary *dic = responseObject[@"data"];
            if (dic[@"month"] && ![dic[@"month"] isKindOfClass:[NSNull class]]) {
                NSArray *newDataArray = [UMoneyIncomeItem mj_objectArrayWithKeyValuesArray:dic[@"month"]];
                [self sortOutDataArray:newDataArray];
                if (newDataArray.count < 10) {
                    self.isNoMoreData = YES;
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                self.dataCount += newDataArray.count;
                if (self.dataCount > 0) {
                    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                }
                [self.tableView reloadData];
                
            }
        }
        [self.tableView.mj_footer endRefreshing];
        self.isRefreshing = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.isRefreshing = NO;
        [self.tableView.mj_footer endRefreshing];
        NSLog(@"%@",error);
    }];
}


#pragma mark -helpMethod

- (void)sortOutDataArray:(NSArray<UMoneyIncomeItem *> *)dataArray {
    if (!dataArray || dataArray.count == 0) return;
    for (UMoneyIncomeItem *items in dataArray) {
        if (self.monthDic[items.ym]) {
            NSMutableArray *months = self.monthDic[items.ym];
            [months addObject:items];
        }else {
            NSMutableArray *months = [NSMutableArray array];
            [months addObject:items];
            [self.monthDic setValue:months forKey:items.ym];
            [self.monthKeys addObject:items.ym];
        }
    }
}




@end
