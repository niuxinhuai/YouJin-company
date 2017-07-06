//
//  MoreTaskViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MoreTaskViewController.h"
#import "OnlyOneTableViewModel.h"
#import "WeburlViewController.h"
#import "MorestaskTableViewCell.h"

@interface MoreTaskViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UIView *defaultView;//筛选的背景view
@property (nonatomic ,strong)UIView *whiView;//筛选的白色view
@property (nonatomic ,strong)NSMutableArray *resultArr;//接受tableview数据的数组
@property (nonatomic ,strong)UITableView *onlyTableView;
@property (nonatomic ,strong)NSMutableArray *cellSeleUrlArr;//点击cell的跳转地址
@property (nonatomic ,strong)NSMutableArray *nameArr;//存名字的数组
@property (nonatomic ,copy)NSString *typeString;//筛选的样式
@property (nonatomic ,strong)UIButton *secHeadButton;//最新取金 筛选的按钮
@property (nonatomic ,assign)BOOL yesORno;//最新取金的点击处理
@property (nonatomic ,copy)NSString *bymoneyString;//根据奖励金额倒序排序，这个排序就传1，没有就传0
@property (nonatomic ,copy)NSString *bytimeString;//根据最新时间倒序排序，选了
@property (nonatomic ,copy)NSString *zuiixnqvjinString;//最新取金和最多奖励
@end

@implementation MoreTaskViewController
-(NSMutableArray *)resultArr
{
    if (_resultArr == nil)
    {
        _resultArr = [NSMutableArray array];
    }
    return _resultArr;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"取金"];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _cellSeleUrlArr = [NSMutableArray array];
    _nameArr = [NSMutableArray array];
    _zuiixnqvjinString = @"最新取金";
    _bymoneyString = @"0";
    _bytimeString = @"0";
    
    [self getTableviewData];//得到tableview得数据
    //这个页面就一个tableview
    _onlyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64) style:UITableViewStylePlain];
    _onlyTableView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _onlyTableView.delegate = self;
    _onlyTableView.dataSource  = self;
    _onlyTableView.showsVerticalScrollIndicator = NO;
    _onlyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_onlyTableView];
    //点击筛选显示的view
    [self TheDefaultSortAndTypeView];
    //下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.onlyTableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
}
-(void)headRefresh
{
    [self getTableviewData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellString = @"cell";
    MorestaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[MorestaskTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    //设置第一个cell的白色圆角view的位置
    cell.whiteView.frame = CGRectMake(20*BOScreenW/750, 0, 710*BOScreenW/750, 160*BOScreenH/1334);
    if (indexPath.row == 0)
    {
        cell.whiteView.frame = CGRectMake(20*BOScreenW/750, 20*BOScreenH/1334, 710*BOScreenW/750, 160*BOScreenH/1334);
    }
    cell.item = self.resultArr[indexPath.row];
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 200*BOScreenH/1334;
    }
    return 180*BOScreenH/1334;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80*BOScreenH/1334;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (USERUID)
    {
        WeburlViewController *webVc = [[WeburlViewController alloc] init];
        webVc.hidesBottomBarWhenPushed = YES;
        webVc.url = _cellSeleUrlArr[indexPath.row];
        webVc.name = _nameArr[indexPath.row];
        [self.navigationController pushViewController:webVc animated:YES];
    } else
    {
        //登陆界面
        [self pushToLoginViewController];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 80*BOScreenH/1334)];
    bgView.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[_zuiixnqvjinString,@"筛选"];
    for (int i = 0; i < 2; i++)
    {
        _secHeadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _secHeadButton.frame = CGRectMake(i*(BOScreenW/2), 0, BOScreenW/2, 80*BOScreenH/1334);
        _secHeadButton.tag = 80+i;
        [_secHeadButton setTitle:arr[i] forState:UIControlStateNormal];
        [_secHeadButton setTitleColor:[UIColor colorWithHexString:@"#333333" alpha:1] forState:UIControlStateNormal];
        _secHeadButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_secHeadButton addTarget:self action:@selector(secHeadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:_secHeadButton];
        [_secHeadButton setImage:[UIImage imageNamed:@"common_icon_xiala"] forState:UIControlStateNormal];
        _secHeadButton.imageEdgeInsets = UIEdgeInsetsMake(0, _secHeadButton.frame.size.width - _secHeadButton.imageView.frame.origin.x - _secHeadButton.imageView.frame.size.width - 0*BOScreenW/750, 0, 0);
        _secHeadButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(_secHeadButton.frame.size.width - _secHeadButton.imageView.frame.size.width ) + 330*BOScreenW/750, 0, 0);
        if (i == 0)
        {
            [_secHeadButton setImage:[UIImage imageNamed:@"icon_qiehuan"] forState:UIControlStateNormal];
        }
        if (i == 1)
        {
            _secHeadButton.imageEdgeInsets = UIEdgeInsetsMake(0, _secHeadButton.frame.size.width - _secHeadButton.imageView.frame.origin.x - _secHeadButton.imageView.frame.size.width + 30*BOScreenW/750, 0, 0);
            if (iPhone6)
            {
                _secHeadButton.imageEdgeInsets = UIEdgeInsetsMake(0, _secHeadButton.frame.size.width - _secHeadButton.imageView.frame.origin.x - _secHeadButton.imageView.frame.size.width - 20*BOScreenW/750, 0, 0);
            }
            
        }
        if (iPhone6P)
        {
            _secHeadButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(_secHeadButton.frame.size.width - _secHeadButton.imageView.frame.size.width ) + 360*BOScreenW/750, 0, 0);
        }
    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(BOScreenW/2, 15*BOScreenH/1334, 1*BOScreenW/750, 50*BOScreenH/1334)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe2e6" alpha:1];
    [bgView addSubview:lineView];
    
    UIView *endView = [[UIView alloc]initWithFrame:CGRectMake(0, 79*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
    endView.backgroundColor = [UIColor colorWithHexString:@"#dfe2e6" alpha:1];
    [bgView addSubview:endView];
    
    return bgView;
}
#pragma mark---最新任务 筛选的点击事件---
- (void)secHeadButtonClick:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 80:
        {
            if (_yesORno)
            {
                _defaultView.hidden = YES;
                _zuiixnqvjinString = @"最新取金";
                UIButton *buttons = (UIButton *)[self.view viewWithTag:80];
                [buttons setTitle:_zuiixnqvjinString forState:UIControlStateNormal];
                _typeString = @"";
                _bytimeString = @"1";
                _bymoneyString = @"0";
                [self getTableviewData];
                [_onlyTableView reloadData];
                _yesORno = NO;
                NSLog(@"123");
            }else
            {
                _defaultView.hidden = YES;
                _zuiixnqvjinString = @"最多奖励";
                UIButton *buttons = (UIButton *)[self.view viewWithTag:80];
                [buttons setTitle:_zuiixnqvjinString forState:UIControlStateNormal];
                _typeString = @"";
                _bytimeString = @"0";
                _bymoneyString = @"1";
                [self getTableviewData];
                [_onlyTableView reloadData];
                _yesORno = YES;
                NSLog(@"456");
            }
            break;
        }
            
        case 81:
        {
            if (USERUID)
            {
                _defaultView.hidden = NO;
                _whiView.hidden = NO;
            } else
            {
                //登陆界面
                [self pushToLoginViewController];
            }
            break;
        }
            
        default:
            break;
    }
}
#pragma mark---点击筛选显示的view---
- (void)TheDefaultSortAndTypeView
{
        //排序：默认排序  发帖最多 粉丝最多
        //背景view
        _defaultView = [[UIView alloc]initWithFrame:CGRectMake(0, 80*BOScreenH/1334, BOScreenW, BOScreenH - 80*BOScreenH/1334)];
        _defaultView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.35];
        [self.view addSubview:_defaultView];
        //添加手势单击事件
        UITapGestureRecognizer *Ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GesClick:)];
        Ges.numberOfTapsRequired = 1;
        [_defaultView addGestureRecognizer:Ges];
        //白色view
        _whiView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 270*BOScreenH/1334)];
        _whiView.backgroundColor = [UIColor colorWithHexString:@"#ffffff" alpha:1];
        [_defaultView addSubview:_whiView];
        
        NSArray *arr = @[@"未完成",@"审核中",@"已完成"];
        for (int i = 0; i < 3; i ++)
        {
            UILabel *defaultLabel = [[UILabel alloc]initWithFrame:CGRectMake(50*BOScreenW/750, 30*BOScreenH/1334 + i*(90*BOScreenH/1334), 120*BOScreenW/750, 30*BOScreenH/1334)];
            defaultLabel.text = arr[i];
            defaultLabel.font = [UIFont systemFontOfSize:14];
            defaultLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
            [_whiView addSubview:defaultLabel];
            //未完成 审核中 已完成的button按钮
            UIButton *defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
            defaultButton.frame = CGRectMake(0, i*(90*BOScreenH/1334), BOScreenW, 90*BOScreenH/1334);
            defaultButton.tag = 50+i;
            [defaultButton addTarget:self action:@selector(defaultButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_whiView addSubview:defaultButton];
        }
        for (int i = 0; i < 2; i ++)
        {
            //细线
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 89*BOScreenH/1334 + i*(90*BOScreenH/1334), BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
            lineView.backgroundColor = [UIColor colorWithHexString:@"#e9edf0" alpha:1];
            [_whiView addSubview:lineView];
        }
        _defaultView.hidden = YES;
        _whiView.hidden = YES;
}
#pragma mark---筛选的选择点击事件---
- (void)defaultButtonClick:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 50:
        {
            _typeString = @"fail";
            [self getTableviewData];
            [_onlyTableView reloadData];
             _defaultView.hidden = YES;
            break;
        }
        case 51:
        {
            _typeString = @"check";
            [self getTableviewData];
            [_onlyTableView reloadData];
             _defaultView.hidden = YES;
            break;
        }
        case 52:
        {
            _typeString = @"success";
            [self getTableviewData];
            [_onlyTableView reloadData];
             _defaultView.hidden = YES;
            break;
        }
        default:
            break;
    }
}
#pragma mark---单击手势事件---
- (void)GesClick:(UITapGestureRecognizer *)sender
{
    _defaultView.hidden = YES;
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark---得到tableviwe得数据---
- (void)getTableviewData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"uid"] = USERUID;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = @"20";
//    NSLog(@"_typeString%@",_typeString);
    parameters[@"type"] = _typeString;
    parameters[@"bytime"] = _bytimeString;
    parameters[@"bymoney"] = _bymoneyString;
    [manager POST:[NSString stringWithFormat:@"%@Qujin/getQujinList",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            [self.onlyTableView.mj_header endRefreshing];
            self.resultArr = [OnlyOneTableViewModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (OnlyOneTableViewModel *model in self.resultArr)
            {
                [self.cellSeleUrlArr addObject:model.url];
                [self.nameArr addObject:model.name];
            }
            [_onlyTableView reloadData];
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}

- (void)pushToLoginViewController {
    BONoteVerifyLogiin *noteVerifyLoginVC = [[BONoteVerifyLogiin alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:noteVerifyLoginVC];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:nil];
}

@end
