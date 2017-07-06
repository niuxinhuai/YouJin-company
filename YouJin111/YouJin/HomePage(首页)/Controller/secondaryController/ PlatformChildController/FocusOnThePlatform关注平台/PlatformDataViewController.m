//
//  PlatformDataViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformDataViewController.h"
#import "AttentionViewController.h"
#import "PlatformDataTableViewCell.h"
#import "ConsumptionFq.h"

@interface PlatformDataViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *platformDataTableView;
@property (nonatomic ,strong)NSMutableArray *resultArr;//tableview的接口数据
@end

@implementation PlatformDataViewController
-(NSMutableArray *)resultArr
{
    if (_resultArr == nil)
    {
        _resultArr = [NSMutableArray array];
    }
    return _resultArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableViewData];//tableview的数据
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"关注平台"];
//    // 设置leftButtonItem
//    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
//    self.navigationItem.leftBarButtonItem = btnItem;
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    //设置rightBarButtonItem
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,120*BOScreenW/750,50*BOScreenH/1334)];
    [rightButton setTitle:@"关注榜" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _platformDataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64) style:UITableViewStylePlain];
    _platformDataTableView.delegate = self;
    _platformDataTableView.dataSource = self;
    _platformDataTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_platformDataTableView];
}
#pragma mark---tableview的数据源和代理---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellString = @"cell";
    
    PlatformDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[PlatformDataTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 310*BOScreenH/1334;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.001;
    }
    return 20*BOScreenH/1334;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionHeaderHeight = 20*BOScreenH/1334;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y> 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else
        if(scrollView.contentOffset.y >= sectionHeaderHeight){
            
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark----rightButtonClick----
- (void)rightButtonClick
{
    AttentionViewController *attentionVc = [[AttentionViewController alloc]init];
    [self.navigationController pushViewController:attentionVc animated:YES];
}
#pragma mark---tableView的数据接口----
- (void)tableViewData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"uid"] = USERUID;
    parameters[@"sid"] = USERSid;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = @"10";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@App/getMyFocusPt",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"ggggoooggg%@",responseObject[@"data"]);
        if ([responseObject[@"r"] integerValue] == 1)
        {
            self.resultArr = [ConsumptionFq mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            NSLog(@"ererrereererrreererer%@",responseObject[@"data"]);
            [_platformDataTableView reloadData];
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}

@end
