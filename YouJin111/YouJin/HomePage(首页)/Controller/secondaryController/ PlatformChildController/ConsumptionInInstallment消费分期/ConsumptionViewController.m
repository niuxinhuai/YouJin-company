//
//  ConsumptionViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "ConsumptionViewController.h"
#import "TerraceTableViewCell.h"
#import "ConsumptionFq.h"
#import "HotdetailsViewController.h"
#import "BannerWebViewViewController.h"

static NSString *const selectID = @"selectID";
@interface ConsumptionViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *basaScrView;
@property (nonatomic ,strong)UITableView *terraceTableView;
@property (nonatomic, strong) SDCycleScrollView *bannerCycleView;
@property (nonatomic, strong)NSMutableArray *bannerResultArr;//banner图片 接口数据存放数组
@property (nonatomic, strong)NSMutableArray *bannerURlArr;//logoURL
@property (nonatomic, strong)NSMutableArray *resultArr;//接受数据的结果数组
@property (nonatomic ,assign)int intNumber;//记录当前的数据条数
@property (nonatomic ,strong)NSMutableArray *jumpUrlArr;//banner跳转url
@property (nonatomic ,strong)NSMutableArray *goTypeArr;//判断banner是否能跳转
@property (nonatomic ,strong)NSMutableArray *ptidArr;//banner跳转ptid

/**标记是否处于筛选状态*/
@property (nonatomic, assign) int flag;

/**引用热门分期筛选的hotTerraceView*/
@property (nonatomic, weak) UIView *hotTerraceView;

/**点击筛选弹出的selectTableView*/
@property (nonatomic, strong) UITableView *selectTableView;

/**点击筛选的数组*/
@property (nonatomic, strong) NSArray *selectArray;

/**点击筛选后的遮盖View*/
@property (nonatomic, strong) UIView *coverView;
//筛选点击了那一行
@property (nonatomic ,copy)NSString *screeningIndexPathRow;
@end

@implementation ConsumptionViewController

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
        _selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40 * BOHeightRate, BOScreenW, 45 * 9 * BOHeightRate)];
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
        _selectTableView.scrollEnabled = NO;
        _selectTableView.tag = 6;
    }
    return _selectTableView;
}
- (NSArray *)selectArray {
    if (_selectArray == nil) {
        _selectArray = [NSArray arrayWithObjects:@"全部类型",@"汽车分期 ",@"租房分期",@"信用分期",@"购物分期",@"校园分期",@"教育分期",@"旅游分期",@"装修分期", nil];
    }
    return _selectArray;
}

-(NSMutableArray *)bannerResultArr
{
    if (_bannerResultArr == nil)
    {
        _bannerResultArr = [NSMutableArray array];
    }
    return _bannerResultArr;
}
-(NSMutableArray *)resultArr
{
    if (_resultArr == nil)
    {
        _resultArr = [NSMutableArray array];
    }
    return _resultArr;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _ptidArr = [NSMutableArray array];
    _jumpUrlArr = [NSMutableArray array];
    _goTypeArr = [NSMutableArray array];
    // 初始筛选的标记值为0
    self.flag = 0;
    
    _bannerURlArr = [NSMutableArray array];
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"消费分期"];
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    //底部滑动的scr
    _basaScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    _basaScrView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _basaScrView.showsVerticalScrollIndicator = NO;
//    _basaScrView.contentSize = CGSizeMake(BOScreenW, 301*BOScreenH/1334 + 216*BOScreenH/1334*10 + 10*BOScreenH/1334*12+48);
    [self.view addSubview:_basaScrView];
    [self bannerView];
    //创建热门分期平台的view
    [self creatHotTerraceView];
    //创建tableview
    _terraceTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 300*BOScreenH/1334, BOScreenW, 0) style:UITableViewStylePlain];
    _terraceTableView.delegate = self;
    _terraceTableView.dataSource = self;
    _terraceTableView.scrollEnabled = NO;
    [_basaScrView addSubview:_terraceTableView];
    // 注册cell
    [self.selectTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:selectID];
    [self mjRefreshTheLoad];//下拉刷新上拉加载
    [self bannerData];//banner的数据接口
    [self tableViewData];//tableview的数据接口
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
    self.basaScrView.mj_header = header;
    
    // 上拉加载
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDatas)];
    // 自动根据有无数据，判断上拉控件是否完全显示
    footer.automaticallyHidden = YES;
    footer.stateLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    self.basaScrView.mj_footer = footer;
}
//下拉刷新
- (void)refresh
{
    [self tableViewData];
    [self.basaScrView.mj_header endRefreshing];
}
//上拉加载
- (void)loadMoreDatas
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = [NSString stringWithFormat:@"%d",self.intNumber + 20];
    parameters[@"xiaofei_type"] = _screeningIndexPathRow;
    self.intNumber += 10;
    [manager POST:[NSString stringWithFormat:@"%@WdApi/xiaofeiPtList",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            self.resultArr = [ConsumptionFq mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            self.terraceTableView.frame = CGRectMake(0, 300*BOScreenH/1334, BOScreenW, 216*BOScreenH/1334*self.resultArr.count + 10*BOScreenH/1334*(self.resultArr.count));
            [_terraceTableView reloadData];
            self.basaScrView.contentSize = CGSizeMake(BOScreenW,CGRectGetMaxY(self.terraceTableView.frame)+20);
            [self.basaScrView.mj_footer endRefreshing];
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}

#pragma mark---建banner轮播图----
- (void)bannerView
{
    SDCycleScrollView *cycleScr = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BOScreenW, 220*BOScreenH/1334)  delegate:self placeholderImage:[UIImage imageNamed:@"img_loadingb"]];
    cycleScr.imageURLStringsGroup = _bannerURlArr;
    cycleScr.autoScrollTimeInterval = 4;
    cycleScr.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    [_basaScrView addSubview:cycleScr];
    self.bannerCycleView = cycleScr;
}
#pragma mark---创建热门分期平台的view---
- (void)creatHotTerraceView
{
    UIView *hotTerraceView = [[UIView alloc]initWithFrame:CGRectMake(0, 220*BOScreenH/1334, BOScreenW, 80*BOScreenH/1334)];
    self.hotTerraceView = hotTerraceView;
    hotTerraceView.backgroundColor = [UIColor whiteColor];
    [_basaScrView addSubview:hotTerraceView];
    //热门分期平台前面的蓝色
    UILabel *blueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 23*BOScreenH/1334, 10*BOScreenW/750, 34*BOScreenH/1334)];
    blueLabel.backgroundColor = [UIColor colorWithRed:70/255.0 green:151/255.0 blue:251/255.0 alpha:1];
    [hotTerraceView addSubview:blueLabel];
    //热门分期平台
    UILabel *toolsLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 400*BOScreenW/750, 30*BOScreenH/1334)];
    toolsLabel.text = @"热门分期平台";
    [toolsLabel setFont:[UIFont systemFontOfSize:15.0]];
    toolsLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [hotTerraceView addSubview:toolsLabel];
    //筛选
    UIButton *screenOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    screenOutBtn.frame = CGRectMake(BOScreenW - 120*BOScreenW/750, 30*BOScreenH/1334, 100*BOScreenW/750, 20*BOScreenH/1334);
    [screenOutBtn setImage:[UIImage imageNamed:@"icon_shuaxuan"] forState:UIControlStateNormal];
    [screenOutBtn setTitle:@" 筛选" forState:UIControlStateNormal];
    [screenOutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [screenOutBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [screenOutBtn addTarget:self action:@selector(screenOutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [hotTerraceView addSubview:screenOutBtn];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 79*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
    [hotTerraceView addSubview:lineView];
}
#pragma mark---筛选的点击事件----
- (void)screenOutBtnClick
{
    [self.view addSubview:self.coverView];
    self.flag = 1;
    self.hotTerraceView.frame = CGRectMake(0, 0, BOScreenW, 80*BOScreenH/1334);
    [self.view addSubview:self.hotTerraceView];
    [self.view addSubview:self.selectTableView];
}
#pragma mark - 点击遮盖View的处理事件
- (void)coverViewClick {
    self.flag = 0;
    [self.selectTableView removeFromSuperview];
    [self.coverView removeFromSuperview];
    self.hotTerraceView.frame = CGRectMake(0, 220*BOScreenH/1334, BOScreenW, 80*BOScreenH/1334);
    [self.basaScrView addSubview:self.hotTerraceView];
}

#pragma mark---tableview的数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 6) {
        return self.selectArray.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 6) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selectID forIndexPath:indexPath];
        cell.textLabel.text = self.selectArray[indexPath.row];
        [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
        //点击后的阴影效果
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }

    static NSString *cellString = @"cell";
    TerraceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[TerraceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.item = self.resultArr[indexPath.section];
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 6) {
        return 45 * BOHeightRate;
    }
    return 216*BOScreenH/1334;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.001;
    }
    return 10*BOScreenH/1334;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 6) {
        return 1;
    }
    return _resultArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 6) {
        [self.selectTableView removeFromSuperview];
        [self.coverView removeFromSuperview];
        self.hotTerraceView.frame = CGRectMake(0, 110 * BOScreenH / BOPictureH, BOScreenW, 40 * BOScreenH / BOPictureH);
        [self.basaScrView addSubview:self.hotTerraceView];
        _screeningIndexPathRow = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        [self tableViewData];
        [_terraceTableView reloadData];
    }else
    {
        HotdetailsViewController *hotDetailVc = [[HotdetailsViewController alloc]init];
        ConsumptionFq *item = self.resultArr[indexPath.section];
        hotDetailVc.ptid = item.ptid;
        hotDetailVc.xffqlxStr = item.type;
        hotDetailVc.nameOfPlatform = item.name;
        hotDetailVc.xffqString = @"xiaofeifenqiPage";
        [self.navigationController pushViewController:hotDetailVc animated:YES];
    }
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    if (self.flag == 0) {
         [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self.selectTableView removeFromSuperview];
        [self.coverView removeFromSuperview];
        self.hotTerraceView.frame = CGRectMake(0, 110 * BOScreenH / BOPictureH, BOScreenW, 40 * BOScreenH / BOPictureH);
        [self.basaScrView addSubview:self.hotTerraceView];

        self.flag = 0;
    }
}
#pragma mark---tableView的数据接口----
- (void)tableViewData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = @"10";
    parameters[@"xiaofei_type"] = _screeningIndexPathRow;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@WdApi/xiaofeiPtList",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            self.resultArr = [ConsumptionFq mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            self.terraceTableView.frame = CGRectMake(0, 300*BOScreenH/1334, BOScreenW, 216*BOScreenH/1334*self.resultArr.count + 10*BOScreenH/1334*(self.resultArr.count));
            [_terraceTableView reloadData];
             self.basaScrView.contentSize = CGSizeMake(BOScreenW,CGRectGetMaxY(self.terraceTableView.frame)+20);
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
#pragma mark---bannner的数据接口----
- (void)bannerData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@WdApi/xiaofeiBannerList",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]])
        {
            NSLog(@"返回数据类型为%@",(NSArray *)responseObject);
        }else
        {
//            NSLog(@"444444%@",responseObject);
            if ([responseObject[@"r"] integerValue] == 1)
            {
                if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
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
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if ([_goTypeArr[index] intValue] == 1)
    {
//        NSLog(@"不跳转");
        if (_jumpUrlArr && ![_jumpUrlArr isKindOfClass:[NSNull class]])
        {
            BannerWebViewViewController *bannerWebVc = [[BannerWebViewViewController alloc]init];
            bannerWebVc.url = _jumpUrlArr[0];
            bannerWebVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:bannerWebVc animated:YES];
        }
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
@end
