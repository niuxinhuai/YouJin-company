//
//  BOLendMoneyVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOLendMoneyVC.h"
#import "UIImage+UIColor.h"
#import "BOSetupTitleView.h"
#import "BOPictureWheelPlay.h"
#import "lendMoneyCell.h"
#import "LendMoneyDetailVC.h"
#import "BannerModel.h"
#import "LendMoneyModel.h"
#import "HotdetailsViewController.h"
#import "BannerWebViewViewController.h"


static NSString *const ID = @"cell";
static NSString *const selectID = @"selectCell";
@interface BOLendMoneyVC ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *lendMoneyScrollView;

/**底部的tabelView*/
@property (nonatomic, weak) UITableView *productTabelView;

/**引用热门产品的titleView*/
@property (nonatomic, weak) UIView *titleView;


@property (nonatomic, retain) SDCycleScrollView *topBannerView;

/**保存banner图的url的数组*/
@property (nonatomic, strong) NSMutableArray *bannerUrlArray;

@property (nonatomic, weak) AFHTTPSessionManager *mgr;

@property (nonatomic, strong) NSMutableArray *dataArrayM;

/**点击筛选后的遮盖View*/
@property (nonatomic, strong) UIView *coverView;

/**点击筛选弹出的tableView*/
@property (nonatomic, strong) UITableView *selectTableView;

/**筛选条件的数组*/
@property (nonatomic, strong) NSArray *selectArray;

//筛选点击了那一行
@property (nonatomic ,copy)NSString *screeningIndexPathRow;

/**定义一个flag,判断返回*/
@property (nonatomic, assign) int flag;
@property (nonatomic ,strong)NSMutableArray *jumpUrlArr;//banner跳转url
@property (nonatomic ,strong)NSMutableArray *goTypeArr;//判断banner是否能跳转
@property (nonatomic ,strong)NSMutableArray *ptidArr;//banner跳转ptid
@end

@implementation BOLendMoneyVC
#pragma mark - 懒加载
- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.15;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewClick)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}
- (UITableView *)selectTableView {
    if (_selectTableView == nil) {
        _selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40 * BOHeightRate, BOScreenW, 45 * 11 * BOHeightRate)];
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
        _selectTableView.tag = 6;
    }
    return _selectTableView;
}
- (NSArray *)selectArray {
    if (_selectArray == nil) {
        _selectArray = [NSArray arrayWithObjects:@"全部类型",@"学生贷",@"工薪贷",@"企业主贷",@"淘宝贷",@"车贷",@"房贷",@"公积金贷",@"信用卡贷",@"芝麻信用贷",@"小额极速贷", nil];
    }
    return _selectArray;
}
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
#pragma mark - 懒加载bannerUrlArray
- (NSMutableArray *)bannerUrlArray {
    if (_bannerUrlArray == nil) {
        _bannerUrlArray = [NSMutableArray array];
    }
    return _bannerUrlArray;
}
#pragma mark - 懒加载首页ScrollView
- (UIScrollView *)lendMoneyScrollView {
    if (_lendMoneyScrollView == nil) {
        _lendMoneyScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH - 64)];
        _lendMoneyScrollView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        _lendMoneyScrollView.showsVerticalScrollIndicator = NO;
        _lendMoneyScrollView.delegate = self;
        [self.view addSubview:_lendMoneyScrollView];
    }
    return  _lendMoneyScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _ptidArr = [NSMutableArray array];
    _jumpUrlArr = [NSMutableArray array];
    _goTypeArr = [NSMutableArray array];
    // 初始化标记为0
    self.flag = 0;
    // 请求网络数据
    [self requstNetData];
    [self tableViewData];//请求tableview的数据
    // 添加顶部的滚动视图
    [self setupTopView];
    // 添加中部的图片View
    [self setupMiddlePictureView];
    // 添加热门产品的指示器View
    [self setupTitleView];
    // 添加底部tableView
    [self setupBottomTableView];
    // 注册tabelView的cell
    [self.productTabelView registerClass:[lendMoneyCell class] forCellReuseIdentifier:ID];
    [self.selectTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:selectID];
}
#pragma mark - 在View即将显示的时候设置navigationBar和隐藏tabbar
- (void)viewWillAppear:(BOOL)animated {
    // 设置导航条和状态栏的背景颜色
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    //    self.navigationItem.leftBarButtonItem = btnItem;
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    // 设置头部的标题的View
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"借钱"];
    self.navigationItem.titleView = titleView;
}

#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    if (self.flag == 0) {
       [self.navigationController popViewControllerAnimated:YES];
    }else {
        self.flag = 0;
        [self.selectTableView removeFromSuperview];
        [self.coverView removeFromSuperview];
        self.titleView.frame = CGRectMake(0, 181 * BOScreenH / BOPictureH, BOScreenW, 40 * BOScreenH / BOPictureH);
        [self.lendMoneyScrollView addSubview:self.titleView];
    }
    
}
#pragma mark - 请求网络数据
- (void)requstNetData {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    NSString *string = [NSString stringWithFormat:@"%@Borrow/borrowBannerList",BASEURL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"os"] = @"Ios";
    parameters[@"version"] = app_Version;
    [self.mgr POST:string parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            NSArray *array = [BannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (BannerModel *item in array) {
                [self.bannerUrlArray addObject:item.img_url];
                [_jumpUrlArr addObject:item.url];
                [_ptidArr addObject:item.ID];
                [_goTypeArr addObject:item.go_type];
            }
            self.topBannerView.imageURLStringsGroup = self.bannerUrlArray;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark---请求tableview的数据
- (void)tableViewData
{
    // 请求网贷页其他数据
    NSString *loadString = [NSString stringWithFormat:@"%@Borrow/borrowProList",BASEURL];
    NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
    parameters1[@"at"] = tokenString;
    parameters1[@"start"] = @"0";
    parameters1[@"limit"] = @"10";
    parameters1[@"ceid"] = _screeningIndexPathRow;
    [self.mgr POST:loadString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.dataArrayM = [LendMoneyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        
        CGFloat productX = 0;
        CGFloat productY = 222 * BOScreenH / BOPictureH;
        CGFloat productW = BOScreenW;
        //        CGFloat productH = 730 * BOScreenH / BOPictureH;
        self.productTabelView.frame = CGRectMake(productX, productY, productW,  self.dataArrayM.count*292*BOScreenH/1334);
        self.lendMoneyScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.productTabelView.frame));
        
        [self.productTabelView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 设置头部的View
- (void)setupTopView {
//    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 110 * BOScreenH / BOPictureH)];
    self.topBannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BOScreenW, 220*BOScreenH/1334) delegate:self placeholderImage:[UIImage imageNamed:@"img_loadingb"]];
    self.topBannerView.imageURLStringsGroup = self.bannerUrlArray;//网络图
    self.topBannerView.autoScrollTimeInterval = 4;

    [self.lendMoneyScrollView addSubview:self.topBannerView];
}
#pragma mark - 设置中部的图片View
- (void)setupMiddlePictureView {
    // 创建放置图片的View
    CGFloat middleX = 0;
    CGFloat middleY = 110 * BOScreenH / BOPictureH;
    CGFloat middleW = BOScreenW;
    CGFloat middleH = 71 * BOScreenH / BOPictureH;
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(middleX, middleY, middleW, middleH)];
    middleView.backgroundColor = BOColor(244, 245, 247);
    [self.lendMoneyScrollView addSubview:middleView];
    // 添加第一张图片
    CGFloat firstX = 10 * BOScreenW / BOPictureW;
    CGFloat firstY = 8 * BOScreenH / BOPictureH;
    CGFloat firstW = 175 * BOScreenW / BOPictureW;
    CGFloat firstH = 55 * BOScreenH / BOPictureH;
    UIImageView *firstImageV = [[UIImageView alloc] initWithFrame:CGRectMake(firstX, firstY, firstW, firstH)];
    firstImageV.image = [UIImage imageNamed:@"img_left"];
    firstImageV.layer.cornerRadius = 5;
    firstImageV.layer.masksToBounds = YES;
    [middleView addSubview:firstImageV];
    // 添加平台名称
    CGFloat name1X = 20 * BOWidthRate;
    CGFloat name1Y = 16 * BOHeightRate;
    CGFloat name1W = 110 * BOWidthRate;
    CGFloat name1H = 18 * BOHeightRate;
    UILabel *nameLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(name1X, name1Y, name1W, name1H)];
    [nameLabel1 setFont:[UIFont systemFontOfSize:17]];
    [nameLabel1 setTextColor:[UIColor whiteColor]];
    nameLabel1.text = @"小额贷";
    [middleView addSubview:nameLabel1];
    
    // 添加平台特征的label
    CGFloat sub1X = 20 * BOWidthRate;
    CGFloat sub1Y = CGRectGetMaxY(nameLabel1.frame) + 9 * BOHeightRate;
    CGFloat sub1W = 140 * BOWidthRate;
    CGFloat sub1H = 15 * BOHeightRate;
    UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(sub1X, sub1Y, sub1W, sub1H)];
    subLabel.text = @"本平台通过率最高";
    [subLabel setFont:[UIFont systemFontOfSize:12]];
    subLabel.textColor = [UIColor whiteColor];
    [middleView addSubview:subLabel];
    // 添加第二张图片
    CGFloat secondX = CGRectGetMaxX(firstImageV.frame) + 5 * BOScreenW / BOPictureW;
    CGFloat secondY = firstY;
    CGFloat secondW = firstW;
    CGFloat secondH = firstH;
    UIImageView *secondImageV = [[UIImageView alloc] initWithFrame:CGRectMake(secondX, secondY, secondW, secondH)];
    secondImageV.layer.cornerRadius = 5;
    secondImageV.layer.masksToBounds = YES;
    secondImageV.image = [UIImage imageNamed:@"img_right"];
    [middleView addSubview:secondImageV];
    
    // 添加第二张平台名称
    CGFloat name2X =secondX + 10 * BOWidthRate;
    CGFloat name2Y = 16 * BOHeightRate;
    CGFloat name2W = 110 * BOWidthRate;
    CGFloat name2H = 18 * BOHeightRate;
    UILabel *nameLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(name2X, name2Y, name2W, name2H)];
    [nameLabel2 setFont:[UIFont systemFontOfSize:17]];
    [nameLabel2 setTextColor:[UIColor whiteColor]];
    nameLabel2.text = @"极速贷";
    [middleView addSubview:nameLabel2];
    
    // 添加第二张平台特征的label
    CGFloat sub2X = name2X;
    CGFloat sub2Y = CGRectGetMaxY(nameLabel2.frame) + 9 * BOHeightRate;
    CGFloat sub2W = 140 * BOWidthRate;
    CGFloat sub2H = 15 * BOHeightRate;
    UILabel *subLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(sub2X, sub2Y, sub2W, sub2H)];
    subLabel2.text = @"凭手机号免息贷款";
    [subLabel2 setFont:[UIFont systemFontOfSize:12]];
    subLabel2.textColor = [UIColor whiteColor];
    [middleView addSubview:subLabel2];

    
}
#pragma mark - 创建热门产品的View
- (void)setupTitleView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 181 * BOScreenH / BOPictureH, BOScreenW, 40 * BOScreenH / BOPictureH)];
    self.titleView = titleView;
    titleView.backgroundColor = [UIColor whiteColor];
    [self.lendMoneyScrollView addSubview:titleView];
    // 设置指示器
    UIView *indicateView = [[UIView alloc] initWithFrame:CGRectMake(0, 11.5 * BOScreenH / BOPictureH, 5 * BOScreenW / BOPictureW, 17 * BOScreenH / BOPictureH)];
    indicateView.backgroundColor = [UIColor colorWithHexString:@"#4697FB" alpha:1];
    [titleView addSubview:indicateView];
    
    // 添加热门借钱产品的lable
    UILabel *commentLable = [[UILabel alloc] init];
    commentLable.frame = CGRectMake(15 * BOScreenW / BOPictureW, 10 * BOScreenH / BOPictureH, 100 * BOScreenW / BOPictureW, 20 * BOScreenH / BOPictureH);
    commentLable.text = @"热门借钱产品";
    [commentLable setFont:[UIFont systemFontOfSize:15]];
    [titleView addSubview:commentLable];
    
    // 添加筛选Btn
    CGFloat screenX = 315 * BOScreenW / BOPictureW;
    CGFloat screenY = 10 * BOScreenH / BOPictureH;
    CGFloat screenW = 50 * BOScreenW / BOPictureW;
    CGFloat screenH = 20 * BOScreenH / BOPictureH;
    UIButton *screenBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenX, screenY, screenW, screenH)];
    [screenBtn setTitle:@" 筛选" forState:UIControlStateNormal];
    [screenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [screenBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [screenBtn setImage:[UIImage imageNamed:@"icon_shuaxuan"] forState:UIControlStateNormal];
    [screenBtn addTarget:self action:@selector(screenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:screenBtn];
}
#pragma mark - 筛选按钮的点击事件
- (void)screenBtnClick:(UIButton *)btn {
    self.flag = 1;
    [self.view addSubview:self.coverView];
    self.titleView.frame = CGRectMake(0, 0, BOScreenW, 40 * BOScreenH / BOPictureH);
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.selectTableView];
}
#pragma mark - 点击遮盖View的处理事件
- (void)coverViewClick {
    self.flag = 0;
    [self.selectTableView removeFromSuperview];
    [self.coverView removeFromSuperview];
    self.titleView.frame = CGRectMake(0, 181 * BOScreenH / BOPictureH, BOScreenW, 40 * BOScreenH / BOPictureH);
    [self.lendMoneyScrollView addSubview:self.titleView];
}
#pragma mark - 设置底部的tableView
- (void)setupBottomTableView {
    CGFloat productX = 0;
    CGFloat productY = 222 * BOScreenH / BOPictureH;
    CGFloat productW = BOScreenW;
    CGFloat productH = 730 * BOScreenH / BOPictureH;
    UITableView *productTableView = [[UITableView alloc] initWithFrame:CGRectMake(productX, productY, productW, productH) style:UITableViewStylePlain];
    self.productTabelView = productTableView;
    productTableView.scrollEnabled = NO;
    productTableView.delegate = self;
    productTableView.dataSource = self;
    productTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.lendMoneyScrollView addSubview:productTableView];
    self.lendMoneyScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.productTabelView.frame));
}
#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 6) {
        return 1;
    }
    return self.dataArrayM.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 6) {
        return self.selectArray.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 6) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selectID forIndexPath:indexPath];
        cell.textLabel.text = self.selectArray[indexPath.row];
        [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
        //点击后的阴影效果
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    lendMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.item = self.dataArrayM[indexPath.section];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView.tag == 6) {
        return 0.0001;
    }
    return 8 * BOScreenH / BOPictureH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 6) {
        return 45 * BOHeightRate;
    }
    return 138 * BOScreenH / BOPictureH;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 6) {
        self.flag = 0;
        [self.selectTableView removeFromSuperview];
        [self.coverView removeFromSuperview];
        self.titleView.frame = CGRectMake(0, 181 * BOScreenH / BOPictureH, BOScreenW, 40 * BOScreenH / BOPictureH);
        [self.lendMoneyScrollView addSubview:self.titleView];
        
        _screeningIndexPathRow = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        [self tableViewData];
        [_productTabelView reloadData];
    } else {
        LendMoneyModel *model = self.dataArrayM[indexPath.section];
        LendMoneyDetailVC *lendMoneyDetailVC = [[LendMoneyDetailVC alloc] init];
        lendMoneyDetailVC.brid = model.brid;
        lendMoneyDetailVC.name = model.name;
        [self.navigationController pushViewController:lendMoneyDetailVC animated:YES];
    }
}
#pragma mark - UIScrollViewDelegate
#define offestY 181 * BOScreenH / BOPictureH
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= 181 * BOScreenH / BOPictureH) {
        self.titleView.frame = CGRectMake(0, 0, BOScreenW, 40 * BOScreenH / BOPictureH);
        [self.view addSubview:self.titleView];
    }else if (scrollView.contentOffset.y < 181 * BOScreenH / BOPictureH) {
        self.titleView.frame = CGRectMake(0, 181 * BOScreenH / BOPictureH, BOScreenW, 40 * BOScreenH / BOPictureH);
        [self.lendMoneyScrollView addSubview:self.titleView];
    }
}
#pragma 点击banner图的回调
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
