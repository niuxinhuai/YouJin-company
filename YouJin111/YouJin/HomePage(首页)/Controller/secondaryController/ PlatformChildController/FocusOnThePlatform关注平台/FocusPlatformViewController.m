//
//  FocusPlatformViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "FocusPlatformViewController.h"
#import "AttentionViewController.h"
#import "FocusOnPlatformModel.h"
#import "ConsumptionFq.h"
#import "GuanzhuTableViewCell.h"
#import "GuanzhuLIebiaoModel.h"

@interface FocusPlatformViewController ()<UITableViewDelegate ,UITableViewDataSource>
//未关注平台
@property (nonatomic ,strong)UIImageView *belowImage;//推荐平台的logo
@property (nonatomic ,strong)UILabel *belowLabel;//推荐平台的名称
@property (nonatomic ,strong)NSMutableArray *resultArr;//接受推荐平台的结果数组
@property (nonatomic ,strong)UIView *weiguanzhuView;//未关注页面的view
@property (nonatomic ,strong)NSMutableArray *logoArrs;
@property (nonatomic ,strong)NSMutableArray *nameArrs;
@property (nonatomic ,strong)NSMutableArray *ptidArrs;
//关注平台
@property (nonatomic ,strong)UITableView *guanzhuTableView;
@property (nonatomic ,strong)NSMutableArray *guanzhuArr;

@property (nonatomic ,copy)NSString *ptidString;

@end

@implementation FocusPlatformViewController
-(NSMutableArray *)guanzhuArr
{
    if (_guanzhuArr == nil)
    {
        _guanzhuArr = [NSMutableArray array];
    }
    return _guanzhuArr;
}
-(NSMutableArray *)resultArr
{
    if (_resultArr==nil)
    {
        _resultArr = [NSMutableArray array];
    }
    return _resultArr;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"关注平台"];
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
    
    [self focusPlatformData];//数据接口
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _logoArrs = [NSMutableArray array];
    _nameArrs = [NSMutableArray array];
    _ptidArrs = [NSMutableArray array];

    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    //关注页面的tableview
    _guanzhuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64) style:UITableViewStyleGrouped];
    _guanzhuTableView.delegate = self;
    _guanzhuTableView.dataSource = self;
    _guanzhuTableView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _guanzhuTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_guanzhuTableView];
    
    //未关注页面的view
    _weiguanzhuView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64)];
    _weiguanzhuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_weiguanzhuView];
    [self aboutTopView];
    [self aboutMiddleView];
//    [self aboutBelowView];
//    [self focusPlatformData];//数据接口
}
#pragma mark---topView----
-(void)aboutTopView
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 486*BOScreenH/1334)];
    topView.backgroundColor = [UIColor whiteColor];
    [_weiguanzhuView addSubview:topView];
    
    UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(250*BOScreenW/750, 110*BOScreenH/1334, 250*BOScreenW/750, 250*BOScreenW/750)];
    topImage.image = [UIImage imageNamed:@"img_a"];
    [topView addSubview:topImage];
    
    CGFloat topImageY = CGRectGetMaxY(topImage.frame) + 30*BOScreenH/1334;
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(225*BOScreenW/750, topImageY, 300*BOScreenW/750, 40*BOScreenH/1334)];
    topLabel.text = @"你还没有关注的平台";
    topLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.font = [UIFont systemFontOfSize:13];
    [topView addSubview:topLabel];
}
#pragma mark---middleView---
- (void)aboutMiddleView
{
    UIView *middleView = [[UIView alloc]initWithFrame:CGRectMake(0, 486*BOScreenH/1334, BOScreenW, 60*BOScreenH/1334)];
    middleView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    [_weiguanzhuView addSubview:middleView];
    
    UIView *frontLineView = [[UIView alloc]initWithFrame:CGRectMake(136*BOScreenW/750, 29*BOScreenH/1334, 124*BOScreenW/750, 1)];
    frontLineView.backgroundColor = [UIColor colorWithHexString:@"#cccccc" alpha:1];
    [middleView addSubview:frontLineView];
    
    UIButton *middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    middleButton.userInteractionEnabled = NO;
    middleButton.frame = CGRectMake(280*BOScreenW/750, 10*BOScreenH/1334, 190*BOScreenW/750, 40*BOScreenH/1334);
    [middleButton setImage:[UIImage imageNamed:@"icon_hots"] forState:UIControlStateNormal];
    [middleButton setTitle:@"  为你推荐" forState:UIControlStateNormal];
    [middleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [middleButton setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
    [middleButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    middleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [middleView addSubview:middleButton];
    
    UIView *backLineView = [[UIView alloc]initWithFrame:CGRectMake(490*BOScreenW/750, 29*BOScreenH/1334, 124*BOScreenW/750, 1)];
    backLineView.backgroundColor = [UIColor colorWithHexString:@"#cccccc" alpha:1];
    [middleView addSubview:backLineView];
}
#pragma mark---belowView---
- (void)aboutBelowView
{
    UIView *belowView= [[UIView alloc]initWithFrame:CGRectMake(0, 546*BOScreenH/1334, BOScreenW, BOScreenH-546*BOScreenH/1334)];
    belowView.backgroundColor = [UIColor whiteColor];
    [_weiguanzhuView addSubview:belowView];
    
    for (int i = 0; i < self.resultArr.count; i ++)
    {
        NSInteger index = i % 3;//取余数
        NSInteger page = i / 3;//取商
        
        _belowImage = [[UIImageView alloc]initWithFrame:CGRectMake(index*(120*BOScreenW/750+125*BOScreenW/750)+70*BOScreenW/750, page*(120*BOScreenW/750 + 176*BOScreenH/1334)+60*BOScreenH/1334, 120*BOScreenW/750, 120*BOScreenW/750)];
        _belowImage.layer.cornerRadius = 10;
        _belowImage.layer.masksToBounds = YES;
        [_belowImage sd_setImageWithURL:[NSURL URLWithString:_logoArrs[i]] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
        [belowView addSubview:_belowImage];
        
        _belowLabel = [[UILabel alloc]initWithFrame:CGRectMake(index*(200*BOScreenW/750+45*BOScreenW/750)+30*BOScreenW/750, page*(26*BOScreenW/750 + 270*BOScreenH/1334)+200*BOScreenH/1334, 200*BOScreenW/750, 26*BOScreenH/1334)];
        _belowLabel.text = _nameArrs[i];
        _belowLabel.font = [UIFont systemFontOfSize:15];
        _belowLabel.textAlignment = NSTextAlignmentCenter;
        [belowView addSubview:_belowLabel];
        
        UIButton *belowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        belowButton.frame = CGRectMake(index*(80*BOScreenW/750+165*BOScreenW/750)+80*BOScreenW/750, page*(40*BOScreenW/750 + 256*BOScreenH/1334)+253*BOScreenH/1334, 100*BOScreenW/750, 46*BOScreenH/1334);
        belowButton.tag = i;
        [belowButton setBackgroundImage:[UIImage imageNamed:@"common_btn_guanzhu_nor"] forState:UIControlStateNormal];
        [belowButton addTarget:self action:@selector(belowButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [belowView addSubview:belowButton];
    }
}
//六个关注的点击事件
- (void)belowButtonClick:(UIButton *)sender
{
        sender.selected =!sender.selected;
        if (sender.selected)
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"common_btn_guanzhu_prer"] forState:UIControlStateNormal];
            _ptidString = _ptidArrs[sender.tag];
            [self payAttentionToFriendsData];
            //给选中图片
        }else
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"common_btn_guanzhu_nor"] forState:UIControlStateNormal];
            _ptidString = _ptidArrs[sender.tag];
            [self cancellationNoticeData];
            //给默认图片
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

//关注平台的tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellString = @"cell";
    GuanzhuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[GuanzhuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.item = self.guanzhuArr[indexPath.section];
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 168*BOScreenH/1334;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.001;
    }
    return 16*BOScreenH/1334;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.guanzhuArr.count;
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    CGFloat sectionHeaderHeight = 16*BOScreenH/1334;
//    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y> 0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    }else
//        if(scrollView.contentOffset.y >= sectionHeaderHeight){
//            
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
//}

#pragma mark---数据接口----
- (void)focusPlatformData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"uid"] = USERUID;
    parameters[@"sid"] = USERSid;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = @"20";
    [manager POST:[NSString stringWithFormat:@"%@App/getMyFocusPt",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
//            NSLog(@"responseObjectresponseObject%@",responseObject);
            self.resultArr = [FocusOnPlatformModel mj_objectArrayWithKeyValuesArray:responseObject[@"tuijian"]];
            for (FocusOnPlatformModel *tuijianmodel in self.resultArr)
            {
                [_logoArrs addObject:tuijianmodel.logo];
                [_nameArrs addObject:tuijianmodel.name];
                [_ptidArrs addObject:tuijianmodel.ptid];
            }
            [self aboutBelowView];//六个按钮

            self.guanzhuArr = [GuanzhuLIebiaoModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            if (self.guanzhuArr.count > 0)
            {
                _weiguanzhuView.hidden = YES;
                _guanzhuTableView.hidden = NO;
            }else
            {
                _guanzhuTableView.hidden = YES;
                _weiguanzhuView.hidden = NO;
            }
            [_guanzhuTableView reloadData];
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
//关注网贷平台
- (void)payAttentionToFriendsData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"uid"] = USERUID;
    parameters[@"ptid"] = _ptidString;
    [manager POST:[NSString stringWithFormat:@"%@App/focusPingtai",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            NSLog(@"返回信息描述88888%@",responseObject[@"msg"]);
        }
        else
        {
            NSLog(@"返回信息描述999999%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
//取消关注网贷平台
- (void)cancellationNoticeData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"uid"] = USERUID;
    parameters[@"ptid"] = _ptidString;
    [manager POST:[NSString stringWithFormat:@"%@App/cancelFocusPt",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            NSLog(@"返回信息描述666666%@",responseObject[@"msg"]);
        }
        else
        {
            NSLog(@"返回信息描述77777%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
@end
