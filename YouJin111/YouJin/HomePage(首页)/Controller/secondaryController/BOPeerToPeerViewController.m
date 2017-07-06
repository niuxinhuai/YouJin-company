//
//  BOPeerToPeerViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOPeerToPeerViewController.h"
#import "UIImage+UIColor.h"
#import "BOPictureWheelPlay.h"
#import "PlatformNavigationVC.h"
#import "PlatformServeViewController.h"
#import "ConsumptionViewController.h"
#import "FocusPlatformViewController.h"
#import "PlatformDataViewController.h"
#import "BankDepositoryViewController.h"
#import "DemonstrationOfFundViewController.h"
#import "NetLoanFundVC.h"
#import "IndustryDataViewController.h"
#import "NetCreditRatingViewController.h"
#import "BOPlatformTableVC.h"
#import "BOPlatformActivityTableVC.h"
#import "BOHotPlatformTableVC.h"
#import "UINavigationController+GONavigationController.h"
#import "BannerModel.h"
#import "PeerHonePageModel.h"
#import "PlatNewsModel.h"
#import "PlatformActivityModel.h"
#import "BannerWebViewViewController.h"
#import "HotdetailsViewController.h"
#import "PlatformServiceViewController.h"
#import "NewCarLoanViewController.h"
#import "NewIndustryDataViewController.h"
@interface BOPeerToPeerViewController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate>

/**主的scrollView*/
@property (nonatomic, strong) UIScrollView *peerScrollView;
@property (nonatomic, strong) UIView *bankView;
/**引用platformView属性*/
@property (nonatomic, weak) UIView *platformView;

@property (nonatomic, assign) BOOL offest;

/**选中的按钮*/
@property (nonatomic, weak) UIButton *selectBtn;

/**选中按钮下部的下划线*/
@property (nonatomic, weak) UIView *slideView;

/**底部的scrollView*/
@property (nonatomic, weak) UIScrollView *bottomScrollView;

@property (nonatomic, weak) UITableView *hotPlatformTableView;

@property (nonatomic, weak) UITableView *hotActivityTableView;

@property (nonatomic, weak) UITableView *hotNewaTableView;

@property (nonatomic, retain) SDCycleScrollView *bannerCycleView;


/**保存按钮的数组*/
@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic, weak) AFHTTPSessionManager *mgr;

/**保存banner图的url的数组*/
@property (nonatomic, strong) NSMutableArray *bannerUrlArray;
@property (nonatomic ,strong)NSMutableArray *jumpUrlArr;//banner跳转url
@property (nonatomic ,strong)NSMutableArray *goTypeArr;//判断banner是否能跳转
@property (nonatomic ,strong)NSMutableArray *ptidArr;//banner跳转ptid

/**热门平台的数组*/
@property (nonatomic, strong) NSMutableArray *hotPlatformArrayM;

/**平台活动的数组*/
@property (nonatomic, strong) NSMutableArray *platformActivityArrayM;

/**平台新闻的数组*/
@property (nonatomic, strong) NSMutableArray *platformNewsArrayM;

@property (nonatomic, weak) BOHotPlatformTableVC *hotPlatformVC;
@property (nonatomic, weak) BOPlatformTableVC *platformNewsVC;

@property (nonatomic, weak) BOPlatformActivityTableVC *platformActivityVC;

/**记录当前是哪一页*/
@property (nonatomic, assign) int page;
@end

@implementation BOPeerToPeerViewController
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}
#pragma mark - 懒加载bannerUrlArray
- (NSMutableArray *)bannerUrlArray {
    if (_bannerUrlArray == nil) {
        _bannerUrlArray = [NSMutableArray array];
    }
    return _bannerUrlArray;
}
#pragma mark - 懒加载首页ScrollView
- (UIScrollView *)peerScrollView {
    if (_peerScrollView == nil) {
        _peerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH - 49)];
        _peerScrollView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        _peerScrollView.showsVerticalScrollIndicator = NO;
        _peerScrollView.contentSize = CGSizeMake(0, 1000);
        _peerScrollView.delegate = self;
        [self.view addSubview:_peerScrollView];
    }
    return  _peerScrollView;
}
#pragma mark - 懒加载热门平台的数组
- (NSMutableArray *)hotPlatformArrayM {
    if (_hotPlatformArrayM == nil) {
        _hotPlatformArrayM = [NSMutableArray array];
    }
    return _hotPlatformArrayM;
}
#pragma mark - 懒加载平台新闻的数组
- (NSMutableArray *)platformNewsArrayM {
    if (_platformNewsArrayM == nil) {
        _platformNewsArrayM = [NSMutableArray array];
    }
    return _platformNewsArrayM;
}
#pragma mark - 懒加载平台活动的数组
- (NSMutableArray *)platformActivityArrayM {
    if (_platformActivityArrayM == nil) {
        _platformActivityArrayM = [NSMutableArray array];
    }
    return _platformActivityArrayM;
}
- (NSMutableArray *)btnArray {
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _ptidArr = [NSMutableArray array];
    _jumpUrlArr = [NSMutableArray array];
    _goTypeArr = [NSMutableArray array];
    self.page = 0;
    // 请求数据
    [self setupTopView];
    [self setupPeerScrollView];
    [self requstNetData];
    //平台活动的数据
    [self PlatformActivityData];
    // 设置peerScrollView
    
}

#pragma mark - 请求网络数据
- (void)requstNetData {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // 请求banner图的数据
    NSString *string = [NSString stringWithFormat:@"%@WdApi/wdHomeBannerList",BASEURL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"os"] = @"Ios";
    parameters[@"version"] = app_Version;
    [self.mgr POST:string parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = [BannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        for (BannerModel *item in array)
        {
            [self.bannerUrlArray addObject:item.img_url];
            [_jumpUrlArr addObject:item.url];
            [_ptidArr addObject:item.ID];
            [_goTypeArr addObject:item.go_type];
        }
        self.bannerCycleView.infiniteLoop = self.bannerUrlArray.count > 1;
        self.bannerCycleView.imageURLStringsGroup = self.bannerUrlArray;
        // 添加头部的轮播图
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    // 请求网贷页其他数据
    NSString *loadString = [NSString stringWithFormat:@"%@WdApi/wdHome",BASEURL];
    NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
    parameters1[@"at"] = tokenString;
    [self.mgr POST:loadString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 去热门平台的数据
        self.hotPlatformArrayM = [PeerHonePageModel mj_objectArrayWithKeyValuesArray:responseObject[@"hotPtList"]];
        self.hotPlatformVC.hotPlatformArrayM = self.hotPlatformArrayM;
        if (self.hotPlatformArrayM.count == 0) {
            self.hotPlatformVC.tableView.height = 0;
        }
        [self.hotPlatformVC.tableView reloadData];
        
        // 取热门新闻的数据
        self.platformNewsArrayM = [PlatNewsModel mj_objectArrayWithKeyValuesArray:responseObject[@"ptNews"]];
        self.platformNewsVC.platformNewsArrayM = self.platformNewsArrayM;
        if (self.platformNewsArrayM.count == 0) {
            self.platformNewsVC.tableView.height = 0;
        }
        [self.platformNewsVC.tableView reloadData];
        
//        // 去热门活动的数据
//        self.platformActivityArrayM = [PlatformActivityModel mj_objectArrayWithKeyValuesArray:responseObject[@"ptHuodong"]];
//        self.platformActivityVC.platformActivityArrayM = self.platformActivityArrayM;
//        if (self.platformActivityArrayM.count == 0) {
//            self.platformActivityVC.tableView.height = 0;
//        }
//        [self.platformActivityVC.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
//平台活动的接口
- (void)PlatformActivityData
{
    // 请求网贷页其他数据
    NSString *loadString = [NSString stringWithFormat:@"%@WdApi/wdHome",BASEURL];
    NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
    parameters1[@"at"] = tokenString;
    parameters1[@"type"] = @"huodong";
    parameters1[@"start"] = @"0";
    parameters1[@"limit"] = @"10";
    [self.mgr POST:loadString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"responseObjectkkkkkkkkk%@",responseObject);
        // 去热门活动的数据
        self.platformActivityArrayM = [PlatformActivityModel mj_objectArrayWithKeyValuesArray:responseObject[@"ptHuodong"]];
        self.platformActivityVC.platformActivityArrayM = self.platformActivityArrayM;
        if (self.platformActivityArrayM.count == 0) {
            self.platformActivityVC.tableView.height = 0;
        }
        [self.platformActivityVC.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 在View即将显示的时候设置navigationBar和隐藏tabbar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];

    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    // 隐藏底部的tabbar
    //    self.tabBarController.tabBar.hidden = YES;
    
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    //    self.navigationItem.leftBarButtonItem = btnItem;
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"网贷"];
    self.navigationItem.titleView = titleView;
    
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 设置PeerScrollView
- (void)setupPeerScrollView {
    // 添加头部的轮播图
    //    [self setupTopView];
    
    // 添加中部View
    [self bankAngHolpView];
    
    // 设置底部的平台View
    [self setupPlatformView];
    
    // 设置底部的热门tableView
    [self setupBottomTableView];
}
#pragma mark - 设置头部的View
- (void)setupTopView {
    
    SDCycleScrollView *topScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BOScreenW, 220*BOScreenH/1334) delegate:self placeholderImage:[UIImage imageNamed:@"img_loadingb"]];
    topScrollView.imageURLStringsGroup = self.bannerUrlArray;//网络图
    topScrollView.autoScrollTimeInterval = 4;
    topScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    [self.peerScrollView addSubview:topScrollView];
    self.bannerCycleView = topScrollView;
}

#pragma mark------银行 股票 基金。。。帮助的view------
- (void)bankAngHolpView
{
    //银行 股票 基金的image数组
    NSArray *bankimageArray = [NSArray arrayWithObjects:@"wd_icon_ptdh",@"wd_icon_gzpt",@"wd_icon_hysj",@"wd_icon_ptfw",@"wd_icon_wdpj",@"wd_icon_yhcg",@"wd_icon_cd",@"wd_icon_xffq", nil];
    //银行 股票 基金的label数组
    NSArray *bankArray = [NSArray arrayWithObjects:@"平台导航",@"关注平台",@"行业数据",@"平台服务",@"有金评级",@"银行存管",@"车贷",@"消费分期", nil];
    //银行 股票。。。帮助的view
    _bankView = [[UIView alloc]initWithFrame:CGRectMake(0, 56 + 110*BOScreenH/1334, BOScreenW, 356*BOScreenH/1334)];
    _bankView.backgroundColor = [UIColor whiteColor];
    [self.peerScrollView addSubview:_bankView];
    
    for (int i = 0; i < 8; i++)
    {
        int j = i%4;
        int k = i/4;
        
        UIButton *bankButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bankButton.frame = CGRectMake(40*BOScreenW/750+j*(78*BOScreenW/750+119*BOScreenW/750), 40*BOScreenH/1334+(78*BOScreenW/750+75*BOScreenH/1334)*k, 78*BOScreenW/750, 78*BOScreenW/750);
        bankButton.tag = 150+i;
        [bankButton setBackgroundImage:[UIImage imageNamed:bankimageArray[i]] forState:UIControlStateNormal];
        [bankButton addTarget:self action:@selector(bankButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bankView addSubview:bankButton];
        
        UILabel *bankLabel  = [[UILabel alloc]init];
        bankLabel.frame = CGRectMake(17*BOScreenW/750+j*(120*BOScreenW/750+79*BOScreenW/750), 141*BOScreenH/1334+(108*BOScreenW/750+41*BOScreenH/1334)*k, 120*BOScreenW/750, 13);
        bankLabel.text = bankArray[i];
        bankLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        bankLabel.font = [UIFont systemFontOfSize:12];
        bankLabel.textAlignment = NSTextAlignmentCenter;
        [_bankView addSubview:bankLabel];
    }
    
    //    //创建五个button和五个label
    //    for(int i=0; i<2; i++)
    //    {
    //        for(int j=0; j<3; j++)
    //        {
    //            UIButton *bankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //            double b = (78*BOScreenW/750)*j;
    //            double c = (BOScreenW-(40*BOScreenW/750)*2-(78*BOScreenW/750)*5)/4*j;
    //            bankButton.frame = CGRectMake(40*BOScreenW/750+b+c, 44*BOScreenH/1334+(78*BOScreenW/750+75*BOScreenH/1334)*i, 78*BOScreenW/750, 78*BOScreenW/750);
    //            bankButton.tag = 5*i+j;
    //            [bankButton addTarget:self action:@selector(bankButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    //            [_bankView addSubview:bankButton];
    //
    //            UILabel *bankLabel  = [[UILabel alloc]init];
    //            bankLabel.frame = CGRectMake(40*BOScreenW/750+b+c-18*BOScreenW/750, 44*BOScreenH/1334+85*BOScreenW/750+16*BOScreenH/1334+(153*BOScreenH/1334)*i - 3*BOScreenH/1334, 121*BOScreenW/750, 13);
    //            bankLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    //            bankLabel.font = [UIFont systemFontOfSize:12];            bankLabel.textAlignment = NSTextAlignmentCenter;
    //            [_bankView addSubview:bankLabel];
    //
    //            if (i==0)
    //            {
    //                [bankButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",bankimageArray[j]]] forState:UIControlStateNormal];
    //                bankLabel.text = [NSString stringWithFormat:@"%@",bankArray[j]];
    //            }else{
    //                [bankButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",bankimageArray[j+3]]] forState:UIControlStateNormal];
    //                bankLabel.text = [NSString stringWithFormat:@"%@",bankArray[j+3]];
    //            }
    //        }
    //    }
    //
}
#pragma mark - bankButtonClick
#pragma mark------ 平台基金的点击事件------
- (void)bankButtonClick:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 150:
        {
            // 跳转到平台导航
            PlatformNavigationVC *platformNavigationVC = [[PlatformNavigationVC alloc] init];
            platformNavigationVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:platformNavigationVC animated:YES];
            break;
        }
        case 1:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"暂不开放" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            //            DemonstrationOfFundViewController *demonstrationOfFundDataVc = [[DemonstrationOfFundViewController alloc]init];
            //            demonstrationOfFundDataVc.hidesBottomBarWhenPushed = YES;
            //            [self.navigationController pushViewController:demonstrationOfFundDataVc animated:YES];
            break;
        }
        case 151:
        {
            if (USERUID)
            {
                FocusPlatformViewController *focusPViewController = [[FocusPlatformViewController alloc]init];
                focusPViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:focusPViewController animated:YES];
//                            PlatformDataViewController *platformDataVc = [[PlatformDataViewController alloc]init];
//                            platformDataVc.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:platformDataVc animated:YES];
                break;
            } else
            {
                //登陆界面
                [self pushToLoginViewController];
                break;
            }
        }
        case 152:
        {
            NewIndustryDataViewController *vc = [NewIndustryDataViewController create];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 153:
        {
            // 跳转到平台服务
            PlatformServiceViewController *platformServeVC = [[PlatformServiceViewController alloc] init];
            platformServeVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:platformServeVC animated:YES];
            break;
        }
        case 154:
            // 创建网贷控制器
        {
            NetCreditRatingViewController *netCreditRatingVc = [[NetCreditRatingViewController alloc]init];
            [self.navigationController pushViewController:netCreditRatingVc animated:YES];
            break;
        }
        case 6:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"暂不开放" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            // 跳转到网贷基金
            //            NetLoanFundVC *netLoanFundVC = [[NetLoanFundVC alloc] init];
            //            netLoanFundVC.hidesBottomBarWhenPushed = YES;
            //            [self.navigationController pushViewController:netLoanFundVC animated:YES];
            break;
        }
        case 155:
        {
            BankDepositoryViewController *ankDepositoryVc = [[BankDepositoryViewController alloc]init];
            [self.navigationController pushViewController:ankDepositoryVc animated:YES];
            break;
        }
        case 156:
        {
            // 跳转到车贷
            NewCarLoanViewController *carLoanVC = [NewCarLoanViewController create];
            [self.navigationController pushViewController:carLoanVC animated:YES];
            break;
        }
        case 157:
        {
            ConsumptionViewController *consumptionVc = [[ConsumptionViewController alloc]init];
            [self.navigationController pushViewController:consumptionVc animated:YES];
            
            break;
        }
        default:
            break;
    }
}

#pragma mark - 设置底部的平台View
- (void)setupPlatformView {
    UIView *platformView = [[UIView alloc] initWithFrame:CGRectMake(0, 297 * BOHeightRate, BOScreenW, 40 * BOHeightRate)];
    self.platformView = platformView;
    platformView.backgroundColor = [UIColor whiteColor];
    [self.peerScrollView addSubview:platformView];
    // 添加热门平台按钮
    UIButton *platformBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10 * BOHeightRate, BOScreenW * 0.33, 20 * BOHeightRate)];
    self.selectBtn = platformBtn;
    platformBtn.tag = 1003;
    [platformBtn addTarget:self action:@selector(platformBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self setupPlatformBtnPropertyBtn:platformBtn titleString:@"热门平台" normalColor:[UIColor colorWithHexString:@"#333333" alpha:1] selectColor:[UIColor colorWithHexString:@"#@d83F0" alpha:1] fontSize:14];
    [self.btnArray addObject:platformBtn];
    [platformView addSubview:platformBtn];
    
    // 添加最新活动的btn
    UIButton *activityBtn = [[UIButton alloc] initWithFrame:CGRectMake(BOScreenW * 0.33, 10 * BOHeightRate, BOScreenW * 0.33, 20 * BOHeightRate)];
    activityBtn.tag = 1004;
    [self setupPlatformBtnPropertyBtn:activityBtn titleString:@"平台活动" normalColor:[UIColor colorWithHexString:@"#333333" alpha:1] selectColor:[UIColor colorWithHexString:@"#2D83F0" alpha:1] fontSize:14];
    [activityBtn addTarget:self action:@selector(platformBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnArray addObject:activityBtn];
    [platformView addSubview:activityBtn];
    // 添加最新新闻的btn
    UIButton *newBtn = [[UIButton alloc] initWithFrame:CGRectMake(2 * BOScreenW * 0.33, 10 * BOHeightRate, BOScreenW * 0.33, 20 * BOHeightRate)];
    [newBtn addTarget:self action:@selector(platformBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    newBtn.tag = 1005;
    [self.btnArray addObject:newBtn];
    [self setupPlatformBtnPropertyBtn:newBtn titleString:@"平台新闻" normalColor:[UIColor colorWithHexString:@"#333333" alpha:1] selectColor:[UIColor colorWithHexString:@"#2D83F0" alpha:1] fontSize:14];
    [platformView addSubview:newBtn];
    
    // 添加下面滑动的线
    UIView *slideView = [[UIView alloc] init];
    self.slideView = slideView;
    slideView.y = 38 * BOHeightRate;
    slideView.width = platformBtn.width * 0.3;
    slideView.height = 2 * BOHeightRate;
    slideView.centerX = platformBtn.centerX;
    slideView.backgroundColor = [UIColor colorWithHexString:@"#4697FB" alpha:1];
    [platformView addSubview:slideView];
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 79*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
    lineview.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
    [platformView addSubview:lineview];
}
#pragma mark - 重写setSelectBtn方法
- (void)setSelectBtn:(UIButton *)selectBtn {
    _selectBtn.selected = NO;
    _selectBtn = selectBtn;
    _selectBtn.selected = YES;
}
#pragma mark - 设置平台按钮的点击事件
- (void)platformBtnClick:(UIButton *)btn {
    [self setSelectBtn:btn];
    CGPoint contentOffset = self.bottomScrollView.contentOffset;
    contentOffset.x = (btn.tag - 1003) * BOScreenW;
    
    self.bottomScrollView.contentOffset = contentOffset;
    // 移动下划线
    [UIView animateWithDuration:0.25 animations:^{
        
        self.slideView.centerX = btn.centerX;
    }];
}
#pragma mark  - 设置platformView中的按钮属性
- (void)setupPlatformBtnPropertyBtn:(UIButton *)btn titleString:(NSString *)titleString normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor fontSize:(CGFloat)fontSize {
    [btn setTitle:titleString forState:UIControlStateNormal];
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    [btn setTitleColor:selectColor forState:UIControlStateSelected];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
}

//#pragma mark - 设置底部的平台View
//- (void)setupPlatformView {
//    UIView *platformView = [[UIView alloc] initWithFrame:CGRectMake(0, 305 * BOHeightRate, BOScreenW, 40 * BOHeightRate)];
//    self.platformView = platformView;
//    platformView.backgroundColor = [UIColor whiteColor];
//    [self.peerScrollView addSubview:platformView];
//    // 添加热门平台按钮
//    UIButton *platformBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10 * BOHeightRate, BOScreenW * 0.333, 20 * BOHeightRate)];
//    self.selectBtn = platformBtn;
//    platformBtn.tag = 1003;
//    [platformBtn addTarget:self action:@selector(platformBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self setupPlatformBtnPropertyBtn:platformBtn titleString:@"热门平台" normalColor:[UIColor colorWithHexString:@"#333333" alpha:1] selectColor:[UIColor colorWithHexString:@"#@d83F0" alpha:1] fontSize:14];
//    [self.btnArray addObject:platformBtn];
//    [platformView addSubview:platformBtn];
//
//    // 添加最新活动的btn
//    UIButton *activityBtn = [[UIButton alloc] initWithFrame:CGRectMake(BOScreenW * 0.333, 10 * BOHeightRate, BOScreenW * 0.333, 20 * BOHeightRate)];
//    activityBtn.tag = 1004;
//    [self setupPlatformBtnPropertyBtn:activityBtn titleString:@"热门活动" normalColor:[UIColor colorWithHexString:@"#333333" alpha:1] selectColor:[UIColor colorWithHexString:@"#2D83F0" alpha:1] fontSize:14];
//    [activityBtn addTarget:self action:@selector(platformBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.btnArray addObject:activityBtn];
//    [platformView addSubview:activityBtn];
//    // 添加最新新闻的btn
//    UIButton *newBtn = [[UIButton alloc] initWithFrame:CGRectMake(2 * BOScreenW * 0.333, 10 * BOHeightRate, BOScreenW * 0.333, 20 * BOHeightRate)];
//    [newBtn addTarget:self action:@selector(platformBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    newBtn.tag = 1005;
//    [self.btnArray addObject:newBtn];
//    [self setupPlatformBtnPropertyBtn:newBtn titleString:@"热门新闻" normalColor:[UIColor colorWithHexString:@"#333333" alpha:1] selectColor:[UIColor colorWithHexString:@"#2D83F0" alpha:1] fontSize:14];
//    [platformView addSubview:newBtn];
//
//    // 添加下面滑动的线
//    UIView *slideView = [[UIView alloc] init];
//    self.slideView = slideView;
//    slideView.y = 38 * BOHeightRate;
//    slideView.width = self.selectBtn.width * 0.3;
//    slideView.height = 2 * BOHeightRate;
//    slideView.centerX = self.selectBtn.center.x;
//    slideView.backgroundColor = [UIColor colorWithHexString:@"#4697FB" alpha:1];
//    [platformView addSubview:slideView];
//}
//#pragma mark - 重写setSelectBtn方法
//- (void)setSelectBtn:(UIButton *)selectBtn {
//    _selectBtn.selected = NO;
//    _selectBtn = selectBtn;
//    _selectBtn.selected = YES;
//}
//#pragma mark - 设置平台按钮的点击事件
//- (void)platformBtnClick:(UIButton *)btn {
//    [self setSelectBtn:btn];
//    CGPoint contentOffset = self.bottomScrollView.contentOffset;
//    contentOffset.x = (btn.tag - 1003) * BOScreenW;
//
//    self.bottomScrollView.contentOffset = contentOffset;
//    // 移动下划线
//    [UIView animateWithDuration:0.25 animations:^{
//
//        self.slideView.centerX = btn.center.x;
//    }];
//}
//#pragma mark  - 设置platformView中的按钮属性
//- (void)setupPlatformBtnPropertyBtn:(UIButton *)btn titleString:(NSString *)titleString normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor fontSize:(CGFloat)fontSize {
//    [btn setTitle:titleString forState:UIControlStateNormal];
//    [btn setTitleColor:normalColor forState:UIControlStateNormal];
//    [btn setTitleColor:selectColor forState:UIControlStateSelected];
//    [btn.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
//}

#pragma mark - 设置底部的热门平台，热门活动，热们新闻的tableView
- (void)setupBottomTableView {
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 337 * BOHeightRate, BOScreenW, 960 * BOHeightRate)];
    self.bottomScrollView = bottomScrollView;
    bottomScrollView.delegate = self;
    bottomScrollView.tag = 2006;
    bottomScrollView.contentSize = CGSizeMake(BOScreenW * 3, 0);
    bottomScrollView.pagingEnabled = YES;
    bottomScrollView.bounces = NO;
    self.peerScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.bottomScrollView.frame));
    [self.peerScrollView addSubview:bottomScrollView];
    // 添加热门平台的控制器
    BOHotPlatformTableVC *hotPlatformVC = [[BOHotPlatformTableVC alloc] initWithStyle:UITableViewStylePlain];
    self.hotPlatformVC = hotPlatformVC;
    hotPlatformVC.tableView.frame = CGRectMake(0, 0, BOScreenW, 950 * BOHeightRate-1);
    hotPlatformVC.tableView.scrollEnabled = NO;
    hotPlatformVC.tableView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    [self addChildViewController:hotPlatformVC];
    [self.bottomScrollView addSubview:hotPlatformVC.tableView];
    // 添加平台活动的控制器
    BOPlatformActivityTableVC *platformActivityVC = [[BOPlatformActivityTableVC alloc] init];
    self.platformActivityVC = platformActivityVC;
    platformActivityVC.tableView.frame = CGRectMake(BOScreenW, 0, BOScreenW, 840 * BOHeightRate);
    platformActivityVC.tableView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    platformActivityVC.tableView.scrollEnabled = NO;
    
    [self addChildViewController:platformActivityVC];
    [self.bottomScrollView addSubview:platformActivityVC.tableView];
    // 添加平台新闻的控制器
    BOPlatformTableVC *platformNewsVC = [[BOPlatformTableVC alloc] init];
    self.platformNewsVC = platformNewsVC;
    self.platformNewsVC.tableView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    platformNewsVC.tableView.frame = CGRectMake(2 * BOScreenW, 0, BOScreenW, 900 * BOHeightRate);
    platformNewsVC.tableView.scrollEnabled = NO;
    [self addChildViewController:platformNewsVC];
    [self.bottomScrollView addSubview:platformNewsVC.tableView];
}
#pragma mark - 监听scrollView的滚动设置置顶
#define offestY (CGRectGetMaxY(_bankView.frame) + 5 * BOScreenH / BOPictureH)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= offestY && !self.offest) {
        self.platformView.frame = CGRectMake(0, 0, BOScreenW, 40 * BOHeightRate);
        [self.view addSubview:self.platformView];
        self.offest = YES;
    }else if (scrollView.contentOffset.y < offestY && self.offest) {
        self.platformView.frame = CGRectMake(0, 297 * BOHeightRate, BOScreenW, 40 * BOHeightRate);
        self.offest = NO;
        [self.peerScrollView addSubview:self.platformView];
    }
    if (self.page == 0) {
        self.peerScrollView.contentSize = CGSizeMake(0, 338 * BOHeightRate + self.hotPlatformArrayM.count * 95 * BOHeightRate + 20 * BOHeightRate);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag == 2006) {
        int page = (scrollView.contentOffset.x + 0.5 * BOScreenW) / BOScreenW;
        self.page = page;
        [self platformBtnClick:self.btnArray[page]];
    }
    
}
//#pragma mark - 设置按钮的属性
//- (void)setupBtnProperty:(UIButton *)btn normalImageString:(NSString *)norImageString SelectImageString:(NSString *)selectImageString highImageString:(NSString *)highImageString norTitle:(NSString *)norTitle norTitleColor:(UIColor *)norColor selectTitleColor:(UIColor *)selectTitleColor fontSize:(CGFloat)fontsize {
//    [btn setImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>];
//}
//#pragma mark - 设置按钮的属性
//- (void)setupLabelProperty

- (void)pushToLoginViewController {
    BONoteVerifyLogiin *noteVerifyLoginVC = [[BONoteVerifyLogiin alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:noteVerifyLoginVC];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:nil];
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
        HotdetailsViewController *hotVc = [[HotdetailsViewController alloc]init];
        hotVc.hidesBottomBarWhenPushed = YES;
        hotVc.ptid = _ptidArr[index];
        [self.navigationController pushViewController:hotVc animated:YES];
    }else
    {
        NSLog(@"不跳转");
    }
}

#pragma mark - helpMethod


@end
