//
//  MoreBankViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/23.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MoreBankViewController.h"
#import "MoresbankTableViewCell.h"

@interface MoreBankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *bankTableView;
@property (nonatomic ,strong)NSArray *resultArr;//tableveiw的结果数组
@property (nonatomic ,strong)NSMutableArray *logourlArr;//logo的地址
@property (nonatomic ,strong)NSMutableArray *nameArr;//名字
@end

@implementation MoreBankViewController
-(NSArray *)resultArr
{
    if (_resultArr==nil)
    {
        _resultArr = [NSArray array];
    }
    return _resultArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _logourlArr = [NSMutableArray array];
    _nameArr = [NSMutableArray array];
    
    [self tableviewData];
    
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"银行存管"];
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    //创建tableview
    _bankTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH - 64) style:UITableViewStylePlain];
    _bankTableView.delegate = self;
    _bankTableView.dataSource = self;
     [_bankTableView setSeparatorInset:UIEdgeInsetsMake(0, 150*BOScreenW/750, 0, 0)];
    _bankTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_bankTableView];
//    [_bankTableView reloadData];
    
    //下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.bankTableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
}
- (void)headRefresh
{
    [self tableviewData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellString = @"cell";
    MoresbankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[MoresbankTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.nameLabel.text = _nameArr[indexPath.row];
    [cell.logoImage sd_setImageWithURL:_logourlArr[indexPath.row] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120*BOScreenH/1334;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark---tableview的接口---
- (void)tableviewData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = @"20";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@WdApi/cgBankList",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]])
        {
            NSLog(@"返回数据类型为%@",(NSArray *)responseObject);
        }else
        {
            if ([responseObject[@"r"] integerValue] == 1)
            {
                [self.bankTableView.mj_header endRefreshing];
                _resultArr = responseObject[@"data"];
//                NSLog(@"的data数据%@",_resultArr);
                for (NSDictionary *huobiDic in _resultArr)
                {
                    [_logourlArr addObject:[huobiDic objectForKey:@"logo"]];
                    [_nameArr addObject:[huobiDic objectForKey:@"bank_name"]];
                }
                [_bankTableView reloadData];
            }else
            {
                NSLog(@"暂无数据");
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}

@end
