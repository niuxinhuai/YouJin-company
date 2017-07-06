//
//  BOUMoneyExpendVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOUMoneyExpendVC.h"
#import "BOUMoneyCell.h"
#import "UMoneyIncomeItem.h"
static NSString *const ID = @"cell";
@interface BOUMoneyExpendVC ()
@property (nonatomic, weak) AFHTTPSessionManager *mgr;
@property (nonatomic, strong) NSMutableArray *dataArrayM;

@end

@implementation BOUMoneyExpendVC
#pragma mark - 网络请求对象
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}
- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        _dataArrayM = [NSMutableArray array];
    }
    return _dataArrayM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNetData];
    // 注册cell
    [self.tableView registerClass:[BOUMoneyCell class] forCellReuseIdentifier:ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOUMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (indexPath.row % 2 == 0) {
        cell.iconImageV.image = [UIImage imageNamed:@"icon_choujiang"];
        cell.titleLabel.text = @"抽奖";
        cell.subTitleLabel.text = @"2017-01-01 15:32";
        cell.NumLabel.text = @"-200";
    }else if (indexPath.row % 2 == 1) {
        cell.iconImageV.image = [UIImage imageNamed:@"icon_tixian"];
        cell.titleLabel.text = @"提现";
        cell.subTitleLabel.text = @"2017-01-01 15:32";
        cell.NumLabel.text = @"-300";
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56 * BOHeightRate;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * BOWidthRate, 0, 60, 25 * BOHeightRate)];
    [headLabel setFont:[UIFont systemFontOfSize:14]];
    headLabel.text = @"本月";
    headLabel.textColor = BOColor(125, 126, 128);
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 25 * BOHeightRate)];
    headView.backgroundColor = BOColor(245, 246, 247);
    [headView addSubview:headLabel];
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25 * BOHeightRate;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}
#pragma mark - 加载最新数据
- (void)loadNetData {
    NSString *url = [NSString stringWithFormat:@"%@Ucenter/getMyFlowList",BASEURL];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"at"] = tokenString;
    dictionary[@"uid"] = USERUID;
    dictionary[@"sid"] = USERSid;
    dictionary[@"type"] = @"del";
    dictionary[@"start"] = @"0";
    dictionary[@"limit"] = @"20";
    
    [self.mgr POST:url parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataArrayM = [UMoneyIncomeItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (self.dataArrayM.count == 0) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 加载更多数据
- (void)loadMoreDate {
    
}

@end
