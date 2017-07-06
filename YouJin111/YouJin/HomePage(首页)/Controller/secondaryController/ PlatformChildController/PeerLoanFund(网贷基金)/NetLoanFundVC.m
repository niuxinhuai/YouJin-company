//
//  NetLoanFundVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/24.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NetLoanFundVC.h"
#import "BOPictureWheelPlay.h"
#import "BuyBazaarTableVC.h"
#import "HotNetFundTableVC.h"
#import "BannerModel.h"
#import "BuyMarketModel.h"
#import "HotNetFundModel.h"
@interface NetLoanFundVC ()<UIScrollViewDelegate, SDCycleScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *NetLoanScrollView;

@property (nonatomic, weak) UIView *titleView;

// 标记选中的按钮
@property (nonatomic, weak) UIButton *selectBtn;

@property (nonatomic, weak) UIScrollView *bottomScrollView;

/**热门网基的下划线*/
@property (nonatomic, weak) UIView *slideView;

@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic, weak) AFHTTPSessionManager *mgr;

/**头部的banner数组*/
@property (nonatomic, strong) NSMutableArray *bannerUrlArray;

/**热门网基的数组*/
@property (nonatomic, strong) NSMutableArray *hotArrayM;

/**买方市场的数组*/
@property (nonatomic, strong) NSMutableArray *buyArrayM;

@property (nonatomic, weak) HotNetFundTableVC *hotNetFundTableVC;

@property (nonatomic, weak) BuyBazaarTableVC *buyBazaarTableVC;
@end

@implementation NetLoanFundVC
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}
- (NSMutableArray *)bannerUrlArray {
    if (_bannerUrlArray == nil) {
        _bannerUrlArray = [NSMutableArray array];
    }
    return _bannerUrlArray;
}
- (NSMutableArray *)hotArrayM {
    if (_hotArrayM == nil) {
        _hotArrayM = [NSMutableArray array];
    }
    return _hotArrayM;
}
- (NSMutableArray *)buyArrayM {
    if (_buyArrayM == nil) {
        _buyArrayM = [NSMutableArray array];
    }
    return _buyArrayM;
}
- (UIScrollView *)NetLoanScrollView {
    if (_NetLoanScrollView == nil) {
        _NetLoanScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH - 49)];
        _NetLoanScrollView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        _NetLoanScrollView.showsVerticalScrollIndicator = NO;
        _NetLoanScrollView.contentSize = CGSizeMake(0, 1000);
        _NetLoanScrollView.delegate = self;
        [self.view addSubview:_NetLoanScrollView];
    }
    return  _NetLoanScrollView;
}
- (NSMutableArray *)btnArray {
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置navigationItem
    [self setupNavigationItem];
    
    // 设置头部的滚动View
//    [self setupTopWheelView];
    // 设置热门网基和买方市场的View
    [self setupTitleView];
    
    // 设置热门网基和买方市场的控制器
    [self setupBottomScorllView];
}

#pragma mark - 设置navigationItem
- (void)setupNavigationItem {
    // 设置navigationItem的左边按钮
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(backToLevel)];
    //    self.navigationItem.leftBarButtonItem = btnItem;
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    // 设置标题
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"网贷基金"];
    self.navigationItem.titleView = titleView;
    // 设置navigationItem的右边按钮
    UIBarButtonItem *rightBtnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"icon_help"] selImage:[UIImage imageNamed:@"icon_help"] target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightBtnItem;

}
#pragma mark - 返回上一级
- (void)backToLevel {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 请求网络数据
- (void)requstNetData {
    // 请求banner图的数据
    NSString *string = [NSString stringWithFormat:@"%@WdApi/wjBannerList",BASEURL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    [self.mgr POST:string parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = [BannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        for (BannerModel *item in array) {
            [self.bannerUrlArray addObject:item.img_url];
        }
        // 添加头部的轮播图
        [self setupTopWheelView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    //请求热门网基的数据
    NSString *hotString = [NSString stringWithFormat:@"%@WdApi/wangji", BASEURL];
    NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
    parameters1[@"at"] = tokenString;
    parameters1[@"start"] = @"0";
    parameters1[@"limit"] = @"10";
    [self.mgr POST:hotString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.hotArrayM = [HotNetFundModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.hotNetFundTableVC.hotArrayM = self.hotArrayM;
        [self.hotNetFundTableVC.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    //请求买方市场的数据
    NSString *buyString = [NSString stringWithFormat:@"%@WdApi/wangji", BASEURL];
    NSMutableDictionary *parameters2 = [NSMutableDictionary dictionary];
    parameters2[@"at"] = tokenString;
    parameters2[@"start"] = @"0";
    parameters2[@"limit"] = @"10";
    [self.mgr POST:buyString parameters:parameters2 progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.buyArrayM = [BuyMarketModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.buyBazaarTableVC.buyArrayM = self.buyArrayM;
        [self.buyBazaarTableVC.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
#pragma mark - 添加头部的滚动视图
- (void)setupTopWheelView {
    SDCycleScrollView *topScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BOScreenW, 220*BOScreenH/1334) delegate:self placeholderImage:[UIImage imageNamed:@"img_loadingb"]];
    topScrollView.imageURLStringsGroup = self.bannerUrlArray;//网络图
    topScrollView.autoScrollTimeInterval = 4;
    [self.NetLoanScrollView addSubview:topScrollView];
}
#pragma mark - 设置热门网基和买方市场的按钮
- (void)setupTitleView {
    // 创建titleView
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 118 * BOHeightRate, BOScreenW, 40 * BOHeightRate)];
    self.titleView = titleView;
    titleView.backgroundColor = [UIColor whiteColor];
    [self.NetLoanScrollView addSubview:titleView];
    
    // 创建热门网基按钮
    UIButton *hotNetBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10 * BOHeightRate, 0.5 * BOScreenW, 20 * BOHeightRate)];
    [self setupPlatformBtnPropertyBtn:hotNetBtn titleString:@"热门网基" normalColor:[UIColor colorWithHexString:@"#333333" alpha:1] selectColor:[UIColor colorWithHexString:@"#2D83F0" alpha:1] fontSize:14];
    [hotNetBtn addTarget:self action:@selector(netLoanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    hotNetBtn.tag = 0;
    self.selectBtn = hotNetBtn;
    [self.btnArray addObject:hotNetBtn];
    [titleView addSubview:hotNetBtn];
    // 创建买方市场按钮
    UIButton *buyMarketBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.5 * BOScreenW, 10 * BOHeightRate, BOScreenW * 0.5, 20 * BOHeightRate)];
    [self setupPlatformBtnPropertyBtn:buyMarketBtn titleString:@"买方市场" normalColor:[UIColor colorWithHexString:@"#333333" alpha:1] selectColor:[UIColor colorWithHexString:@"#2D83F0" alpha:1] fontSize:14];
    buyMarketBtn.tag = 1;
    [self.btnArray addObject:buyMarketBtn];
    [buyMarketBtn addTarget:self action:@selector(netLoanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:buyMarketBtn];
    
    // 添加底部的下滑线View
    UIView *slideView = [[UIView alloc] init];
    slideView.width = hotNetBtn.width * 0.2;
    slideView.height = 2 * BOHeightRate;
    slideView.centerX = hotNetBtn.centerX;
    slideView.y = 38 * BOHeightRate;
    slideView.backgroundColor = [UIColor colorWithHexString:@"#4697FB" alpha:1];
    self.slideView = slideView;
    [titleView addSubview:slideView];
}
#pragma mark - 重写setSelectBtn方法
- (void)setSelectBtn:(UIButton *)selectBtn {
    _selectBtn.selected = NO;
    _selectBtn = selectBtn;
    selectBtn.selected = YES;
}
#pragma mark - 设置平台按钮的点击事件
- (void)netLoanBtnClick:(UIButton *)btn {
    [self setSelectBtn:btn];
    CGPoint contentOffset = self.bottomScrollView.contentOffset;
    contentOffset.x = btn.tag * BOScreenW;
    
    self.bottomScrollView.contentOffset = contentOffset;
    // 移动下划线
    [UIView animateWithDuration:0.25 animations:^{
        
        self.slideView.centerX = btn.centerX;
    }];
}

#pragma mark  - 设置titleView中的按钮属性
- (void)setupPlatformBtnPropertyBtn:(UIButton *)btn titleString:(NSString *)titleString normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor fontSize:(CGFloat)fontSize {
    [btn setTitle:titleString forState:UIControlStateNormal];
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    [btn setTitleColor:selectColor forState:UIControlStateSelected];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
}
#pragma mark - 设置热门网基和平台市场的控制器
- (void)setupBottomScorllView {
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 159 * BOHeightRate, BOScreenW, 1000 * BOHeightRate)];
    bottomScrollView.contentSize = CGSizeMake(2 * BOScreenW, 0);
    bottomScrollView.pagingEnabled = YES;
    bottomScrollView.delegate = self;
    // 设置bottomScrollView的tag
    bottomScrollView.tag = 6;
    self.bottomScrollView = bottomScrollView;
    [self.NetLoanScrollView addSubview:bottomScrollView];
    
    // 创建热门网基控制器
    HotNetFundTableVC *hotNetFundTableVC = [[HotNetFundTableVC alloc] initWithStyle:UITableViewStylePlain];
    hotNetFundTableVC.tableView.frame = CGRectMake(0, 0, BOScreenW, 1000 * BOHeightRate);
    self.hotNetFundTableVC = hotNetFundTableVC;
    hotNetFundTableVC.tableView.scrollEnabled = NO;
    [self addChildViewController:hotNetFundTableVC];
    [bottomScrollView addSubview:hotNetFundTableVC.tableView];
    // 创建买方市场控制器
    BuyBazaarTableVC *buyBazaarTableVC = [[BuyBazaarTableVC alloc] initWithStyle:UITableViewStylePlain];
    self.buyBazaarTableVC = buyBazaarTableVC;
    buyBazaarTableVC.tableView.frame = CGRectMake(BOScreenW, 0, BOScreenW, 1000 * BOHeightRate);
    buyBazaarTableVC.tableView.scrollEnabled = NO;
    [self addChildViewController:buyBazaarTableVC];
    [bottomScrollView addSubview:buyBazaarTableVC.tableView];
}
#pragma mark - 监听scrollView的滚动设置置顶
#define offestY (110 * BOScreenH / BOPictureH)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag != 6) {
        if (scrollView.contentOffset.y >= offestY) {
            self.titleView.frame = CGRectMake(0, 0, BOScreenW, 40 * BOHeightRate);
            [self.view addSubview:self.titleView];
        }else if (scrollView.contentOffset.y < offestY) {
            self.titleView.frame = CGRectMake(0, 118 * BOHeightRate, BOScreenW, 40 * BOHeightRate);
            [self.NetLoanScrollView addSubview:self.titleView];
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag == 6) {
        int page = scrollView.contentOffset.x / BOScreenW;
        [self netLoanBtnClick:self.btnArray[page]];
    }
}
@end
