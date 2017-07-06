//
//  PlatformNavigationVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformNavigationVC.h"
#import "BOLcationButton.h"
#import "HotPlatformTableViewCell.h"
#import "BOPlatformNavigationTableView.h"
#import "PlatformSelectCityView.h"
#import "PeerHonePageModel.h"
#import "HotdetailsViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "PlatformSearchVC.h"
#import "SearchPlatformViewController.h"
static NSString *const ID = @"cell";
static NSString *const backID = @"backCell";
@interface PlatformNavigationVC ()<UITableViewDataSource, UITableViewDelegate, PlatformSelectCityViewDelegate>
@property (nonatomic, weak) AFHTTPSessionManager *mgr;
/**年化的数组 */
@property (nonatomic, strong) NSArray *yearMeltArray;

/**业务类型的数组*/
@property (nonatomic, strong) NSArray *operationArray;

/**背景的数组*/
@property (nonatomic, strong) NSArray *backArray;

/**点击按钮呈现的tableView的数据数组*/
@property (nonatomic, strong) NSArray *tableViewArray;
/**点击头部的按钮的显示的tableView*/
@property (nonatomic, strong) BOPlatformNavigationTableView *platformNavigationTableView;

/** 遮盖View*/
@property (nonatomic, strong) UIView *coverView;

/**被选中的按钮*/
@property (nonatomic, strong) BOLcationButton *selectBtn;

/**所选城市的View*/
@property (nonatomic, strong) PlatformSelectCityView *plarformSelectCityView;

/**网络加载后的数据数组*/
@property (nonatomic, strong) NSMutableArray *dataArrayM;

/**页面上主的tableView*/
@property (nonatomic, weak) UITableView *tableView;

/**记录每个cell高度的数组*/
@property (nonatomic, strong) NSMutableArray *heightArrayM;

/**单个cell的高度*/
@property (nonatomic, assign) CGFloat CellHeight;

/**记录当前请求到哪儿*/
@property (nonatomic, assign) int currentInt;

/**所在城市编号搜索*/
@property (nonatomic, copy) NSString *selectCity;

/**低利率搜索*/
@property (nonatomic, copy) NSString *selectApr_min;
/**高利率搜索*/
@property (nonatomic, copy) NSString *selectApr_max;
/**业务模式搜索*/
@property (nonatomic, copy) NSString *selectBus_model;
/**背景搜索*/
@property (nonatomic, copy) NSString *selectBackground;

/**城市按钮*/
@property (nonatomic, weak) UIButton *firstBtn;
/**利率按钮*/
@property (nonatomic, weak) UIButton *secondBtn;
/**业务模式按钮*/
@property (nonatomic, weak) UIButton *thirdBtn;
/**背景按钮*/
@property (nonatomic, weak) UIButton *fourBtn;
@end

@implementation PlatformNavigationVC
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}
- (NSMutableArray *)heightArrayM {
    if (_heightArrayM == nil) {
        _heightArrayM = [NSMutableArray array];
    }
    return _heightArrayM;
}
#pragma mark - 懒加载网络数据数组
- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        _dataArrayM = [NSMutableArray array];
    }
    return _dataArrayM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景颜色
    self.view.backgroundColor = BOColor(244, 245, 247);
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置年化，业务类型，背景的数据数组
    [self setupDataArray];
    // 设置navigationItem
    [self setupNavigationItem];
    // 设置topView
    [self setupTopView];
    // 设置tableView
    [self setupTableView];
    // 添加上拉加载和下拉刷新
    [self setupRefreshVeiw];
    // 请求数据
    [self.tableView.mj_header beginRefreshing];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
#pragma mark - 添加上拉加载更多，和下拉刷新
- (void)setupRefreshVeiw
{
    // 添加下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requstNetData)];
    
    // 根据拖拽，自动显示下拉控件
    header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = header;
    
    // 上拉刷新
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 自动根据有无数据，判断上拉控件是否完全显示
    footer.automaticallyHidden = YES;
    
    self.tableView.mj_footer = footer;
    
}

#pragma mark - 加载网络数据
- (void)requstNetData {
    // 取消之前请求
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 请求数据
    NSString *string = [NSString stringWithFormat:@"%@WdApi/wdList",BASEURL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = @"20";
    parameters[@"city"] = self.selectCity;
    parameters[@"apr_min"] = self.selectApr_min;
    parameters[@"apr_max"] = self.selectApr_max;
    parameters[@"bus_model"] = self.selectBus_model;
    parameters[@"background"] = self.selectBackground;
    [self.mgr POST:string parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_header endRefreshing];
        self.heightArrayM = nil;
        NSArray *array = [PeerHonePageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.currentInt = 20;
        NSMutableArray *arrayM = [NSMutableArray array];
        for (PeerHonePageModel *model in array) {
            self.CellHeight = 103 * BOHeightRate;
            // 添加底部的新手活动和活动
            NSArray *array1 = [model.reg_url componentsSeparatedByString:@"|"];
            NSArray *array2 = model.huodong;
            NSString *string1 = array1.firstObject;
            if (string1.length > 0  && array2.count > 0){
                self.CellHeight += 59 * BOHeightRate;
            }else if (string1.length > 0 || array2.count > 0) {
                self.CellHeight += 43 * BOHeightRate;
            }
            [self.heightArrayM addObject:[NSString stringWithFormat:@"%lf",self.CellHeight]];
            [arrayM addObject:model];
        }
        self.dataArrayM = arrayM;
        [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
#pragma mark - 请求更多数据
- (void)loadMoreData {
    // 取消之前请求
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSString *string = [NSString stringWithFormat:@"%@WdApi/wdList",BASEURL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"start"] = [NSString stringWithFormat:@"%zd",self.currentInt + 1];
    NSLog(@"%zd",self.currentInt);
     self.currentInt += 20;
    parameters[@"limit"] = @"20";
    NSLog(@"%zd",self.currentInt);
    parameters[@"city"] = self.selectCity;
    parameters[@"apr_min"] = self.selectApr_min;
    parameters[@"apr_max"] = self.selectApr_max;
    parameters[@"bus_model"] = self.selectBus_model;
    parameters[@"background"] = self.selectBackground;
    [self.mgr POST:string parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/youjinkeji02/Desktop/data.plist" atomically:YES];
        [self.tableView.mj_footer endRefreshing];
        NSArray *array = [PeerHonePageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        for (PeerHonePageModel *model in array) {
            self.CellHeight = 103 * BOHeightRate;
            // 添加底部的新手活动和活动
            NSArray *array1 = [model.reg_url componentsSeparatedByString:@"|"];
            NSArray *array2 = model.huodong;
            NSString *string1 = array1.firstObject;
            if (string1.length > 0  && array2.count > 0){
                self.CellHeight += 58 * BOHeightRate;
            }else if (string1.length > 0 || array2.count > 0) {
                self.CellHeight += 40 * BOHeightRate;
            }
            [self.heightArrayM addObject:[NSString stringWithFormat:@"%lf",self.CellHeight]];
              NSLog(@"%@",model.name);
            [self.dataArrayM addObject:model];
        }
    
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
#pragma mark - 懒加载选择城市的View
- (PlatformSelectCityView *)plarformSelectCityView {
    if (_plarformSelectCityView == nil) {
        // 创建触发点击事件显示的View
        _plarformSelectCityView = [[PlatformSelectCityView alloc] initWithFrame:CGRectMake(0, 40 * BOScreenW / BOPictureW, BOScreenW, 360 * BOScreenH/ BOPictureH)];
        _plarformSelectCityView.delegate = self;
    }
    return _plarformSelectCityView;
}
#pragma mark - 更改选中的按钮
- (void)changeSelectBtn: (BOLcationButton *)button {
    _selectBtn.selected = NO;
    if (_selectBtn != button) {
        [self setSelectBtn:button];
    }else if (_selectBtn == button) {
        [self.platformNavigationTableView removeFromSuperview];
        [self.coverView removeFromSuperview];
        if (self.plarformSelectCityView != nil) {
            [self.plarformSelectCityView removeFromSuperview];
        }
        self.selectBtn.selected = NO;
        self.selectBtn = nil;
    }
}
- (void)setSelectBtn:(BOLcationButton *)selectBtn {
    _selectBtn = selectBtn;
    _selectBtn.selected = YES;
    
}
#pragma mark - 点击事件添加的tableView和遮盖View的懒加载
- (BOPlatformNavigationTableView *)platformNavigationTableView {
    if (_platformNavigationTableView == nil) {
        _platformNavigationTableView = [[BOPlatformNavigationTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _platformNavigationTableView.dataSource = self;
        _platformNavigationTableView.delegate = self;
        [_platformNavigationTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:backID];
    }
    return _platformNavigationTableView;
}
- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 40 * BOScreenH / BOPictureH, BOScreenW, BOScreenH - 64 - 40 * BOScreenH / BOPictureH)];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.5;
        
        // 添加点按手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
        [_coverView addGestureRecognizer:tapGesture];
    }
    return _coverView;
}
#pragma mark - 年化，业务类型，背景的数据数组，tableVIew的数组的懒加载
- (NSArray *)yearMeltArray {
    if (_yearMeltArray == nil) {
        _yearMeltArray = [NSArray array];
    }
    return _yearMeltArray;
}
- (NSArray *)operationArray {
    if (_operationArray == nil) {
        _operationArray = [NSArray array];
    }
    return _operationArray;
}
- (NSArray *)backArray {
    if (_backArray == nil) {
        _backArray = [NSArray array];
    }
    return _backArray;
}
- (NSArray *)tableViewArray {
    if (_tableViewArray == nil) {
        _tableViewArray = [NSArray array];
    }
    return _tableViewArray;
}
#pragma mark - 设置年化，业务类型，背景的数据数组
- (void)setupDataArray {
    self.yearMeltArray = [NSArray arrayWithObjects:@"全部区间", @"8%以下", @"8%-12%", @"12%-16%", @"16%-20%", @"20%以上", nil];
    self.operationArray = [NSArray arrayWithObjects:@"全部类型", @"车贷", @"消费分期", @"供应链金融", @"房贷", @"企业贷", @"优选理财", @"票据抵押", @"融资租赁", @"藏品质押",@"个人信用贷", nil];
    self.backArray = [NSArray arrayWithObjects:@"全部背景", @"银行系", @"上市系", @"国资系", @"风投系", nil];
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
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"平台导航"];
    self.navigationItem.titleView = titleView;
    // 设置navigationItem的右边按钮
    UIBarButtonItem *rightBtnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"icon_search"] selImage:[UIImage imageNamed:@"icon_search"] target:self action:@selector(rightBtnItemClick)];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
}
#pragma mark - 返回上一级
- (void)backToLevel {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 点击搜索的方法
- (void)rightBtnItemClick {
//    PlatformSearchVC *platformSearchVC = [[PlatformSearchVC alloc] init];
//    [self.navigationController pushViewController:platformSearchVC animated:YES];
    SearchPlatformViewController *searchVc = [[SearchPlatformViewController alloc]init];
    searchVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVc animated:YES];
}
#pragma mark - 设置topView
- (void)setupTopView {
    
    // 创建一个topView
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 40 * BOScreenH / BOPictureH)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    CGFloat btnW = 0.25 * BOScreenW;
    CGFloat btnY = 0;
    CGFloat btnX = 0;
    CGFloat btnH = 40 * BOScreenH / BOPictureH;
    CGFloat viewH = 24 * BOScreenH / BOPictureH;
    // 创建所在地区的按钮
    BOLcationButton *firstBtn = [[BOLcationButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
    [firstBtn addTarget:self action:@selector(firstBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [firstBtn setTitle:@"所在地区 " forState:UIControlStateNormal];
    [firstBtn setImage:[UIImage imageNamed:@"common_icon_xiala"] forState:UIControlStateNormal];
    [firstBtn setImage:[UIImage imageNamed:@"common_icon_xiala_h"] forState:UIControlStateSelected];
    [firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [firstBtn setTitleColor:BOColor(91, 159, 242) forState:UIControlStateSelected];
    firstBtn.tag = 0;
    [firstBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    self.firstBtn = firstBtn;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(firstBtn.frame) - 1, 0.5 * (btnH - viewH), 1, viewH)];
    lineView.backgroundColor = BOColor(235, 236, 237);
    [topView addSubview:lineView];
    // 创建年化的按钮
    BOLcationButton *secondBtn = [[BOLcationButton alloc] initWithFrame:CGRectMake(1 * btnW, btnY, btnW, btnH)];
    [secondBtn addTarget:self action:@selector(secondBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [secondBtn setTitle:@"年化 " forState:UIControlStateNormal];
    [secondBtn setImage:[UIImage imageNamed:@"common_icon_xiala"] forState:UIControlStateNormal];
    [secondBtn setImage:[UIImage imageNamed:@"common_icon_xiala_h"] forState:UIControlStateSelected];
    [secondBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [secondBtn setTitleColor:BOColor(91, 159, 242) forState:UIControlStateSelected];
    [secondBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    secondBtn.tag = 1;
    self.secondBtn = secondBtn;
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(secondBtn.frame) - 1, 0.5 * (btnH - viewH), 1, viewH)];
    lineView2.backgroundColor = BOColor(235, 236, 237);
    [topView addSubview:lineView2];
    // 创建业务类型的按钮
    BOLcationButton *thirdBtn = [[BOLcationButton alloc] initWithFrame:CGRectMake(2 * btnW, btnY, btnW, btnH)];
    [thirdBtn addTarget:self action:@selector(thirdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [thirdBtn setTitle:@"业务类型 " forState:UIControlStateNormal];
    [thirdBtn setImage:[UIImage imageNamed:@"common_icon_xiala"] forState:UIControlStateNormal];
    [thirdBtn setImage:[UIImage imageNamed:@"common_icon_xiala_h"] forState:UIControlStateSelected];
    [thirdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [thirdBtn setTitleColor:BOColor(91, 159, 242) forState:UIControlStateSelected];
    [thirdBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    thirdBtn.tag = 2;
    self.thirdBtn = thirdBtn;
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(thirdBtn.frame) - 1, 0.5 * (btnH - viewH), 1, viewH)];
    lineView3.backgroundColor = BOColor(235, 236, 237);
    [topView addSubview:lineView3];
    // 创建背景的按钮
    BOLcationButton *fourthBtn = [[BOLcationButton alloc] initWithFrame:CGRectMake(3 * btnW, btnY, btnW, btnH)];
    [fourthBtn addTarget:self action:@selector(fourthBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [fourthBtn setTitle:@"背景 " forState:UIControlStateNormal];
    [fourthBtn setImage:[UIImage imageNamed:@"common_icon_xiala"] forState:UIControlStateNormal];
    [fourthBtn setImage:[UIImage imageNamed:@"common_icon_xiala_h"] forState:UIControlStateSelected];
    [fourthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fourthBtn setTitleColor:BOColor(91, 159, 242) forState:UIControlStateSelected];
    [fourthBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    fourthBtn.tag = 3;
    self.fourBtn = fourthBtn;
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(fourthBtn.frame) - 1, 0.5 * (btnH - viewH), 1, viewH)];
    lineView4.backgroundColor = BOColor(235, 236, 237);
    [topView addSubview:lineView4];
    
    [topView addSubview:firstBtn];
    [topView addSubview:secondBtn];
    [topView addSubview:thirdBtn];
    [topView addSubview:fourthBtn];
}
#pragma mark - 处理所在地区，年化，业务类型，背景的按钮点击事件
//处理所在地区按钮的点击事件
- (void)firstBtnClick: (BOLcationButton *)btn {
    // 添加遮盖View
    [self.view addSubview:self.coverView];
    // 添加点击选择城市触发显示的View
    [self.view addSubview:self.plarformSelectCityView];
    [self changeSelectBtn:btn];
}
// 处理年化按钮的点击事件
- (void)secondBtnClick: (BOLcationButton *)btn {
    // 添加遮盖View
    [self.view addSubview:self.coverView];
    // 添加点击事件触发显示的tableView
    [self.view addSubview:self.platformNavigationTableView];
    // 给tableView的数据源数组赋值
    self.tableViewArray = self.yearMeltArray;
    self.platformNavigationTableView.frame = CGRectMake(0, 40 * BOScreenH / BOPictureH, BOScreenW, self.tableViewArray.count * 45 * BOScreenH / BOPictureH);
    [self changeSelectBtn:btn];
    [self.platformNavigationTableView reloadData];
}
// 处理业务类型按钮的点击事件
- (void)thirdBtnClick: (BOLcationButton *)btn {
    // 添加遮盖View
    [self.view addSubview:self.coverView];
    // 添加点击事件触发显示的tableView
    [self.view addSubview:self.platformNavigationTableView];
    // 给tableView的数据源数组赋值
    self.tableViewArray = self.operationArray;
    self.platformNavigationTableView.frame = CGRectMake(0, 40 * BOScreenH / BOPictureH, BOScreenW, self.tableViewArray.count * 45 * BOScreenH / BOPictureH);
    [self changeSelectBtn:btn];
    [self.platformNavigationTableView reloadData];
}
// 处理背景的按钮的点击事件
- (void)fourthBtnClick: (BOLcationButton *)btn {
    // 添加遮盖View
    [self.view addSubview:self.coverView];
    // 添加点击事件触发显示的tableView
    [self.view addSubview:self.platformNavigationTableView];
    // 给tableView的数据源数组赋值
    self.tableViewArray = self.backArray;
    self.platformNavigationTableView.frame = CGRectMake(0, 40 * BOScreenH / BOPictureH, BOScreenW, self.tableViewArray.count * 45 * BOScreenH / BOPictureH);
    [self changeSelectBtn:btn];
    [self.platformNavigationTableView reloadData];
}
#pragma mark - 移除遮盖View和显现的tableView
- (void)removeView {
    [self.platformNavigationTableView removeFromSuperview];
    [self.coverView removeFromSuperview];
    [self changeSelectBtn:_selectBtn];
}
#pragma mark - 设置tabbelView
- (void)setupTableView {
    // 创建tableView，并设置其代理和数据源
    CGFloat tableViewX = 0;
    CGFloat tableViewW = BOScreenW;
    CGFloat tableViewY = 40 * BOScreenH / BOPictureH + 1;
    CGFloat tableViewH = BOScreenH - 64 - 40 * BOScreenH / BOPictureH;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [tableView registerClass:[HotPlatformTableViewCell class] forCellReuseIdentifier:ID];
    tableView.dataSource = self;
    tableView.delegate = self;
}

#pragma mark - 设置tableView的数据源协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([tableView isKindOfClass:[BOPlatformNavigationTableView class]]) {
        return 1;
    }else {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isKindOfClass:[BOPlatformNavigationTableView class]]) {
        return [self.tableViewArray count];
    }else {
        return [self.dataArrayM count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isKindOfClass:[BOPlatformNavigationTableView class]]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:backID forIndexPath:indexPath];
        cell.textLabel.text = self.tableViewArray[indexPath.row];
        [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
        return cell;
    }else {
        HotPlatformTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
        cell.item = self.dataArrayM[indexPath.row];
        cell.clipsToBounds = YES;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isKindOfClass:[BOPlatformNavigationTableView class]]) {
        return 45 * BOScreenH / BOPictureH;
    }
    return [self.heightArrayM[indexPath.row] floatValue];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([tableView isKindOfClass:[BOPlatformNavigationTableView class]]) {
        return 0.001;
    }else {
        return 0.001;
    }
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isKindOfClass:[BOPlatformNavigationTableView class]]) {
        if (self.selectBtn.tag == 0) {
            
        }
        else if (self.selectBtn.tag == 1) {
            if (indexPath.row == 0) {
                self.selectApr_min = @"0";
                self.selectApr_max = @"0";
            }else if (indexPath.row == 1) {
                self.selectApr_min = @"0";
                self.selectApr_max = @"8";
            }else if (indexPath.row == 2) {
                self.selectApr_min = @"8";
                self.selectApr_max = @"12";
            }else if (indexPath.row == 3) {
                self.selectApr_min = @"12";
                self.selectApr_max = @"16";
            }else if (indexPath.row == 3) {
                self.selectApr_min = @"16";
                self.selectApr_max = @"20";
            }else if (indexPath.row == 5) {
                self.selectApr_min = @"20";
                self.selectApr_max = @"50";
            }
            [self.secondBtn setTitle:self.tableViewArray[indexPath.row] forState:UIControlStateNormal];
            // 请求数据
            [self.tableView.mj_header beginRefreshing];
        }
        else if (self.selectBtn.tag == 2) {
            self.selectBus_model = [NSString stringWithFormat:@"%zd",indexPath.row];
            [self.thirdBtn setTitle:self.tableViewArray[indexPath.row] forState:UIControlStateNormal];
            // 请求数据
            [self.tableView.mj_header beginRefreshing];
        }
        else if (self.selectBtn.tag == 3) {
            self.selectBackground = [NSString stringWithFormat:@"%zd",indexPath.row];
            [self.fourBtn setTitle:self.tableViewArray[indexPath.row] forState:UIControlStateNormal];
            // 请求数据
            [self.tableView.mj_header beginRefreshing];
        }
        // 移除按钮点击显示的tableView和遮盖View
        [self.platformNavigationTableView removeFromSuperview];
        [self.coverView removeFromSuperview];
        [self changeSelectBtn:_selectBtn];
    }else {
        HotdetailsViewController *hotdetailsViewController = [[HotdetailsViewController alloc] init];
        PeerHonePageModel *item = self.dataArrayM[indexPath.row];
        hotdetailsViewController.ptid =item.ptid;
        hotdetailsViewController.nameOfPlatform = item.name;
        [self.navigationController pushViewController:hotdetailsViewController animated:YES];
    }
    
}

#pragma mark - PlatformSelectCityViewDelegate
- (void)platformSelectCityViewSelectCity:(NSString *)selectCIty cityNumber:(NSString *)cityNumber{
    // 移除遮盖View
    [self.coverView removeFromSuperview];
    
    [self.plarformSelectCityView removeFromSuperview];
    [self.selectBtn setTitle:selectCIty forState:UIControlStateNormal];
    [self.selectBtn setTitle:selectCIty forState:UIControlStateSelected];
    self.selectCity = cityNumber;
    // 请求数据
    [self.tableView.mj_header beginRefreshing];
    self.selectBtn.selected = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
