//
//  BankDepositoryViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/23.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BankDepositoryViewController.h"
#import "MoreBankViewController.h"
#import "BankDepoTableViewCell.h"
#import "YhcgTableV.h"
#import "BannerWebViewViewController.h"
#import "HotdetailsViewController.h"

#define  IsEmptyStr(string) string == nil || string == NULL ||[string isKindOfClass:[NSNull class]]|| [string isEqualToString:@""] ||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 ? YES : NO

@interface BankDepositoryViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *bankBasaScrView;
@property (nonatomic,strong) UIView *businessTyView;
@property (nonatomic,strong) UITableView *typeTableView;
@property (nonatomic, strong) SDCycleScrollView *bannerCycleView;

@property (nonatomic, strong)NSMutableArray *bannerResultArr;//banner图片 接口数据存放数组
@property (nonatomic, strong)NSMutableArray *bannerURlArr;//logoURL

@property (nonatomic, strong)NSMutableArray *tabViewArr;//tableview的接口
@property (nonatomic ,assign)int intNumber;//记录当前的数据条数
@property (nonatomic ,strong)NSMutableArray *jumpUrlArr;//banner跳转url
@property (nonatomic ,strong)NSMutableArray *goTypeArr;//判断banner是否能跳转
@property (nonatomic ,strong)NSMutableArray *ptidArr;//banner跳转ptid
@property (nonatomic ,strong)UIButton *typeButton;//利率的按钮
@property (nonatomic ,assign)BOOL yesORno;//判断利率按钮点击
@property (nonatomic ,copy)NSString *seqString;//利率的倒叙和正序
@end

@implementation BankDepositoryViewController
#pragma mark---懒加载---
-(NSMutableArray *)bannerResultArr
{
    if (_bannerResultArr == nil)
    {
        _bannerResultArr = [NSMutableArray array];
    }
    return _bannerResultArr;
}
-(NSMutableArray *)tabViewArr
{
    if (_tabViewArr == nil)
    {
        _tabViewArr = [NSMutableArray array];
    }
    return _tabViewArr;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _ptidArr = [NSMutableArray array];
    _jumpUrlArr = [NSMutableArray array];
    _goTypeArr = [NSMutableArray array];
    _bannerURlArr = [NSMutableArray array];
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"银行存管"];
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    //底部滑动的scr
    _bankBasaScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    _bankBasaScrView.delegate = self;
    _bankBasaScrView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _bankBasaScrView.showsVerticalScrollIndicator = NO;
//    _bankBasaScrView.contentSize = CGSizeMake(BOScreenW, 660*BOScreenH/1334+15*100*BOScreenH/1334 + 64);
    [self.view addSubview:_bankBasaScrView];
    [self bankBanner];
    //创建银行存管的view
    [self creatbankBasaView];
    //已存管平台View
    [self haveDepositoryView];
    //平台 利率 业务类型 存管银行
    [self businessTypeView];
    
    //创建uitableview
    _typeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 660*BOScreenH/1334, BOScreenW, 0*100*BOScreenH/1334) style:UITableViewStyleGrouped];
    _typeTableView.delegate = self;
    _typeTableView.dataSource = self;
    _typeTableView.scrollEnabled = NO;
    _typeTableView.showsVerticalScrollIndicator = NO;
    [_bankBasaScrView addSubview:_typeTableView];
    //调整view边距
    // 1.调整(iOS7以上)表格分隔线边距
    if ([_typeTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        _typeTableView.separatorInset = UIEdgeInsetsZero;
    }
    // 2.调整(iOS8以上)view边距(或者在cell中设置preservesSuperviewLayoutMargins,二者等效)
    if ([_typeTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        _typeTableView.layoutMargins = UIEdgeInsetsZero;
    }
    [self mjRefreshTheLoad];//下拉刷新上拉加载
    [self bannerData];//banner的接口
    [self tableViewData];//tableView的接口
}
- (void)mjRefreshTheLoad
{
    //下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    // 根据拖拽，自动显示下拉控件
    header.automaticallyChangeAlpha = YES;
    // 设置颜色
    header.stateLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    header.lastUpdatedTimeLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    self.bankBasaScrView.mj_header = header;
    
    // 上拉加载
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDatas)];
    // 自动根据有无数据，判断上拉控件是否完全显示
    footer.automaticallyHidden = YES;
    footer.stateLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    self.bankBasaScrView.mj_footer = footer;
}
//下拉刷新
- (void)refresh
{
    [self tableViewData];
    [self.bankBasaScrView.mj_header endRefreshing];
}
//上拉加载
- (void)loadMoreDatas
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = [NSString stringWithFormat:@"%d",self.intNumber + 30];
    self.intNumber += 15;
    parameters[@"seq"] = _seqString;
    [manager POST:[NSString stringWithFormat:@"%@WdApi/cgPtList",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            self.tabViewArr = [YhcgTableV mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            _typeTableView.frame = CGRectMake(0, 660*BOScreenH/1334, BOScreenW, self.tabViewArr.count*100*BOScreenH/1334);
            [_typeTableView reloadData];
            _bankBasaScrView.contentSize = CGSizeMake(BOScreenW, 660*BOScreenH/1334+self.tabViewArr.count*100*BOScreenH/1334 + 20);
            [self.bankBasaScrView.mj_footer endRefreshing];
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
#pragma mark - b 调整view边距
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark---uitableview的数据源---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tabViewArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellString = @"cell";
    UINib *nib = [UINib nibWithNibName:@"BankDepoTableViewCell" bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:cellString];
    
    BankDepoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[BankDepoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.item = self.tabViewArr[indexPath.row];
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*BOScreenH/1334;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
#pragma mark---平台 利率 业务类型 存管银行---
- (void)businessTypeView
{
    _businessTyView = [[UIView alloc]initWithFrame:CGRectMake(0, 580*BOScreenH/1334, BOScreenW, 81*BOScreenH/1334)];
    _businessTyView.backgroundColor = [UIColor whiteColor];
    [_bankBasaScrView addSubview:_businessTyView];
    
    UILabel * platformLable = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 120*BOScreenW/750, 30*BOScreenH/1334)];
    platformLable.text = @"平台";
    platformLable.font = [UIFont systemFontOfSize:13];
    platformLable.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    [_businessTyView addSubview:platformLable];
    
    _typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _typeButton.frame = CGRectMake(222*BOScreenW/750, 25*BOScreenH/1334, 120*BOScreenW/750, 30*BOScreenH/1334);
    [_typeButton setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
    _typeButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_typeButton setTitle:@"利率" forState:UIControlStateNormal];
    [_typeButton setImage:[UIImage imageNamed:@"common_icon_paixu_nor"] forState:UIControlStateNormal];
    _typeButton.imageEdgeInsets = UIEdgeInsetsMake(0, _typeButton.frame.size.width - _typeButton.imageView.frame.origin.x - _typeButton.imageView.frame.size.width - 27*BOScreenW/750, 0, 0);
    _typeButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(_typeButton.frame.size.width - _typeButton.imageView.frame.size.width ) + 30*BOScreenW/750, 0, 0);
    [_typeButton addTarget:self action:@selector(typeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_businessTyView addSubview:_typeButton];
    
    UIButton *tpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tpButton.frame = CGRectMake(380*BOScreenW/750, 25*BOScreenH/1334, 120*BOScreenW/750, 30*BOScreenH/1334);
    [tpButton setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
    tpButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [tpButton setTitle:@"业务类型" forState:UIControlStateNormal];
//    [tpButton setImage:[UIImage imageNamed:@"common_icon_xiala"] forState:UIControlStateNormal];
//    tpButton.imageEdgeInsets = UIEdgeInsetsMake(0, tpButton.frame.size.width - tpButton.imageView.frame.origin.x - tpButton.imageView.frame.size.width, 0, 0);
//    tpButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(tpButton.frame.size.width - tpButton.imageView.frame.size.width)+35*BOScreenW/750, 0, 0);
    [_businessTyView addSubview:tpButton];
    
    UILabel * platfoLable = [[UILabel alloc]initWithFrame:CGRectMake(586*BOScreenW/750, 25*BOScreenH/1334, 130*BOScreenW/750, 30*BOScreenH/1334)];
    platfoLable.text = @"存管银行";
    platfoLable.font = [UIFont systemFontOfSize:13];
    platfoLable.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    [_businessTyView addSubview:platfoLable];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 80*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e2" alpha:1];
    [_businessTyView addSubview:lineView];
//    lineView.hidden = YES;
}
#pragma mark---利率的点击事件---
- (void)typeButtonClick
{
    if (_yesORno)
    {
        [_typeButton setImage:[UIImage imageNamed:@"common_icon_paixu_low"] forState:UIControlStateNormal];
        _seqString = @"asc";
        [self tableViewData];
        [_typeTableView reloadData];
        _yesORno = NO;
    }else
    {
        [_typeButton setImage:[UIImage imageNamed:@"common_icon_paixu_high"] forState:UIControlStateNormal];
        _seqString = @"desc";
        [self tableViewData];
        [_typeTableView reloadData];
        _yesORno = YES;
    }
}
#pragma mark---创建银行存管的view---
- (void)creatbankBasaView
{
    UIView *hotTerraceView = [[UIView alloc]initWithFrame:CGRectMake(0, 220*BOScreenH/1334, BOScreenW, 260*BOScreenH/1334)];
    hotTerraceView.backgroundColor = [UIColor whiteColor];
    [_bankBasaScrView addSubview:hotTerraceView];
    //银行存管前面的蓝色
    UILabel *blueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 23*BOScreenH/1334, 10*BOScreenW/750, 34*BOScreenH/1334)];
    blueLabel.backgroundColor = [UIColor colorWithRed:70/255.0 green:151/255.0 blue:251/255.0 alpha:1];
    [hotTerraceView addSubview:blueLabel];
    //银行存管
    UILabel *toolsLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 200*BOScreenW/750, 30*BOScreenH/1334)];
    toolsLabel.text = @"银行存管";
    [toolsLabel setFont:[UIFont systemFontOfSize:15.0]];
    toolsLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [hotTerraceView addSubview:toolsLabel];
    //更多
    UIButton *screenOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    screenOutBtn.frame = CGRectMake(BOScreenW - 120*BOScreenW/750, 30*BOScreenH/1334, 100*BOScreenW/750, 20*BOScreenH/1334);
    [screenOutBtn setImage:[UIImage imageNamed:@"common_goto"] forState:UIControlStateNormal];
    [screenOutBtn setTitle:@"更多" forState:UIControlStateNormal];
  
    screenOutBtn.imageEdgeInsets = UIEdgeInsetsMake(0, screenOutBtn.frame.size.width - screenOutBtn.imageView.frame.origin.x - screenOutBtn.imageView.frame.size.width, 0, 0);
    screenOutBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(screenOutBtn.frame.size.width - screenOutBtn.imageView.frame.size.width ) + 80*BOScreenW/750, 0, 0);
//    screenOutBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [screenOutBtn setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
    [screenOutBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [screenOutBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [hotTerraceView addSubview:screenOutBtn];
    
    //创建资金存管系统scrview
    UIScrollView *depositScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 80*BOScreenH/1334, BOScreenW, 160*BOScreenH/1334)];
    depositScrView.backgroundColor = [UIColor whiteColor];
    depositScrView.showsHorizontalScrollIndicator = NO;
    depositScrView.bounces = NO;
    depositScrView.contentSize = CGSizeMake(120*BOScreenW/750+1500*BOScreenW/750, 80*BOScreenH/1334);
    [hotTerraceView addSubview:depositScrView];
    NSArray *arr = @[@"img_jxyh",@"img_hxyh",@"img_xmyh",@"img_hsyh",@"img_zsyh"];
    for (int i = 0; i < 5; i++)
    {
        UIImageView *depositImage = [[UIImageView alloc]initWithFrame:CGRectMake(i*(300*BOScreenW/750 + 20*BOScreenW/750)+20*BOScreenW/750, 0, 300*BOScreenW/750, 160*BOScreenH/1334)];
        depositImage.image = [UIImage imageNamed:arr[i]];
        [depositScrView addSubview:depositImage];
    }
}
#pragma mark--已存管平台---
- (void)haveDepositoryView
{
    UIView *haveDepositorView = [[UIView alloc]initWithFrame:CGRectMake(0, 496*BOScreenH/1334, BOScreenW, 80*BOScreenH/1334)];
    haveDepositorView.backgroundColor = [UIColor whiteColor];
    [_bankBasaScrView addSubview:haveDepositorView];
    //银行存管前面的蓝色
    UILabel *blueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 23*BOScreenH/1334, 10*BOScreenW/750, 34*BOScreenH/1334)];
    blueLabel.backgroundColor = [UIColor colorWithRed:70/255.0 green:151/255.0 blue:251/255.0 alpha:1];
    [haveDepositorView addSubview:blueLabel];
    //银行存管
    UILabel *toolsLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 200*BOScreenW/750, 30*BOScreenH/1334)];
    toolsLabel.text = @"已存管平台";
    [toolsLabel setFont:[UIFont systemFontOfSize:15.0]];
    toolsLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [haveDepositorView addSubview:toolsLabel];

}
#pragma mark---更多的点击事件----
- (void)moreBtnClick
{
    MoreBankViewController *moreVc = [[MoreBankViewController alloc]init];
    [self.navigationController pushViewController:moreVc animated:YES];
}
#pragma mark---创建banner轮播图---
- (void)bankBanner
{
    SDCycleScrollView *cycleScr = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BOScreenW, 220*BOScreenH/1334)  delegate:self placeholderImage:[UIImage imageNamed:@"img_loadingb"]];
    cycleScr.imageURLStringsGroup = _bannerURlArr;
    cycleScr.autoScrollTimeInterval = 4;
    cycleScr.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    [_bankBasaScrView addSubview:cycleScr];
    self.bannerCycleView = cycleScr;
}
#pragma mark---scrollview的代理---
#define limitOffset 578*BOScreenH/1334
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算偏移量
    CGFloat offset = _bankBasaScrView.contentOffset.y;
    // 置顶功能
    if (offset > limitOffset)
    {
        _businessTyView.frame = CGRectMake(0, 0, BOScreenW, 81*BOScreenH/ 1334);
         [self.view addSubview:_businessTyView];
    }
    if (offset <= limitOffset)
    {
        _businessTyView.frame = CGRectMake(0, 580*BOScreenH/1334, BOScreenW, 81*BOScreenH/1334);
        [_bankBasaScrView addSubview:_businessTyView];
    }
}

#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark---bannner的数据接口----
- (void)bannerData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@WdApi/cgBannerList",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]])
        {
            NSLog(@"返回数据类型为%@",(NSArray *)responseObject);
        }else
        {
            if ([responseObject[@"r"] integerValue] == 1)
            {
//                NSLog(@"responseObjectresplll%@",responseObject);
                if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]])
                {
                    _bannerResultArr = responseObject[@"data"];
                    for (NSDictionary *huobiDic in _bannerResultArr)
                    {
                        [_bannerURlArr addObject:[huobiDic objectForKey:@"img_url"]];
                        [_jumpUrlArr addObject:[huobiDic objectForKey:@"url"]];
                        [_ptidArr addObject:[huobiDic objectForKey:@"id"]];
                        [_goTypeArr addObject:[huobiDic objectForKey:@"go_type"]];
                    }
                    self.bannerCycleView.infiniteLoop = _bannerURlArr.count > 1;
                    self.bannerCycleView.imageURLStringsGroup = _bannerURlArr;
                }
                
            }else
            {
                NSLog(@"暂无数据");
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
#pragma mark---tableView的数据接口----
- (void)tableViewData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = @"15";
    parameters[@"seq"] = _seqString;
    [manager POST:[NSString stringWithFormat:@"%@WdApi/cgPtList",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            self.tabViewArr = [YhcgTableV mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            _typeTableView.frame = CGRectMake(0, 660*BOScreenH/1334, BOScreenW, self.tabViewArr.count*100*BOScreenH/1334);
            [_typeTableView reloadData];
            _bankBasaScrView.contentSize = CGSizeMake(BOScreenW, 660*BOScreenH/1334+self.tabViewArr.count*100*BOScreenH/1334+20);

        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
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
        NSLog(@"1不跳转");
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
        HotdetailsViewController *hotVc = [[HotdetailsViewController alloc]init];
        hotVc.hidesBottomBarWhenPushed = YES;
        hotVc.ptid = _ptidArr[index];
        [self.navigationController pushViewController:hotVc animated:YES];
    }else
    {
        NSLog(@"2不跳转");
    }
}
@end
