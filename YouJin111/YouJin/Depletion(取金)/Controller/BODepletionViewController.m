//
//  BODepletionViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/4.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BODepletionViewController.h"
#import "UIImage+UIColor.h"
#import "MoreTaskViewController.h"
#import "MoreTaskTableViewCell.h"
#import "QJBannerModel.h"
#import "OnlyOneTableViewModel.h"
#import "WeburlViewController.h"
#import "BannerWebViewViewController.h"
#import "HotdetailsViewController.h"

@interface BODepletionViewController ()<UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic ,strong)UITableView *haveGoldTableView;//tableview
@property (nonatomic, retain)UIWebView *webView;
@property (nonatomic ,strong)UIButton *moreBtn;//更多任务的按钮
@property (nonatomic ,strong)NSMutableArray *bannerResultArr;//接受banner数据的数组
@property (nonatomic ,strong)NSMutableArray *bannerURlArr;//接受banner图片链接的数组
@property (nonatomic ,strong)NSMutableArray *resultArr;//接受tableview数据的数组
@property (nonatomic ,strong)NSMutableArray *jumpUrlArr;//banner跳转url
@property (nonatomic ,strong)NSMutableArray *goTypeArr;//判断banner是否能跳转
@property (nonatomic ,strong)NSMutableArray *ptidArr;//banner跳转ptid

@property (nonatomic ,strong)SDCycleScrollView *cycleScr;//第零区的view
@property (nonatomic ,strong)UIView *firstView;//第一区的view
@property (nonatomic ,strong)UIView *thirdview;//第三区的view
@property (nonatomic ,assign)CGFloat  thirdheight;
@property (nonatomic ,strong)UIView *topView;
@end

@implementation BODepletionViewController
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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 设置状态栏的透明度
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _ptidArr = [NSMutableArray array];
    _jumpUrlArr = [NSMutableArray array];
    _goTypeArr = [NSMutableArray array];
    _bannerURlArr = [NSMutableArray array];
    
    //创建uitableview
    _haveGoldTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-49) style:UITableViewStylePlain];
    _haveGoldTableView.delegate = self;
    _haveGoldTableView.dataSource = self;
    _haveGoldTableView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _haveGoldTableView.showsVerticalScrollIndicator = NO;
    _haveGoldTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_haveGoldTableView];
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 64)];
    _topView.backgroundColor = [UIColor colorWithHexString:@"#2d84f2" alpha:1];
    _topView.alpha = 0;
    [self.view addSubview:_topView];
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60*BOScreenH/1334, BOScreenW, 40*BOScreenH/1334)];
    topLabel.text = @"取金";
    topLabel.textColor = [UIColor colorWithHexString:@"#ffffff" alpha:1];
    topLabel.textAlignment = NSTextAlignmentCenter;
    [topLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:19]];
    [_topView addSubview:topLabel];
    
    [self topUIScrollView];//第零区的自定义view
    [self  firstSectionView];//第一区的view
    [self thirdSectionView];//第三区的view
    [self configureWebView];
    [self getBannerData];//banner图的接口数据
    [self getTableviewData];//得到tableview得数据
    
    //下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.haveGoldTableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
}
-(void)headRefresh
{
    [self getTableviewData];
}
- (void)configureWebView {
    self.webView = ({
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64)];
        [self.view addSubview: webView];
        webView;
    });
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.right.equalTo(@0);
        make.left.equalTo(@0);
    }];
}

#pragma mark------第零区的view------
- (void)topUIScrollView
{
    _cycleScr = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BOScreenW, 280*BOScreenH/1334)  delegate:self placeholderImage:[UIImage imageNamed:@"img_loadingb"]];
//    _cycleScr.imageURLStringsGroup = _bannerURlArr;
    _cycleScr.autoScrollTimeInterval = 4;
    _cycleScr.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
}
#pragma mark-----地一区的view---
- (void)firstSectionView
{
    _firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 80*BOScreenH/1334)];
    _firstView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    
    UILabel *markLabel = [[UILabel alloc]initWithFrame:CGRectMake((BOScreenW - 230*BOScreenW/750)/2, 20*BOScreenH/1334, 230*BOScreenW/750, 40*BOScreenH/1334)];
    markLabel.text = @"  热门取金";
    markLabel.textAlignment = NSTextAlignmentCenter;
    markLabel.textColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1];
    [markLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
    [_firstView addSubview:markLabel];
    //label中间添加图片
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@"  热门取金"];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"icon_hot"];
    attch.bounds = CGRectMake(0, -2, 22*BOScreenW/750, 26*BOScreenH/1334);
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:0];//在第几个文字后面
    markLabel.attributedText = attri;
}
#pragma mark-----第三区的view----
- (void)thirdSectionView
{
    _thirdview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 150*BOScreenH/1334)];
    _thirdview.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    //更多任务的button
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.frame = CGRectMake((BOScreenW-252*BOScreenW/750)/2, 30*BOScreenH/1334, 252*BOScreenW/750, 90*BOScreenH/1334);
    [_moreBtn setBackgroundColor:[UIColor whiteColor]];
    [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:[UIColor colorWithHexString:@"#737373" alpha:1] forState:UIControlStateNormal];
    _moreBtn.layer.cornerRadius = 5.0;
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_thirdview addSubview:_moreBtn];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    MoreTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[MoreTaskTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.item = self.resultArr[indexPath.row];
    //点击后的阴影效果无
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return _cycleScr;
    }else if (section == 1)
    {
        return _firstView;
    }else if (section == 2)
    {
        return nil;
    }
        return _thirdview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 280*BOScreenH/1334;
    }else if (section == 1)
    {
        return 80*BOScreenH/1334;
    }else if (section == 2)
    {
        return 0.001;
    }
//    return 150*BOScreenH/1334;
    return _thirdheight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }else if (section == 1)
    {
        return 0;
    }else if (section == 2)
    {
        return self.resultArr.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180*BOScreenH/1334;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (USERUID)
    {
        MoreTaskTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        WeburlViewController *webVc = [[WeburlViewController alloc] init];
        webVc.hidesBottomBarWhenPushed = YES;
        webVc.url = cell.item.url;
        webVc.name = cell.item.name;
        [self.navigationController pushViewController:webVc animated:YES];
    } else
    {
        //登陆界面
        [self pushToLoginViewController];
    }
}
- (void)pushToLoginViewController
{
    BONoteVerifyLogiin *noteVerifyLoginVC = [[BONoteVerifyLogiin alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:noteVerifyLoginVC];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark------UIScrollView的代理方法------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算偏移量
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = offset * 1 / 64.0;
    if (alpha >= 1)
    {
        alpha = 1;
    }
    _topView.alpha = alpha;
}
#pragma mark------更多任务的点击事件------
- (void)moreBtnClick
{
    MoreTaskViewController *moreVc = [[MoreTaskViewController alloc]init];
    moreVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moreVc animated:YES];
}
#pragma mark---得到banner的数据接口---
- (void)getBannerData
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"os"] = @"Ios";
    parameters[@"version"] = app_Version;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@Qujin/qujinBannerList",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]])
        {
            NSLog(@"返回数据类型为%@",(NSArray *)responseObject);
        }else
        {
            if ([responseObject[@"r"] integerValue] == 1)
            {
                [self webViewHidden:![responseObject[@"is_check"] boolValue]];
                if ([responseObject[@"is_check"] integerValue] == 1){
                    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:responseObject[@"url"]]];
                    [self.webView loadRequest:request];
                    return;
                }
                _bannerResultArr = responseObject[@"data"];
                for (NSDictionary *huobiDic in _bannerResultArr)
                {
                    [_bannerURlArr addObject:[huobiDic objectForKey:@"img_url"]];
                    [_jumpUrlArr addObject:[huobiDic objectForKey:@"url"]];
                    [_ptidArr addObject:[huobiDic objectForKey:@"id"]];
                    [_goTypeArr addObject:[huobiDic objectForKey:@"go_type"]];
                }
                _cycleScr.imageURLStringsGroup = _bannerURlArr;
            }else
            {
                NSLog(@"暂无数据");
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
#pragma mark---得到tableviwe得数据---
- (void)getTableviewData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"uid"] = USERUID;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = @"20";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@Qujin/getQujinHomeList",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            [self.haveGoldTableView.mj_header endRefreshing];
            self.resultArr = [OnlyOneTableViewModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (self.resultArr.count < 20)
            {
                _thirdheight = 0.001;
                _moreBtn.hidden = YES;
            }else
            {
                _thirdheight = 150*BOScreenH/1334;
            }
            [_haveGoldTableView reloadData];
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


#pragma mark -helpMethod

- (void)webViewHidden:(BOOL)isHidden {
    self.webView.hidden = isHidden;
    self.haveGoldTableView.hidden = !isHidden;
}

@end
