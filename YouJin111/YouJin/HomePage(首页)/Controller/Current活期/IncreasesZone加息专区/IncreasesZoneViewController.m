//
//  IncreasesZoneViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/7.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "IncreasesZoneViewController.h"
#import "IncreasesZoneTableViewCell.h"
#import "InterestRatesModel.h"
#import "BannerWebViewViewController.h"

@interface IncreasesZoneViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *interestTableView;
@property (nonatomic ,strong)NSMutableArray *resultArr;//接受tableview的结果数组
@property (nonatomic ,strong)NSMutableArray *nameArr;//存放平台名称
@property (nonatomic ,strong)NSMutableArray *urlArr;//存放跳转的url
@end

@implementation IncreasesZoneViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
//    self.title = @"加息专区";
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"加息专区"];
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _nameArr = [NSMutableArray array];
    _urlArr = [NSMutableArray array];
    [self tableViewData];//tableveiw的数据接口
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
   
    _interestTableView = [[UITableView alloc]initWithFrame:CGRectMake(36*BOScreenW/750, 0, 678*BOScreenW/750, BOScreenH-64) style:UITableViewStyleGrouped];
    _interestTableView.delegate = self;
    _interestTableView.dataSource = self;
    _interestTableView.showsVerticalScrollIndicator = NO;
    _interestTableView.backgroundColor = [UIColor whiteColor];
    _interestTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_interestTableView];
}
#pragma mark---tableview的代理---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellString = @"cell";
    UINib *nib = [UINib nibWithNibName:@"IncreasesZoneTableViewCell" bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:cellString];
    
    IncreasesZoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[IncreasesZoneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    //根据不同的区改变背景图片
    if (indexPath.section%2)
    {
        cell.bgImage.image = [UIImage imageNamed:@"img_jiaxiquanh"];
    }else
    {
        cell.bgImage.image = [UIImage imageNamed:@"img_jiaxiquanj"];
    }
    cell.item = self.resultArr[indexPath.section];
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 288*BOScreenH/1334;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resultArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28*BOScreenH/1334;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BannerWebViewViewController *webView = [[BannerWebViewViewController alloc]init];
    webView.name = _nameArr[indexPath.section];
    webView.url = _urlArr[indexPath.section];
    [self.navigationController pushViewController:webView animated:YES];
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark---tableView的数据接口----
- (void)tableViewData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = @"10";
    [manager POST:[NSString stringWithFormat:@"%@WdApi/jiaxiData",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"yyyyyyyyyyy%@",responseObject);
        NSLog(@"ggggggggggggooo%@",responseObject[@"data"]);
        if ([responseObject[@"r"] integerValue] == 1)
        {
            self.resultArr = [InterestRatesModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            NSLog(@"ererrereererrreererer%@",responseObject[@"data"]);
            [self.interestTableView reloadData];
            for (InterestRatesModel *model in self.resultArr)
            {
                [_nameArr addObject:model.name];
                [_urlArr addObject:model.url];
            }
        }
        else
        {
            NSLog(@"返回信息rrrr描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}

@end
