//
//  SearchPlatformViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/6/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "SearchPlatformViewController.h"
#import "SearchHistoryTableViewCell.h"
#import "PtSearchModel.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "HotdetailsViewController.h"
#import "PtDaohangTableViewCell.h"
#import "PtDaohangModel.h"

@interface SearchPlatformViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UISearchBar *searchBar;//搜索
@property (nonatomic ,strong)UITableView *historicalTableView;//搜索展示页
@property (nonatomic ,strong)UIView *zeroView;//第零区的view
@property (nonatomic ,strong)UIView *firstView;//第一区的view
@property (nonatomic ,strong)UIView *thirdView;//第三区的view
@property (nonatomic ,assign)CGFloat  thirdheight;
@property (nonatomic ,strong)UIButton *deleteButton;
//热门搜索平台
@property (nonatomic ,strong)NSMutableArray *hotResultArr;
@property (nonatomic ,strong)NSMutableArray *logoArrs;
@property (nonatomic ,strong)NSMutableArray *nameArrs;
@property (nonatomic ,strong)NSMutableArray *ptidArrs;
//平台导航
@property (nonatomic ,strong)NSMutableArray *dhResultArr;
@property (nonatomic ,strong)UITableView *daohangTableview;
////没有找到相关平台的view
@property (nonatomic ,strong)UIView *dontView;
//热门平台的数组
@property (nonatomic, strong)NSMutableArray *hotArrayM;
@property (nonatomic ,assign)BOOL lishijilu;
@end

@implementation SearchPlatformViewController
- (NSMutableArray *)dhResultArr
{
    if (_dhResultArr == nil)
    {
        _dhResultArr = [NSMutableArray array];
    }
    return _dhResultArr;
}
- (NSMutableArray *)hotResultArr
{
    if (_hotResultArr == nil)
    {
        _hotResultArr = [NSMutableArray array];
    }
    return _hotResultArr;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _logoArrs = [NSMutableArray array];
    _nameArrs = [NSMutableArray array];
    _ptidArrs = [NSMutableArray array];
    [self setupNavaogationBar];//设置导航条
    _historicalTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64)style:UITableViewStylePlain];
    _historicalTableView.delegate = self;
    _historicalTableView.dataSource = self;
    _historicalTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_historicalTableView];
//    [self theZerothView];//第零区的view
    [self theFirstView];//第一区的view
    [self theThirdView];//第三区的view
    //平台导航
    _daohangTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64) style:UITableViewStyleGrouped];
    _daohangTableview.delegate = self;
    _daohangTableview.dataSource = self;
    _daohangTableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_daohangTableview];
    _daohangTableview.hidden = YES;
    [self couldNotFindPTView];//没有找到相关平台的view
    _dontView.hidden = YES;
    //第一次进来判断有无历史记录
    if ([self readNSUserDefaults].count == 0)
    {
        _deleteButton.hidden = YES;
        _thirdheight = 0.001;
        [_historicalTableView reloadData];
    }else
    {
        _deleteButton.hidden = NO;
        _thirdheight = 240*BOScreenH/1334;
        [_historicalTableView reloadData];
    }

    [self topSearchPTData];//热门搜索平台接口
}
//没有找到相关平台的view
- (void)couldNotFindPTView
{
    _dontView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64)];
    _dontView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    [self.view addSubview:_dontView];
    //添加imageView
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((BOScreenW - 130 * BOWidthRate) * 0.5, 172 * BOHeightRate, 130 * BOWidthRate, 130 * BOHeightRate)];
    imageView.image = [UIImage imageNamed:@"img_e"];
    [_dontView addSubview:imageView];
    //添加label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 332 * BOHeightRate, BOScreenW, 15 * BOHeightRate)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"没有找到相关的平台,搜其他平台试试吧";
    [label setFont:[UIFont systemFontOfSize:13]];
    [label setTextColor:[UIColor colorWithHexString:@"#999999" alpha:1]];
    [_dontView addSubview:label];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _daohangTableview)
    {
        return 1;
    }
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _daohangTableview)
    {
        return self.dhResultArr.count;
    }
    if (section == 2)
    {
        return [self readNSUserDefaults].count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _daohangTableview)
    {
        return 0.001;
    }
    if (section == 0)
    {
        return 470*BOScreenH/1334;
    }else if (section == 1)
    {
        return 96*BOScreenH/1334;
    }else if (section == 2)
    {
        return 0;
    }
    return _thirdheight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == _daohangTableview)
    {
        return 0.001;
    }
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _daohangTableview)
    {
        return 140*BOScreenH/1334;
    }
    return 80*BOScreenH/1334;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _daohangTableview)
    {
        static NSString *cellString = @"cell";
        PtDaohangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
        if (cell == nil)
        {
            cell = [[PtDaohangTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
        cell.item = self.dhResultArr[indexPath.row];
        //点击后的阴影效果
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    static NSString *cellString = @"cell";
    SearchHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[SearchHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.historyLabel.text = [self readNSUserDefaults][indexPath.row];
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _daohangTableview)
    {
        return nil;
    }
    if (section == 0)
    {
        return _zeroView;
    }else if (section == 1)
    {
        return _firstView;
    }else if (section == 2)
    {
        return nil;
    }
    return _thirdView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _daohangTableview)
    {
        [_searchBar resignFirstResponder];
        PtDaohangTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        HotdetailsViewController *commVc = [[HotdetailsViewController alloc]init];
        commVc.hidesBottomBarWhenPushed = YES;
        commVc.ptid = cell.item.ptid;
        [self.navigationController pushViewController:commVc animated:YES];
    }
    _lishijilu = YES;
    _searchBar.text = [self readNSUserDefaults][indexPath.row];
    [self searchBar:_searchBar textDidChange:[self readNSUserDefaults][indexPath.row]];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
}
//第零区的view
- (void)theZerothView
{
    _zeroView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 470*BOScreenH/1334)];
    _zeroView.backgroundColor = [UIColor whiteColor];
    UILabel *hotLable = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 300*BOScreenW/750, 40*BOScreenH/1334)];
    hotLable.text = @"热门搜索";
    hotLable.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    [hotLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    [_zeroView addSubview:hotLable];
    for (int i = 0; i < self.hotResultArr.count; i ++)
    {
        int j = i%3;
        int k = i/3;
        UIButton *logoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        logoButton.frame = CGRectMake(75*BOScreenW/750+j*(100*BOScreenW/750+150*BOScreenW/750), 80*BOScreenH/1334+(100*BOScreenW/750+110*BOScreenH/1334)*k, 100*BOScreenW/750, 100*BOScreenW/750);
        logoButton.tag = i;
        [logoButton sd_setBackgroundImageWithURL:[NSURL URLWithString:_logoArrs[i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
        logoButton.layer.cornerRadius = 8;
        logoButton.layer.masksToBounds = YES;
        [logoButton addTarget:self action:@selector(logoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_zeroView addSubview:logoButton];
        
        UILabel *ptNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(25*BOScreenW/750+j*(200*BOScreenW/750+50*BOScreenW/750), 200*BOScreenH/1334+(40*BOScreenW/750+170*BOScreenH/1334)*k, 200*BOScreenW/750, 40*BOScreenH/1334)];
        ptNameLabel.text = _nameArrs[i];
        ptNameLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [ptNameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
        ptNameLabel.textAlignment = NSTextAlignmentCenter;
        [_zeroView addSubview:ptNameLabel];
    }
}
//logo的点击事件
- (void)logoButtonClick:(UIButton *)sender
{
    [_searchBar resignFirstResponder];
    HotdetailsViewController *hotdetaiVc = [[HotdetailsViewController alloc]init];
    hotdetaiVc.hidesBottomBarWhenPushed = YES;
    hotdetaiVc.ptid = _ptidArrs[sender.tag];
    [self.navigationController pushViewController:hotdetaiVc animated:YES];
}
//第一区的view
- (void)theFirstView
{
    _firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 96*BOScreenH/1334)];
    _firstView.backgroundColor = [UIColor whiteColor];
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 16*BOScreenH/1334)];
    grayView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    [_firstView addSubview:grayView];
    UIView *historyview = [[UIView alloc]initWithFrame:CGRectMake(0, 16*BOScreenH/1334, BOScreenW, 80*BOScreenH/1334)];
    historyview.backgroundColor = [UIColor whiteColor];
    [_firstView addSubview:historyview];
    UILabel *historylable = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 41*BOScreenH/1334, 300*BOScreenW/750, 40*BOScreenH/1334)];
    historylable.text = @"历史搜索";
    historylable.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    [historylable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    [_firstView addSubview:historylable];
}
//第三区的view
- (void)theThirdView
{
    _thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 240*BOScreenH/1334)];
    _thirdView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    //清空记录
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteButton.frame = CGRectMake(275*BOScreenW/750, 90*BOScreenH/1334, 200*BOScreenW/750, 60*BOScreenH/1334);
    [_deleteButton setTitle:@"清空记录" forState:UIControlStateNormal];
    [_deleteButton setImage:[UIImage imageNamed:@"icon_del"] forState:UIControlStateNormal];
    [_deleteButton setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
    _deleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _deleteButton.layer.borderWidth = 1;
    _deleteButton.layer.borderColor = [UIColor colorWithHexString:@"#999999" alpha:1].CGColor;
    _deleteButton.layer.cornerRadius = 5;
    _deleteButton.layer.masksToBounds = YES;
    [_deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_thirdView addSubview:_deleteButton];
}
//清空记录的点击事件
- (void)deleteButtonClick
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSArray *myArray = [userDefaultes arrayForKey:@"myArray"];

    NSMutableArray *searTXT = [myArray mutableCopy];
    [searTXT removeAllObjects];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:searTXT forKey:@"myArray"];
    
    _thirdheight = 0.001;
    _deleteButton.hidden = YES;
    [self.historicalTableView reloadData];
}
#pragma mark - 设置导航条
- (void)setupNavaogationBar
{
    // 中间view
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor clearColor];
    contentView.frame = CGRectMake(0, 0, 300 * BOScreenW / BOPictureW, 44);
    //搜索
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 8, 300 * BOScreenW / BOPictureW, 29)];
    _searchBar.showsCancelButton = NO;
    _searchBar.delegate = self;
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.placeholder = @"请输入平台名称                                       ";
    UIImage *backImage = [UIImage imageWithAlpha:0.05];
    _searchBar.backgroundImage = backImage;
    _searchBar.layer.cornerRadius = 14.5;
    _searchBar.layer.masksToBounds = YES;
    _searchBar.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:_searchBar];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = btnItem;
    // 设置取消按钮
    UIBarButtonItem *rightCancleItem = [UIBarButtonItem btnWithImage:nil title:@"取消" titleColor:[UIColor whiteColor] target:self action:@selector(closeCurrentPage)];
    self.navigationItem.rightBarButtonItem = rightCancleItem;
}
#pragma mark----取消按钮的点击事件---
- (void)closeCurrentPage
{
    [_searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
//搜索的代理方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.dhResultArr removeAllObjects];
    [_daohangTableview reloadData];
    if (searchText.length > 0)
    {
        if (_lishijilu)
        {
        }else
        {
            [self SearchText:searchText];
        }
        _daohangTableview.hidden = NO;
        //平台导航
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"at"] = tokenString;
        parameters[@"start"] = @"0";
        parameters[@"limit"] = @"50";
        parameters[@"name"] = searchText;
        [manager POST:[NSString stringWithFormat:@"%@WdApi/wdList",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"r"] integerValue] == 1)
            {
                self.dhResultArr = [PtDaohangModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [_daohangTableview reloadData];
                if (self.dhResultArr.count == 0)
                {
                    _daohangTableview.hidden = YES;
                    _dontView.hidden = NO;
                }else
                {
                    _daohangTableview.hidden = NO;
                    _dontView.hidden = YES;
                }
                _lishijilu = NO;
            }
            else
            {
                NSLog(@"返回信息描述%@",responseObject[@"msg"]);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败%@",error);
        }];
    }else
    {
        _daohangTableview.hidden = YES;
        _dontView.hidden = YES;
    }
}
//热门搜索平台接口
- (void)topSearchPTData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    [manager POST:[NSString stringWithFormat:@"%@Common/getHotPt",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            self.hotResultArr = [PtSearchModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (PtSearchModel *ptmodel in self.hotResultArr)
            {
                [_logoArrs addObject:ptmodel.logo];
                [_nameArrs addObject:ptmodel.name];
                [_ptidArrs addObject:ptmodel.ptid];
            }
            [self theZerothView];//第零区的view
            [_historicalTableView reloadData];
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
#pragma mark - 保存历史记录
-(void)SearchText:(NSString *)seaTxt
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"myArray"];
    // NSArray --> NSMutableArray
    self.hotArrayM = [myArray mutableCopy];
    //[searTXT addObject:seaTxt];
    [self.hotArrayM insertObject:seaTxt atIndex:0];
    if(self.hotArrayM.count > 5)
    {
        [self.hotArrayM removeObjectAtIndex:5];
    }
    if (self.hotArrayM == 0)
    {
        _deleteButton.hidden = YES;
        _thirdheight = 0.001;
    }else
    {
        _deleteButton.hidden = NO;
        _thirdheight = 240*BOScreenH/1334;
    }
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.hotArrayM forKey:@"myArray"];
    [self.historicalTableView reloadData];
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
