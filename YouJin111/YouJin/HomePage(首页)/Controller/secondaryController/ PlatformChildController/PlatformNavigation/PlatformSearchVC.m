//
//  PlatformSearchVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/11.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformSearchVC.h"
#import "PeerHonePageModel.h"
#import "HotdetailsViewController.h"
#import "HotSearchModel.h"
#import "HotSearchButton.h"
#import "PlatformSearchCell.h"
#import <MJRefresh/MJRefresh.h>
static NSString *const ID = @"cell";
static NSString *const cellId = @"cellID";
@interface PlatformSearchVC ()<UISearchBarDelegate,UITableViewDelegate, UITableViewDataSource>

/**搜索之后的tableView*/
@property (nonatomic, strong) UITableView *searchTableView;

/**没有搜索到结果的view*/
@property (nonatomic, strong) UIView *notSearchResultView;

/**搜索的结果数组*/
@property (nonatomic, strong) NSMutableArray *searchArrayM;

/**热门平台的数组*/
@property (nonatomic, strong) NSMutableArray *hotArrayM;

/**底部的bottomTableView*/
@property (nonatomic, weak) UITableView *bottomTableView;
@property (nonatomic, weak) AFHTTPSessionManager *mgr;

@property (nonatomic, weak) UISearchBar *searchBar;

/**保存热门搜索按钮的数组*/
@property (nonatomic, strong) NSMutableArray *btnArrayM;

/**保存搜索框当前的字符串*/
@property (nonatomic, copy) NSString *searchString;
@end

@implementation PlatformSearchVC
#pragma mark - 懒加载
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}
- (NSMutableArray *)btnArrayM {
    if (_btnArrayM == nil) {
        _btnArrayM = [NSMutableArray array];
    }
    return _btnArrayM;
}
- (NSMutableArray *)searchArrayM {
    if (_searchArrayM == nil) {
        _searchArrayM = [NSMutableArray array];
    }
    return _searchArrayM;
}
- (NSMutableArray *)hotArrayM {
    if (_hotArrayM == nil) {
        _hotArrayM = [NSMutableArray array];
    }
    return _hotArrayM;
}
- (UITableView *)searchTableView {
    if (_searchTableView == nil) {
        _searchTableView = [[UITableView alloc] init];
        _searchTableView.frame = CGRectMake(0, 0, BOScreenW, BOScreenH - 64);
        _searchTableView.tag = 10;
        _searchTableView.delegate = self;
        _searchTableView.dataSource = self;
        _searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        // 添加上拉加载
//        [self setupRefreshVeiw];
    }
    return _searchTableView;
}
- (UIView *)notSearchResultView {
    if (_notSearchResultView == nil) {
        _notSearchResultView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH - 64)];
        _notSearchResultView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        // 添加imageView
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((BOScreenW - 130 * BOWidthRate) * 0.5, 172 * BOHeightRate, 130 * BOWidthRate, 130 * BOHeightRate)];
        imageView.image = [UIImage imageNamed:@"img_e"];
        [_notSearchResultView addSubview:imageView];
        // 添加label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 332 * BOHeightRate, BOScreenW, 15 * BOHeightRate)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"没有找到相关的平台,搜其他平台试试吧";
        [label setFont:[UIFont systemFontOfSize:13]];
        [label setTextColor:[UIColor colorWithHexString:@"#999999" alpha:1]];
        [_notSearchResultView addSubview:label];
    }
    return _notSearchResultView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    // 设置导航条
    [self setupNavaogationBar];
    [self requstNetData];
    // 注册cell
    [self.searchTableView registerClass:[PlatformSearchCell class] forCellReuseIdentifier:ID];
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.searchBar resignFirstResponder];
}
#pragma mark - 设置导航条
- (void)setupNavaogationBar {

    // 中间view
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor clearColor];
    contentView.frame = CGRectMake(0, 0, 300 * BOScreenW / BOPictureW, 44);
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 8, 300 * BOScreenW / BOPictureW, 29)];
    self.searchBar = searchBar;
    searchBar.showsCancelButton = NO;
    searchBar.delegate = self;
    searchBar.searchBarStyle = UISearchBarStyleDefault;
    searchBar.placeholder = @"请输入平台名称                                       ";
    UIImage *backImage = [UIImage imageWithAlpha:0.05];
    searchBar.backgroundImage = backImage;
    // 设置搜索框的圆角半径
    searchBar.layer.cornerRadius = 14.5;
    searchBar.layer.masksToBounds = YES;
    searchBar.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:searchBar];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = btnItem;
    
    // 设置取消按钮
    UIBarButtonItem *rightCancleItem = [UIBarButtonItem btnWithImage:nil title:@"取消" titleColor:[UIColor whiteColor] target:self action:@selector(closeCurrentPage)];
    self.navigationItem.rightBarButtonItem = rightCancleItem;
}
#pragma mark - 关闭当前界面
- (void)closeCurrentPage {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 添加上拉加载更多，和下拉刷新
- (void)setupRefreshVeiw
{
    // 上拉刷新
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requstMoreData)];
    
    // 自动根据有无数据，判断上拉控件是否完全显示
    footer.automaticallyHidden = YES;
    self.searchTableView.mj_footer = footer;
}

#pragma mark - 请求主页的数据
- (void)requstNetData {
    // 取消之前请求
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 请求数据
    NSString *string = [NSString stringWithFormat:@"%@Common/getHotPt",BASEURL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    __weak typeof(self) weakSelf = self;
    [self.mgr POST:string parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.hotArrayM = [HotSearchModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        // 添加头部控件
        [weakSelf setupTopView];
        // 添加尾部控件
        [weakSelf setupBottomView];
        [weakSelf.bottomTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
#pragma mark - 设置头部的View
- (void)setupTopView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 235 * BOHeightRate)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    //添加热门搜索label
    UILabel *searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * BOWidthRate, 15 * BOHeightRate, 90 * BOWidthRate, 15 * BOHeightRate)];
    [searchLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
    searchLabel.text = @"热门搜索";
    searchLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    [topView addSubview:searchLabel];
    if (self.hotArrayM.count) {
        for (NSInteger i = 0; i < self.hotArrayM.count; i++) {
            HotSearchModel *item = self.hotArrayM[i];
            // 行
            NSInteger line = i / 3;
            // 列
            NSInteger row = i % 3;
            
            HotSearchButton *button = [[HotSearchButton alloc] initWithFrame:CGRectMake(row * 0.333 * BOScreenW,40* BOHeightRate + line * 105 * BOHeightRate, 0.333 * BOScreenW, 85 * BOHeightRate)];
            button.tag = i;
            [button.shopImageV sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:perchImage];
            button.shopLabel.text = item.name;
            [self.btnArrayM addObject:button];
            [button addTarget:self action:@selector(HotBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [topView addSubview:button];
        }
        
    }
}
#pragma mark - 热门搜索按钮的点击事件
- (void)HotBtnClick:(UIButton *)btn {
    HotdetailsViewController *hotDetailVc = [[HotdetailsViewController alloc]init];
    PeerHonePageModel *item = self.hotArrayM[btn.tag];
    hotDetailVc.ptid = item.ptid;
    [self.navigationController pushViewController:hotDetailVc animated:YES];
}
#pragma mark - 设置bottomView
- (void)setupBottomView {
    // 创建包裹历史搜索label的view
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(0, 243 * BOHeightRate, BOScreenW, 40 * BOHeightRate)];
    middleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: middleView];
    // 添加历史搜索的label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15 * BOWidthRate, 12.5 * BOHeightRate, 90 * BOWidthRate, 15 * BOHeightRate)];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
    label.text = @"历史搜索";
    label.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    [middleView addSubview:label];
    // 添加底部的tableView
    UITableView *bottomTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 284 * BOHeightRate, BOScreenW, 160 * BOHeightRate)];
    bottomTableView.delegate = self;
    bottomTableView.dataSource = self;
    bottomTableView.tag = 11;
    bottomTableView.scrollEnabled = NO;
    self.bottomTableView = bottomTableView;
    [self.view addSubview:bottomTableView];
    
    // 添加最下部的清除记录button
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake((BOScreenW - 98) * 0.5, 488 * BOHeightRate, 98 * BOWidthRate, 31 * BOHeightRate)];
    deleteBtn.layer.cornerRadius = 5 * BOWidthRate;
    deleteBtn.layer.masksToBounds = YES;
    deleteBtn.layer.borderColor = [UIColor colorWithHexString:@"#B3B3B3" alpha:1].CGColor;
    deleteBtn.layer.borderWidth = 1;
    [deleteBtn setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
    [deleteBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [deleteBtn setTitle:@"清除记录" forState:UIControlStateNormal];
    [deleteBtn setImage:[UIImage imageNamed:@"icon_del"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
    if(self.hotArrayM.count)
    {
        
    }else
    {
        
    }
}
//清除记录的点击事件
- (void)deleteBtnClick
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"myArray"];
//    return myArray;

    NSMutableArray *searTXT = [myArray mutableCopy];
    [searTXT removeAllObjects];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:searTXT forKey:@"myArray"];
    
//    [self.hotArrayM removeAllObjects];
    [self.bottomTableView reloadData];
}
#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.searchString = searchText;
    if (searchText.length > 0) {
        [self SearchText:searchText];
    }
    
    // 取消之前请求
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 请求数据
    NSString *string = [NSString stringWithFormat:@"%@WdApi/wdList",BASEURL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = @"20";
    parameters[@"name"] = searchText;
    [self.mgr POST:string parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.searchArrayM = [PeerHonePageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (self.searchArrayM.count) {
            [self.view addSubview:self.searchTableView];
            [self.notSearchResultView removeFromSuperview];
        }else {
            [self.view addSubview:self.notSearchResultView];
            [self.searchTableView removeFromSuperview];
        }
        [self.searchTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}
#pragma mark - 加载更多数据
- (void)requstMoreData {
    // 取消之前请求
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 请求数据
    NSString *string = [NSString stringWithFormat:@"%@WdApi/wdList",BASEURL];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"start"] = [NSString stringWithFormat:@"%zd",self.hotArrayM.count];
    parameters[@"limit"] = @"20";
    parameters[@"name"] = self.searchString;
    [self.mgr POST:string parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = [PeerHonePageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        for (PeerHonePageModel *item in array) {
            [self.searchArrayM addObject:item];
        }
        if (self.searchArrayM.count) {
            [self.view addSubview:self.searchTableView];
            [self.notSearchResultView removeFromSuperview];
            [self.searchTableView.mj_footer endRefreshing];

        }else {
            [self.view addSubview:self.notSearchResultView];
            [self.searchTableView removeFromSuperview];
        }
        [self.searchTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 10) {
        return self.searchArrayM.count;
    }
    return [self readNSUserDefaults].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 10) {
        PeerHonePageModel *model = self.searchArrayM[indexPath.row];
        PlatformSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:perchImage];
        [cell.textLabel setFont:[UIFont systemFontOfSize:17]];
        cell.textLabel.text = model.name;
        return cell;
 
    }
    UITableViewCell *cell;
    if ([self readNSUserDefaults].count > 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        cell.textLabel.text = [self readNSUserDefaults][indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 10) {
         return 70 * BOHeightRate;
    }
    return 40 * BOHeightRate;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 10) {
        HotdetailsViewController *hotDetailVc = [[HotdetailsViewController alloc]init];
        PeerHonePageModel *item = self.searchArrayM[indexPath.row];
        hotDetailVc.ptid = item.ptid;
        [self.navigationController pushViewController:hotDetailVc animated:YES];
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}
#pragma mark - 保存历史记录
-(void)SearchText :(NSString *)seaTxt
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"myArray"];
    // NSArray --> NSMutableArray
    self.hotArrayM = [myArray mutableCopy];
//    [searTXT addObject:seaTxt];
    [self.hotArrayM insertObject:seaTxt atIndex:0];
    if(self.hotArrayM.count > 4)
    {
        [self.hotArrayM removeObjectAtIndex:4];
    }
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.hotArrayM forKey:@"myArray"];
    [self.bottomTableView reloadData];
}
#pragma mark - 读取历史记录
-(NSArray *)readNSUserDefaults
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"myArray"];
    return myArray;
}
@end
