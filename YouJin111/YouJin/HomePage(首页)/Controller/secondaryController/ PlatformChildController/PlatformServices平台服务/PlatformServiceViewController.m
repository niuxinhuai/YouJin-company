//
//  PlatformServiceViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformServiceViewController.h"
#import "PTFWTableViewCell.h"
#import "InTheMiddleModel.h"
#import "BannerWebViewViewController.h"
#import "HotdetailsViewController.h"
#import "BannerWebViewViewController.h"
#import "PTfwTableviewModel.h"
#import "PlatformServiceDetailViewController.h"

@interface PlatformServiceViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic ,strong)UITableView *onlyTableView;
@property (nonatomic ,strong)SDCycleScrollView *cycleScr;//第零区的view
@property (nonatomic ,strong)UIView *firstView;//第一区的view
@property (nonatomic ,strong)UIView *secondView;//第二区的view
@property (nonatomic ,strong)NSMutableArray *bannerResultArr;//接受banner的数据
@property (nonatomic, strong)NSMutableArray *bannerURlArr;//logoURL
@property (nonatomic ,strong)NSMutableArray *jumpUrlArr;//banner跳转url
@property (nonatomic ,strong)NSMutableArray *goTypeArr;//判断banner是否能跳转
@property (nonatomic ,strong)NSMutableArray *ptidArr;//banner跳转ptid

@property (nonatomic ,strong)NSMutableArray *middleArr;//存放中间数据
@property (nonatomic ,strong)UILabel *leftLabel;
@property (nonatomic ,strong)UIImageView *leftImage;
@property (nonatomic ,strong)UILabel *rightLabel;
@property (nonatomic ,strong)UIImageView *rightImage;
@property (nonatomic ,strong)NSMutableArray *descArr;
@property (nonatomic ,strong)NSMutableArray *imgurlArr;
@property (nonatomic ,strong)NSMutableArray *urlArr;
@property (nonatomic ,strong)NSMutableArray *tableviewResultArr;

@property (nonatomic ,strong)UIView *sxView;//筛选点击显示的view
@property (nonatomic ,strong)UITableView *sxtableview;
@property (nonatomic ,copy)NSString *returnString;//返回
@property (nonatomic ,strong)NSMutableArray *sxmutableArr;
@property (nonatomic ,strong)NSMutableArray *sxmutableArrsssss;

@property (nonatomic ,strong)UIView *secondViewsss;
@property (nonatomic ,copy)NSString *ffffff;
@property (nonatomic ,assign)int intNumber;//记录当前的数据条数
@end

@implementation PlatformServiceViewController
-(NSMutableArray *)tableviewResultArr
{
    if (_tableviewResultArr == nil)
    {
        _tableviewResultArr = [NSMutableArray array];
    }
    return _tableviewResultArr;
}
-(NSMutableArray *)middleArr
{
    if (_middleArr == nil)
    {
        _middleArr = [NSMutableArray array];
    }
    return _middleArr;
}
-(NSMutableArray *)bannerResultArr
{
    if (_bannerResultArr == nil)
    {
        _bannerResultArr = [NSMutableArray array];
    }
    return _bannerResultArr;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"平台服务"];
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
     _returnString = @"before";
    _descArr = [NSMutableArray array];
    _imgurlArr = [NSMutableArray array];
    _urlArr = [NSMutableArray array];
    _bannerURlArr = [NSMutableArray array];
    _ptidArr = [NSMutableArray array];
    _jumpUrlArr = [NSMutableArray array];
    _goTypeArr = [NSMutableArray array];
    _sxmutableArr = [[NSMutableArray alloc] initWithObjects:@"全部类型",@"系统开发",@"网络安全",@"短信系统",@"理财记账",@"法律服务",@"电子合同",@"金融资讯", nil];
    _sxmutableArrsssss = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    
    _onlyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64) style:UITableViewStylePlain];
    _onlyTableView.delegate = self;
    _onlyTableView.dataSource = self;
    _onlyTableView.showsVerticalScrollIndicator = NO;
    _onlyTableView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _onlyTableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.view addSubview:_onlyTableView];
    
    [self zeroSectionView];//第零区的view
    [self firshSectionView];//第一区的view
    [self secondSectionView];//第二区的view
    [self clickFilterShowView];//筛选点击显示的view
    [self secondSectionViewsss];//筛选第0区的view
    [self bannerData];//banner的接口
    [self tableViewData];
    
    //下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.onlyTableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    
    //上拉加载
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    footer.automaticallyHidden = YES;
    [footer setTitle:@"我是有底线的" forState:MJRefreshStateIdle];
    footer.stateLabel.textColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1];
    self.onlyTableView.mj_footer = footer;
}
-(void)headRefresh
{
    [self tableViewData];
}
//上拉加载
- (void)loadMoreData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = [NSString stringWithFormat:@"%zd",self.intNumber + 20];
    self.intNumber += 10;
    parameters[@"ty"] = _ffffff;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@WdApi/serviceCompanyList",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.onlyTableView.mj_footer endRefreshing];
        if ([responseObject[@"r"] integerValue] == 1)
        {
            self.tableviewResultArr = [PTfwTableviewModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _sxtableview)
    {
        return 1;
    }
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _sxtableview)
    {
        return _sxmutableArr.count;
    }
    
    if (section == 0)
    {
        return 0;
    }else if (section == 1)
    {
        return 0;
    }
    return self.tableviewResultArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _sxtableview)
    {
        static NSString *cellstr = @"cells";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellstr];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstr];
        }
        cell.textLabel.text = _sxmutableArr[indexPath.row];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    static NSString *cellString = @"cell";
    PTFWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[PTFWTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.item = self.tableviewResultArr[indexPath.row];
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _sxtableview)
    {
        return 80*BOScreenH/1334;
    }
    
    if (section == 0)
    {
        return 220*BOScreenH/1334;
    }else if (section == 1)
    {
        return 176*BOScreenH/1334;
    }
    return 80*BOScreenH/1334;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _sxtableview)
    {
        return 90*BOScreenH/1334;
    }
    return 250*BOScreenH/1334;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _sxtableview)
    {
        return _secondViewsss;
    }
    
    if (section == 0)
    {
        return _cycleScr;
    }else if (section == 1)
    {
        return _firstView;
    }
    return _secondView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _sxtableview)
    {
        _returnString = @"before";
        _sxView.hidden = YES;
        _ffffff = _sxmutableArrsssss[indexPath.row];
        [self tableViewData];
    }else if (tableView == self.onlyTableView) {
        PTFWTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        PlatformServiceDetailViewController *vc = [PlatformServiceDetailViewController createWithSvid:@([cell.item.svid intValue])];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
//第零区的view
- (void)zeroSectionView
{
//    NSLog(@"_bannerURlArr%@",_bannerURlArr);
    _cycleScr = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BOScreenW, 220*BOScreenH/1334)  delegate:self placeholderImage:[UIImage imageNamed:@"img_loadingb"]];
    //    _cycleScr.imageURLStringsGroup = _bannerURlArr;
    _cycleScr.autoScrollTimeInterval = 4;
    _cycleScr.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
}
//第一区的view
- (void)firshSectionView
{
    _firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 176*BOScreenH/1334)];
    _firstView.backgroundColor = [UIColor whiteColor];
    
    _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(20*BOScreenW/750, 30*BOScreenH/1334, 190*BOScreenW/750, 100*BOScreenH/1334)];
    _leftLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    _leftLabel.font = [UIFont systemFontOfSize:14];
    _leftLabel.numberOfLines = 0;
    [_firstView addSubview:_leftLabel];
    
    _leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(235*BOScreenW/750, 20*BOScreenH/1334, 120*BOScreenW/750, 120*BOScreenW/750)];
    //    _leftImage.image = [UIImage imageNamed:@"img_zhanwei_b"];
    [_firstView addSubview:_leftImage];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 375*BOScreenW/750, 160*BOScreenH/1334);
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_firstView addSubview:leftButton];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(374*BOScreenW/750, 0, 1*BOScreenW/750, 160*BOScreenH/1334)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
    [_firstView addSubview:lineView];
    
    _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(395*BOScreenW/750, 30*BOScreenH/1334, 190*BOScreenW/750, 100*BOScreenH/1334)];
    //    _rightLabel.text = @"哈哈哈哈哈哈哈哈哈ahahhaahhaaahaa";
    _rightLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    _rightLabel.font = [UIFont systemFontOfSize:14];
    _rightLabel.numberOfLines = 0;
    [_firstView addSubview:_rightLabel];
    
    _rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(610*BOScreenW/750, 20*BOScreenH/1334, 120*BOScreenW/750, 120*BOScreenW/750)];
    //    _rightImage.image = [UIImage imageNamed:@"img_zhanwei_b"];
    [_firstView addSubview:_rightImage];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(375*BOScreenW/750, 0, 375*BOScreenW/750, 160*BOScreenH/1334);
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_firstView addSubview:rightButton];
    
    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0, 160*BOScreenH/1334, BOScreenW, 16*BOScreenH/1334)];
    downView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    [_firstView addSubview:downView];
}
//第二区的view
- (void)secondSectionView
{
    _secondView = [[UIView alloc]initWithFrame:CGRectMake(0, 220*BOScreenH/1334, BOScreenW, 80*BOScreenH/1334)];
    _secondView.backgroundColor = [UIColor whiteColor];
    //热门分期平台前面的蓝色
    UILabel *blueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 23*BOScreenH/1334, 10*BOScreenW/750, 34*BOScreenH/1334)];
    blueLabel.backgroundColor = [UIColor colorWithRed:70/255.0 green:151/255.0 blue:251/255.0 alpha:1];
    [_secondView addSubview:blueLabel];
    //热门分期平台
    UILabel *toolsLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 400*BOScreenW/750, 30*BOScreenH/1334)];
    toolsLabel.text = @"热门服务商";
    [toolsLabel setFont:[UIFont systemFontOfSize:15.0]];
    toolsLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [_secondView addSubview:toolsLabel];
        //筛选
       UIButton *screenOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        screenOutBtn.frame = CGRectMake(BOScreenW - 120*BOScreenW/750, 30*BOScreenH/1334, 100*BOScreenW/750, 20*BOScreenH/1334);
        [screenOutBtn setImage:[UIImage imageNamed:@"icon_shuaxuan"] forState:UIControlStateNormal];
        [screenOutBtn setTitle:@" 筛选" forState:UIControlStateNormal];
        [screenOutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [screenOutBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [screenOutBtn addTarget:self action:@selector(screenOutBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_secondView addSubview:screenOutBtn];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 79*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
    [_secondView addSubview:lineView];
}
#pragma mark---bannner的数据接口----
- (void)bannerData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = @"10";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@WdApi/serviceHomePage",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]])
        {
            NSLog(@"返回数据类型为%@",(NSArray *)responseObject);
        }else
        {
            if ([responseObject[@"r"] integerValue] == 1)
            {
                if (responseObject[@"banner"] && ![responseObject[@"banner"] isKindOfClass:[NSNull class]])
                {
                    _bannerResultArr = responseObject[@"banner"];
                    for (NSDictionary *huobiDic in _bannerResultArr)
                    {
                        [_bannerURlArr addObject:[huobiDic objectForKey:@"img_url"]];
                        [_jumpUrlArr addObject:[huobiDic objectForKey:@"url"]];
                        [_ptidArr addObject:[huobiDic objectForKey:@"id"]];
                        [_goTypeArr addObject:[huobiDic objectForKey:@"go_type"]];
                    }
                    _cycleScr.imageURLStringsGroup = _bannerURlArr;
                }
                
                self.middleArr = [InTheMiddleModel mj_objectArrayWithKeyValuesArray:responseObject[@"middle"]];
                for (InTheMiddleModel *model in self.middleArr)
                {
                    [_descArr addObject:model.desc];
                    [_imgurlArr addObject:model.img_url];
                    [_urlArr addObject:model.url];
                }
                _leftLabel.text = _descArr[0];
                [_leftImage sd_setImageWithURL:[NSURL URLWithString:_imgurlArr[0]] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
                _rightLabel.text = _descArr[1];
                [_rightImage sd_setImageWithURL:[NSURL URLWithString:_imgurlArr[1]] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
            }else
            {
                NSLog(@"暂无数据");
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if ([_goTypeArr[index] intValue] == 1)
    {
        NSLog(@"不跳转");
    }else if ([_goTypeArr[index] intValue] == 2)
    {
        NSArray *newArray = [_jumpUrlArr[index] componentsSeparatedByString:@"|"];
        BannerWebViewViewController *bannerWebVc = [[BannerWebViewViewController alloc]init];
        if (newArray.count == 2) {
            bannerWebVc.name = newArray[0];
            bannerWebVc.url = newArray[1];
        }else {
            bannerWebVc.url = _jumpUrlArr[index];
        }
        bannerWebVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bannerWebVc animated:YES];
    }else if ([_goTypeArr[index] intValue] == 3)
    {
        PlatformServiceDetailViewController *vc = [PlatformServiceDetailViewController createWithSvid:@([_ptidArr[index] intValue])];
        [self.navigationController pushViewController:vc animated:YES];

    }else
    {
        NSLog(@"不跳转");
    }
}
//左边的按钮
- (void)leftButtonClick
{
    BannerWebViewViewController *webVc = [[BannerWebViewViewController alloc]init];
    webVc.url = _urlArr[0];
    [self.navigationController pushViewController:webVc animated:YES];
}
//右边按钮
- (void)rightButtonClick
{
    BannerWebViewViewController *webVc = [[BannerWebViewViewController alloc]init];
    webVc.url = _urlArr[1];
    [self.navigationController pushViewController:webVc animated:YES];
}
#pragma mark---tableView的数据接口----
- (void)tableViewData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = @"10";
    parameters[@"ty"] = _ffffff;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@WdApi/serviceCompanyList",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            [self.onlyTableView.mj_header endRefreshing];
            self.tableviewResultArr = [PTfwTableviewModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
//筛选的点击事件
- (void)screenOutBtnClick
{
    _returnString = @"this";
    _sxView.hidden = NO;
}
//筛选点击显示的view
- (void)clickFilterShowView
{
    _sxView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    _sxView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.35];
    [self.view addSubview:_sxView];
    //添加手势单击事件
    UITapGestureRecognizer *Gess = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GesClicks:)];
    Gess.delegate = self;
    Gess.numberOfTapsRequired = 1;
    [_sxView addGestureRecognizer:Gess];
    
    _sxtableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 800*BOScreenH/1334) style:UITableViewStylePlain];
    _sxtableview.delegate = self;
    _sxtableview.dataSource = self;
    _sxtableview.backgroundColor = [UIColor whiteColor];
    _sxtableview.scrollEnabled = NO;
    [_sxView addSubview:_sxtableview];
    
    _sxView.hidden = YES;
}
#pragma mark---单击手势的代理---
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:_sxtableview])
    {
        return NO;
    }
    return YES;
}
- (void)GesClicks:(UITapGestureRecognizer *)sender
{
    _returnString = @"before";
    _sxView.hidden = YES;
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    if ([_returnString isEqualToString:@"before"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        _sxView.hidden = YES;
        _returnString = @"before";
    }
}

//筛选第0区的view
- (void)secondSectionViewsss
{
    _secondViewsss = [[UIView alloc]initWithFrame:CGRectMake(0, 220*BOScreenH/1334, BOScreenW, 80*BOScreenH/1334)];
    _secondViewsss.backgroundColor = [UIColor whiteColor];
    //热门分期平台前面的蓝色
    UILabel *blueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 23*BOScreenH/1334, 10*BOScreenW/750, 34*BOScreenH/1334)];
    blueLabel.backgroundColor = [UIColor colorWithRed:70/255.0 green:151/255.0 blue:251/255.0 alpha:1];
    [_secondViewsss addSubview:blueLabel];
    //热门分期平台
    UILabel *toolsLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 400*BOScreenW/750, 30*BOScreenH/1334)];
    toolsLabel.text = @"热门服务商";
    [toolsLabel setFont:[UIFont systemFontOfSize:15.0]];
    toolsLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [_secondViewsss addSubview:toolsLabel];
    //筛选
    UIButton *screenOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    screenOutBtn.frame = CGRectMake(BOScreenW - 120*BOScreenW/750, 30*BOScreenH/1334, 100*BOScreenW/750, 20*BOScreenH/1334);
    [screenOutBtn setImage:[UIImage imageNamed:@"icon_shuaxuan"] forState:UIControlStateNormal];
    [screenOutBtn setTitle:@" 筛选" forState:UIControlStateNormal];
    [screenOutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [screenOutBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_secondViewsss addSubview:screenOutBtn];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 79*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
    [_secondViewsss addSubview:lineView];
}

@end
