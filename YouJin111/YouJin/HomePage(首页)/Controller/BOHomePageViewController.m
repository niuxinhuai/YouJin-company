//
//  BOHomePageViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/4.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOHomePageViewController.h"
#import "BOTopView.h"
#import "UIImage+UIColor.h"
#import "BOPictureWheelPlay.h"
#import "BOPeerToPeerViewController.h"
#import "UIImage+UIColor.h"
#import "BODynamicDetailsVC.h"
#import "HelpViewController.h"
#import "BOLendMoneyVC.h"
#import "CarLoansViewController.h"
#import "FinancialCalculationViewController.h"
#import "MortgageCalculationViewController.h"
#import "StagingCalculationViewController.h"
#import "HomePageView.h"
#import "AnewUserView.h"
#import "PlatformServeCommentModel.h"
#import "RiskAssessmentsViewController.h"
#import "CommentPrizesViewController.h"
#import "SignInViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "BOUMoneyHomepageVC.h"
#import "YJRecentReviewsTableViewCell.h"
#import "BannerWebViewViewController.h"
#import "HotdetailsViewController.h"
#import "SearchArticleViewController.h"
#import "PlatformSearchVC.h"
#import "BannerWebViewViewController.h"
#import "CommentInsideViewController.h"
#import "NewCurrentViewController.h"
#import "HotCommentCell.h"
#import "QYSDK.h"
#import "MineHomePageViewController.h"
#import "HomePagetoutiaomodel.h"
#import "LocationManager.h"
#import "HeadLineDetailViewController.h"
#import "SearchPlatformViewController.h"
#import "CitySelectViewController.h"
#import "PlatformServiceDetailViewController.h"

static NSString * const ID = @"cell";
@interface BOHomePageViewController ()<UISearchBarDelegate,UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate,BaseViewButtonDelegete,UIGestureRecognizerDelegate,SDCycleScrollViewDelegate,UITextFieldDelegate,HotCommentCellDelegate,LocationManagerDelegate>

@property (nonatomic, weak) AFHTTPSessionManager *mgr;
@property (nonatomic, strong) UIScrollView *homeScrollView;
@property (nonatomic, strong) UIView *financialView;
/**
 评论的tableView
 */
@property (nonatomic, strong) UITableView *commentTableView;

@property (nonatomic, strong) UIButton *csButton;
@property (nonatomic ,strong)HomePageView *homeView;//网贷 有金 点评 理财 的view
@property (nonatomic ,strong)AnewUserView *anewView;//滑动领取现金红包的view
@property (nonatomic ,strong)NSTimer *timer;//红包的定时器
@property (nonatomic ,assign)int timeValue;//60s
@property (nonatomic ,strong)NSMutableArray *bannerResultArr;//banner图的数据结果
@property (nonatomic ,strong)NSMutableArray *bannerURlArr;//banner图片的url地址
@property (nonatomic ,strong)NSMutableArray *jumpUrlArr;//banner跳转url
@property (nonatomic ,strong)NSMutableArray *goTypeArr;//判断banner是否能跳转
@property (nonatomic ,strong)NSMutableArray *ptidArr;//banner跳转ptid
@property (nonatomic ,strong)NSMutableDictionary *dataDic;//接收data的字典
@property (nonatomic ,strong)NSMutableArray *resultArr;//接受tableview的结果数组
@property (nonatomic ,strong)UIButton *newsButton;//新手红包的按钮
@property (nonatomic ,strong)NSMutableArray *numberArr;//存放文字的高度
@property (nonatomic ,strong)UIView *titleView;//最新点评
@property (nonatomic ,strong)SDCycleScrollView *cycleScr;
@property (nonatomic ,strong)NSMutableArray *dianpingpidArr;//存放点评编号
@property (nonatomic ,strong)NSMutableArray *outtypeArr;//存放点评编号
@property (nonatomic ,strong)NSMutableArray *outidArr;//存放点评编号
@property (nonatomic ,strong)NSMutableArray *zidArr;
@property (nonatomic ,strong)NSMutableArray *uidArr;
@property (nonatomic ,strong)NSMutableArray *fidArr;
@property (nonatomic ,strong)NSMutableArray *namesArr;

@property (nonatomic ,assign)CGFloat cellHeight;//接受cell的高度
@property (nonatomic ,strong)UIView *bottoonView;//我是有底线的view

@property (nonatomic ,strong)UIView *topView;//顶部蓝色view
@property (nonatomic, retain)UIWebView *webView;

//有金头条
@property (nonatomic ,strong)NSMutableArray *shouyeToutiaoArr;//有金头条的数组
@property (nonatomic ,strong)NSMutableArray *tidStringArr;
@property (nonatomic ,strong)NSMutableArray *toutiaodetailArr;
@property (nonatomic ,strong)SDCycleScrollView *toutiaoSDScro;
@property (nonatomic, strong) LocationManager *locationManager;

@end

@implementation BOHomePageViewController
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}
-(NSMutableArray *)shouyeToutiaoArr
{
    if (_shouyeToutiaoArr == nil)
    {
        _shouyeToutiaoArr = [NSMutableArray array];
    }
    return _shouyeToutiaoArr;
}
-(NSMutableArray *)resultArr
{
    if (_resultArr == nil)
    {
        _resultArr = [NSMutableArray array];
    }
    return _resultArr;
}
-(NSMutableDictionary *)dataDic
{
    if (_dataDic == nil)
    {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}
-(NSMutableArray *)bannerResultArr
{
    if (_bannerResultArr == nil)
    {
        _bannerResultArr = [NSMutableArray array];
    }
    return _bannerResultArr;
}
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
#pragma mark - 懒加载首页ScrollView
- (UIScrollView *)homeScrollView {
    if (_homeScrollView == nil) {
        _homeScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH - 49)];
        _homeScrollView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        _homeScrollView.showsVerticalScrollIndicator = NO;
        _homeScrollView.delegate = self;
        [self.view addSubview:_homeScrollView];
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(topRefreshing)];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        header.ignoredScrollViewContentInsetTop =  0;
        header.automaticallyChangeAlpha = YES;
        self.homeScrollView.mj_header = header;
    }
    return  _homeScrollView;
}

- (void)dealloc {
    [self removeNotificationObserve];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tidStringArr = [NSMutableArray array];
    _toutiaodetailArr = [NSMutableArray array];
    _namesArr = [NSMutableArray array];
    _zidArr = [NSMutableArray array];
    _uidArr = [NSMutableArray array];
    _fidArr = [NSMutableArray array];
    _outtypeArr = [NSMutableArray array];
    _outidArr = [NSMutableArray array];
    _dianpingpidArr = [NSMutableArray array];
    _ptidArr = [NSMutableArray array];
    _jumpUrlArr = [NSMutableArray array];
    _numberArr = [NSMutableArray array];
    _bannerURlArr = [NSMutableArray array];
    _goTypeArr = [NSMutableArray array];
    self.numberS = @"shouye";
    
    [self getToken];//得到后台提供的token
    
    self.navigationItem.title = @"首页";
    //网页
    [self configureWebView];
    // 设置scrollView
    [self setupScrollView];
    // 设置顶部View
    [self setupTopView];
    //银行 股票 基金。。。帮助的view //点评 签到 风险评估View  //理财工具的view
    _homeView = [[HomePageView alloc]initWithFrame:CGRectMake(0, 384*BOScreenH/1334, BOScreenW, 825*BOScreenH/1334)];
    _homeView.delegate  = self;
    //点评有奖的button点击事件
    [_homeView.commentsBtn addTarget:self action:@selector(commentsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //签到的button点击事件
    [_homeView.cignInBtn addTarget:self action:@selector(cignInBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //风险评估的button点击事件
    [_homeView.riskBtn addTarget:self action:@selector(riskBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.homeScrollView addSubview:_homeView];
    [self toutiaoView];
    //新手按钮红包view
    [self ANoviceButtonAndView];
    [self BottomLineView];//我是有底线的view
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 64)];
    _topView.backgroundColor = [UIColor colorWithHexString:@"#2d84f2" alpha:0];
    [self.view addSubview:_topView];
    // 设置导航条
    [self setupNavaogationBar];
    [self addNotificationObserve];
    self.locationManager = [LocationManager sharedLocationManagerWithDelegate:self];
    
}
//头条的滚动view
- (void)toutiaoView
{
    _toutiaoSDScro = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(160*BOScreenW/750, 0, 570*BOScreenW/750, 80*BOScreenH/1334)  delegate:self placeholderImage:nil];
    _toutiaoSDScro.titleLabelBackgroundColor = [UIColor whiteColor];
    _toutiaoSDScro.titleLabelTextColor = [UIColor colorWithHexString:@"#737373" alpha:1];
    _toutiaoSDScro.scrollEnable= NO;
    _toutiaoSDScro.onlyDisplayText = YES;
    _toutiaoSDScro.scrollDirection = UICollectionViewScrollDirectionVertical;
    _toutiaoSDScro.autoScrollTimeInterval = 2;
    _toutiaoSDScro.backgroundColor = [UIColor whiteColor];
    [_homeView.goldView addSubview:(UIView *)_toutiaoSDScro];
}
#pragma mark - 设置navogationBar背景图片
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置状态栏的透明度
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];

    //判断没有登陆的时候显示新手红包登陆的时候不显示
    if (USERUID)
    {
        _newsButton.hidden = YES;
    } else
    {
        _newsButton.hidden = NO;
    }

    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.tabBar.backgroundImage = [UIImage imageWithColor:BOColor(255, 255, 255) WithAlpha:1];
    self.tabBarController.tabBar.alpha = 1;
}
#pragma mark - 设置导航条
- (void)setupNavaogationBar
{
    // 设置左边按钮
    UIButton *csButton = [UIButton buttonWithType:UIButtonTypeCustom];
    csButton.frame = CGRectMake(10*BOScreenW/750, 60*BOScreenH/1334, 100*BOScreenW/750, 40*BOScreenH/1334);
    [csButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [csButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [csButton setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"loaction_city"] forState:UIControlStateNormal];
    [csButton addTarget:self action:@selector(citySelectAction:) forControlEvents:UIControlEventTouchUpInside];
    csButton.titleLabel.font = [UIFont systemFontOfSize:14];
    NSString *initialCity = [[NSUserDefaults standardUserDefaults] objectForKey:@"loaction_city"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"loaction_city"] : @"未知";
    [csButton setTitle:initialCity forState:UIControlStateNormal];
    self.csButton = csButton;
    [_topView addSubview:csButton];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(95*BOScreenW/750, 75*BOScreenH/1334, 20*BOScreenW/750, 10*BOScreenH/1334)];
    image.image = [UIImage imageNamed:@"common_arrow_address"];
    [_topView addSubview:image];
    // 中间view
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(125*BOScreenW/750, 26, 500*BOScreenW/750, 29)];
    searchBar.showsCancelButton = NO;
    searchBar.delegate = self;
    searchBar.searchBarStyle = UISearchBarStyleDefault;
    searchBar.placeholder = @"搜索金融平台，产品或信息";
    UIImage *backImage = [UIImage imageWithAlpha:0.05];
    searchBar.backgroundImage = backImage;
    // 设置搜索框的圆角半径
    searchBar.layer.cornerRadius = 14.5;
    searchBar.layer.masksToBounds = YES;
    searchBar.backgroundColor = [UIColor whiteColor];
    [_topView addSubview:searchBar];
    //搜索上面放个按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(125*BOScreenW/750, 26, 500*BOScreenW/750, 29);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:button];
}
- (void)buttonClick
{
//    PlatformSearchVC *paVc = [[PlatformSearchVC alloc]init];
//    paVc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:paVc animated:YES];
    SearchPlatformViewController *searchVc = [[SearchPlatformViewController alloc]init];
    searchVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVc animated:YES];
}
#pragma mark - 设置scrollView
// 设置scrollViewp
- (void)setupScrollView {
    // 设置最新评论的标题View
    [self setupCommentTitleView];
    // 设置底部的评论TableView
    [self setupCommentTableView];
}

#pragma mark - 设置顶部的View
- (void)setupTopView {
    BOTopView *topView = [[BOTopView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 192 * BOScreenH / BOPictureH)];
    topView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
//    NSArray *images = [NSArray arrayWithObjects:[UIImage imageNamed:@"shouyebanner"], [UIImage imageNamed:@"shouyebanner"], [UIImage imageNamed:@"shouyebanner"], [UIImage imageNamed:@"shouyebanner"], [UIImage imageNamed:@"shouyebanner"], nil];
//    SDCycleScrollView *cycleScrollView = [BOPictureWheelPlay PictureWheelPlayWithFrame:topView.frame WithImageArray:images WithTimeInterval:4.0];
//    [topView addSubview:(UIView *)cycleScrollView];
    
    _cycleScr = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BOScreenW, 192 * BOScreenH / BOPictureH)  delegate:self placeholderImage:[UIImage imageNamed:@"img_loadingc"]];
//    cycleScr.imageURLStringsGroup = _bannerURlArr;
    _cycleScr.autoScrollTimeInterval = 4;
    _cycleScr.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    [_basaScrView addSubview:cycleScr];
    [topView addSubview:(UIView *)_cycleScr];
    [self.homeScrollView addSubview:topView];
}

#pragma mark - 设置最新评论的标题View
- (void)setupCommentTitleView {
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 668.5 * BOScreenH / BOPictureH, BOScreenW, 40)];
    // 设置指示器
    UIView *indicateView = [[UIView alloc] initWithFrame:CGRectMake(0, 11.5, 5, 17)];
    indicateView.backgroundColor = [UIColor colorWithHexString:@"#4697FB" alpha:1];
    _titleView.backgroundColor = [UIColor whiteColor];
    [_titleView addSubview:indicateView];
    
    // 添加最新评论lable
    UILabel *commentLable = [[UILabel alloc] init];
    commentLable.frame = CGRectMake(15, 10, 100, 20);
    commentLable.text = @"最新点评";
    [commentLable setFont:[UIFont systemFontOfSize:15.0]];
    [_titleView addSubview:commentLable];
    
    //细线view
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 79*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
    [_titleView addSubview:lineView];
    
    [self.homeScrollView addSubview:_titleView];
}

#pragma mark - 设置底部的评论tableView
- (void)setupCommentTableView
{
    _commentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 1417*BOScreenH/1334, BOScreenW, 200) style:UITableViewStylePlain];
    _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_commentTableView registerNib:[UINib nibWithNibName:@"HotCommentCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([HotCommentCell class])];
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.scrollEnabled = NO;
    [_homeScrollView addSubview:_commentTableView];
    _homeScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.commentTableView.frame));
}
#pragma mark---tableview的数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HotCommentCell class]) forIndexPath:indexPath];
//    cell.item = self.resultArr[indexPath.row];
    [cell updateShowHeadImageView:YES];
    [cell updateCommentModel:self.resultArr[indexPath.row]];
    cell.delegate = self;
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotCommentModle *model = self.resultArr[indexPath.row];
    _cellHeight = [model getCellHeight];
    return [model getCellHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    CommentInsideViewController *commVc = [[CommentInsideViewController alloc]init];
    commVc.hidesBottomBarWhenPushed = YES;
    commVc.pidString = [NSString stringWithFormat:@"%@",cell.model.pid];
    commVc.outidString = [NSString stringWithFormat:@"%@",cell.model.out_id];
    commVc.outtypeString = [NSString stringWithFormat:@"%@",cell.model.out_type];;
    commVc.zidString = [NSString stringWithFormat:@"%@",cell.model.zid];
    commVc.fidString = [NSString stringWithFormat:@"%@",cell.model.fid];
    commVc.uidString = [NSString stringWithFormat:@"%@",cell.model.uid];
    commVc.nameString = cell.model.object;

    [self.navigationController pushViewController:commVc animated:YES];
}
#define limitOffset 220.0 * BOScreenH / BOPictureH
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算偏移量
    CGFloat offset = self.homeScrollView.contentOffset.y;
    CGFloat alpha = offset * 1 / 64.0;
    if (alpha >= 1)
    {
        alpha = 1;
    }
    _topView.backgroundColor = [UIColor colorWithHexString:@"#2d84f2" alpha:alpha];
}
#pragma mark 网贷 借钱 。。。帮助的代理方法---
- (void)buttonBeTouched:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 10000:
        {
            BOPeerToPeerViewController *PeerToPeerViewController = [[BOPeerToPeerViewController alloc] init];
            // 每当push操作的时候，隐藏掉底部的TabBar
            PeerToPeerViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:PeerToPeerViewController animated:YES];
            break;
        }
        case 10001:
        {
            BOLendMoneyVC *lendMoneyVC = [[BOLendMoneyVC alloc] init];
            // 每当push操作的时候，隐藏掉底部的TabBar
            lendMoneyVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:lendMoneyVC animated:YES];
            break;
        }
        case 10002:
        {
            BannerWebViewViewController *bannerVc = [[BannerWebViewViewController alloc]init];
            bannerVc.name = @"学习";
            bannerVc.url = @"https://www.youjin360.com/mobile/page/video.html";
            bannerVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:bannerVc animated:YES];
            break;
        }
        case 10003:
        {
            NewCurrentViewController *vc = [NewCurrentViewController create];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 10004:
        {
            HelpViewController *helpvc = [[HelpViewController alloc] init];
            // 每当push操作的时候，隐藏掉底部的TabBar
            helpvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:helpvc animated:YES];
            break;
        }
            
        default:
            break;
    }

}
#pragma mark - 在线客服中返回我的
- (void)backMine
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark---理财工具 计算的代理方法---
- (void)buttoncalculateBtnClick:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 10:
        {
            FinancialCalculationViewController *finaVc = [[FinancialCalculationViewController alloc]init];
            finaVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:finaVc animated:YES];
            break;
        }
        case 11:
        {
            CarLoansViewController *carVc = [[CarLoansViewController alloc]init];
            carVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:carVc animated:YES];
            break;
        }
        case 12:
        {
            MortgageCalculationViewController *mortagVc = [[MortgageCalculationViewController alloc]init];
            mortagVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:mortagVc animated:YES];
            break;
        }
        case 13:
        {
            StagingCalculationViewController *staVc = [[StagingCalculationViewController alloc]init];
            staVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:staVc animated:YES];
            break;
        }
            
        default:
            break;
    }
}
#pragma mark------点评有奖的点击事件------
- (void)commentsBtnClick
{
    CommentPrizesViewController *commeVc = [[CommentPrizesViewController alloc] init];
    commeVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commeVc animated:YES];
}
#pragma mark------签到的点击事件------
- (void)cignInBtnBtnClick
{
    if (USERUID)
    {
        SignInViewController *sigViewController = [[SignInViewController alloc]init];
        sigViewController.hidesBottomBarWhenPushed = YES;
        sigViewController.numberString = self.numberS;
        [self.navigationController pushViewController:sigViewController animated:YES];
    } else
    {
        //登陆界面
        [self pushToLoginViewController];
    }
}
#pragma mark------风险评估的点击事件------
- (void)riskBtnBtnClick
{
    if (USERUID)
    {
        RiskAssessmentsViewController *risVc = [[RiskAssessmentsViewController alloc] init];
        risVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:risVc animated:YES];
    } else
    {
        //登陆界面
        [self pushToLoginViewController];
    }
}
#pragma mark---新手按钮红包view---
- (void)ANoviceButtonAndView
{
    //新手的按钮
    _newsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _newsButton.frame = CGRectMake(588*BOScreenW/750, 700*BOScreenH/1334-64, 128*BOScreenW/750, 84*BOScreenH/1334);
    [_newsButton setBackgroundImage:[UIImage imageNamed:@"img_hongsbao"] forState:UIControlStateNormal];
    [_newsButton addTarget:self action:@selector(newButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_newsButton];
    
    //滑动 领取现金红包的view
    _anewView = [[AnewUserView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    _anewView.plNumberText.delegate = self;
    //透明背景放在window上
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_anewView];
    //给背景view添加单击手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.numberOfTapsRequired = 1;//单击
    singleTap.delegate = self;
    [_anewView addGestureRecognizer:singleTap];
    
    //滑动图片上面的叉号button
    [_anewView.crossbutt addTarget:self action:@selector(crossbuttClick) forControlEvents:UIControlEventTouchUpInside];
    [_anewView.crossbutto addTarget:self action:@selector(crossbuttoClicks) forControlEvents:UIControlEventTouchUpInside];
    //领取的按钮点击事件
    [_anewView.toreceiveButton addTarget:self action:@selector(toreceiveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //滑块
    [_anewView.slider addTarget:self action:@selector(sliderClick:) forControlEvents:UIControlEventValueChanged];
    //第一次进来隐藏透明背景
    _anewView.hidden = YES;
    //定时器 从新发送的button
    [_anewView.countdownbtn addTarget:self action:@selector(countdownbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //定时器
    _timeValue = 60;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dealYzmBut) userInfo:nil repeats:YES];
    
    //刚开始进来 关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
    
    //领取的背景图片  隐藏
    _anewView.receiveImage.hidden = YES;
}


#pragma mark---新手按钮的点击事件---
- (void)newButtonClick
{
    _anewView.plNumberText.text = nil;
    _anewView.hidden = NO;
    _anewView.slidingBgimage.hidden = NO;
    _anewView.receiveImage.hidden = YES;
    _anewView.slider.value = 0;//滑动条的当前值
}
#pragma mark---滑块的滑动事件---
- (void)sliderClick:(UISlider *)sender
{
    if (sender.value < 392*BOScreenW/750)
    {
        _anewView.slider.value = 0;//滑动条的当前值
    }
    else if (sender.value >= 392*BOScreenW/750)
    {
        //判断输入的是不是手机号
        if ([self isMobileNumber:_anewView.plNumberText.text])
        {
            [_anewView.plNumberText resignFirstResponder];//输入手机号码的键盘失去响应
            _anewView.phoneLabel.text = _anewView.plNumberText.text;
            _anewView.slidingBgimage.hidden = YES;
            _anewView.receiveImage.hidden = NO;
//            //开启定时器
//            [_timer setFireDate:[NSDate distantPast]];
            [_anewView.verificationText becomeFirstResponder];
            
            //发送验证码接口
            [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_anewView.plNumberText.text
                                           zone:@"86"
                               customIdentifier:nil
                                         result:^(NSError *error){
                                             if (!error) {
                                                 [self.timer setFireDate:[NSDate distantPast]];
                                             } else {
                                                 
                                             }
                                         }];
            _anewView.verificationText.text = @"";
        }else
        {
            [self toast:@"请输入正确的手机号" complete:nil];
            _anewView.slider.value = 0;//滑动条的当前值
        }
    }
}
#pragma mark---点击从新发送开启定时器---
- (void)countdownbtnClick:(UIButton *)sender
{
    //发送验证码接口
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_anewView.plNumberText.text
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error){
                                     if (!error) {
                                         [self.timer setFireDate:[NSDate distantPast]];
                                     } else {
                                         
                                     }
                                 }];
    //开启定时器
    [_timer setFireDate:[NSDate distantPast]];
}
#pragma mark---倒计时定时器---
- (void)dealYzmBut
{
    if (_timeValue == 0)
    {
        [_anewView.countdownbtn setTitle:@"重新发送" forState:UIControlStateNormal];
        _anewView.countdownbtn.userInteractionEnabled = YES;
        _timeValue = 60;
        //        [_timer invalidate];
        //关闭定时器
        [_timer setFireDate:[NSDate distantFuture]];
        return;
    }
    _anewView.countdownbtn.userInteractionEnabled = NO;
    [_anewView.countdownbtn setTitle:[NSString stringWithFormat:@"%ds 后发送",_timeValue] forState:UIControlStateNormal];
    _timeValue--;
}
#pragma mark---滑动图片上面的叉号button---
- (void)crossbuttClick
{
    [_anewView.plNumberText resignFirstResponder];//输入手机号码的键盘失去响应
    _anewView.slidingBgimage.frame = CGRectMake(125*BOScreenW/750, 298*BOScreenH/1334, 500*BOScreenW/750, 640*BOScreenH/1334);
    _anewView.hidden = YES;
}
#pragma mark---领取的背景图片上面的叉号button---
- (void)crossbuttoClicks
{
    [_anewView.verificationText resignFirstResponder];
    _anewView.hidden = YES;
    //刚开始进来 关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
    _timeValue = 60;
}
#pragma amrk---新手 背景view单击事件---
-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [_anewView.plNumberText resignFirstResponder];//输入手机号码的键盘失去响应
    [_anewView.verificationText resignFirstResponder];
     _anewView.hidden = YES;
    _anewView.slidingBgimage.frame = CGRectMake(125*BOScreenW/750, 298*BOScreenH/1334, 500*BOScreenW/750, 640*BOScreenH/1334);
    //刚开始进来 关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
    _timeValue = 60;
}
#pragma mark---新手 背景view单击的代理---
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touc
{
    if ([touc.view isDescendantOfView:_anewView.slidingBgimage] || [touc.view isDescendantOfView:_anewView.receiveImage])
    {
        return NO;
    }
    return YES;
}
#pragma mark---bannner的数据接口----
- (void)bannerData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"os"] = @"Ios";
    parameters[@"version"] = app_Version;
    [manager POST:[NSString stringWithFormat:@"%@Common/homePage",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        if ([responseObject isKindOfClass:[NSArray class]])
        {
        }else
        {
            if ([responseObject[@"r"] integerValue] == 1)
            {
                [self webViewHidden:![responseObject[@"is_check"] boolValue]];
                if ([responseObject[@"is_check"] integerValue] == 1)
                {
                    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:responseObject[@"url"]]];
                    [self.webView loadRequest:request];
                    return;
                }
                
                if(responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]])
                {
                    _dataDic = responseObject[@"data"];
                    _bannerResultArr = _dataDic[@"banner"];
                     for (NSDictionary *huobiDic in _bannerResultArr)
                     {
                         [_bannerURlArr addObject:[huobiDic objectForKey:@"img_url"]];
                         [_jumpUrlArr addObject:[huobiDic objectForKey:@"url"]];
                         [_ptidArr addObject:[huobiDic objectForKey:@"id"]];
                         [_goTypeArr addObject:[huobiDic objectForKey:@"go_type"]];
                     }
                    // 设置顶部View
                    _cycleScr.imageURLStringsGroup = _bannerURlArr;
                    
                    //有金头条的数据
                    self.shouyeToutiaoArr = [HomePagetoutiaomodel mj_objectArrayWithKeyValuesArray:_dataDic[@"top"]];
                    for (HomePagetoutiaomodel *toutiaoModel in self.shouyeToutiaoArr)
                    {
                        [_toutiaodetailArr addObject:toutiaoModel.title];
                        [_tidStringArr addObject:toutiaoModel.tid];
                    }
                    _toutiaoSDScro.titlesGroup = _toutiaodetailArr;
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
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = @"20";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@Common/getDianPingByTime",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            [self.resultArr removeAllObjects];
            self.resultArr = [HotCommentModle mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (PlatformServeCommentModel *model in self.resultArr)
            {
                [_dianpingpidArr addObject:model.pid];
                [_outtypeArr addObject:model.out_type];
                [_outidArr addObject:model.out_id];
                [_zidArr addObject:model.zid];
                [_uidArr addObject:model.uid];
                [_fidArr addObject:model.fid];
                [_namesArr addObject:model.object];
                
                if (model.content == nil)
                {
                    
                }else
                {
                    [_numberArr addObject:model.content];
                }
            }
//            if (self.resultArr.count == 0)
//            {
//                self.homeScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.homeView.frame)+110*BOScreenH/1334);
//                self.commentTableView.hidden = YES;
//                self.titleView.hidden = YES;
//            }else
//            {
                //设置tableview的高度和scr的滑动范围
            self.commentTableView.frame = CGRectMake(0, 1417*BOScreenH/1334, BOScreenW, [self getTotalHeightWithData:self.resultArr]);
            //设置我是有底线的view位置
            CGFloat commentTableViewY = CGRectGetMaxY(_commentTableView.frame);
            _bottoonView.frame =CGRectMake(0, commentTableViewY, BOScreenW, 205*BOScreenH/1334);
            _bottoonView.hidden = NO;
            self.homeScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.commentTableView.frame)+205*BOScreenH/1334);
            [self.commentTableView reloadData];
//            }
        }
        else
        {
            NSLog(@"返回信息rrrr描述%@",responseObject[@"msg"]);
        }
        [self.homeScrollView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.homeScrollView.mj_header endRefreshing];
        NSLog(@"请求失败%@",error);
    }];
}
#pragma ---得到后台给的token保存起来---
- (void)getToken
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"app_id"] = @"2";
    parameters[@"secret"] = @"2e1eec48cae70a2c3bd8b1f2f2e177ea";
    NSString *url = [NSString stringWithFormat:@"%@Auth/accessToken",BASEURL];
//    NSString *url = @"http://120.24.43.90/index_wx.php/Auth/accessToken";
    [self.mgr POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"at"] forKey:@"access_token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self bannerData];//轮播图的数据接口
            [self tableViewData];//tableview的数据接口
            
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (cycleScrollView == self.toutiaoSDScro)
    {
        HeadLineDetailViewController *headLineVc = [[HeadLineDetailViewController alloc]init];
        headLineVc.hidesBottomBarWhenPushed = YES;
        headLineVc.tid = @([_tidStringArr[index] intValue]);
        [self.navigationController pushViewController:headLineVc animated:YES];
    }else
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
//    //分隔字符串
//    NSArray *newArray = [_jumpUrlArr[index] componentsSeparatedByString:@"|"];
//    NSLog(@"sssssss44444444444%@",newArray);
//    if (index == 0)
//    {
//        HotdetailsViewController *hotVc = [[HotdetailsViewController alloc]init];
//        hotVc.hidesBottomBarWhenPushed = YES;
//        hotVc.ptid = _ptidArr[index];
//        [self.navigationController pushViewController:hotVc animated:YES];
//    }else if (index == 1)
//    {
//        BannerWebViewViewController *bannerWebVc = [[BannerWebViewViewController alloc]init];
//        bannerWebVc.hidesBottomBarWhenPushed = YES;
//        bannerWebVc.name = newArray[0];
//        bannerWebVc.url = newArray[1];
//        [self.navigationController pushViewController:bannerWebVc animated:YES];
//    }else
//    {
//    }
}
#pragma mark---新手红包的输入号码---
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
         _anewView.slidingBgimage.frame = CGRectMake(125*BOScreenW/750, 258*BOScreenH/1334, 500*BOScreenW/750, 640*BOScreenH/1334);
    }];
}
//检测是否是手机号码
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
#pragma mark---判断验证码是不是正确的---
- (void)toreceiveButtonClick
{
    if (_anewView.verificationText.text.length == 0)
    {
        [self toast:@"验证码不能为空" complete:nil];
    }else if(_anewView.verificationText.text.length != 0)
    {
        // 验证码登录
        NSString *loadString = [NSString stringWithFormat:@"%@App/login", BASEURL];
        NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
        parameters1[@"mobile"] = _anewView.phoneLabel.text;
        parameters1[@"verycode"] = _anewView.verificationText.text;
        //    parameters1[@"sid"] = nil;
        parameters1[@"os"] = @"Ios";
        parameters1[@"at"] = tokenString;
        parameters1[@"login_type"] = @"verycode";
        [self.mgr POST:loadString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"r"] intValue] == 1) {
                //                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                NSDictionary *dictionary = responseObject[@"data"];
                [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"uid"] forKey:@"uid"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"uname"] forKey:@"uname"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"mobile"] forKey:@"mobile"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"sid"] forKey:@"sid"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                _anewView.hidden = YES;
                [_anewView.verificationText resignFirstResponder];
                BOUMoneyHomepageVC *bovc = [[BOUMoneyHomepageVC alloc]init];
                bovc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:bovc animated:YES];
                //                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [self toast:responseObject[@"msg"] complete:nil];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
}

//计算label高度
- (CGFloat)boundingRectWithString:(NSString *)string
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 6;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, paragraph, NSParagraphStyleAttributeName, nil];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(BOScreenW - 70*BOScreenW/750, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:nil];
    return  rect.size.height;
}

- (void)pushToLoginViewController {
    BONoteVerifyLogiin *noteVerifyLoginVC = [[BONoteVerifyLogiin alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:noteVerifyLoginVC];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - actionMethod

- (void)topRefreshing {
    [self tableViewData];
}

- (void)handleNotification:(NSNotification *)sender {
    if ([sender.name isEqualToString:WriteCommentComplish]) {
        [self tableViewData];
    }
}
#pragma mark - helpMethod
- (CGFloat)getTotalHeightWithData:(NSArray<HotCommentModle *> *)datas {
    CGFloat totalHeight = 0;
    for (HotCommentModle *model in datas) {
        totalHeight += [model getCellHeight];
    }
    return totalHeight;
}

- (void)citySelectAction:(UIButton *)sender {
    CitySelectViewController *vc = [CitySelectViewController create];
    __weak typeof(self) weakSelf = self;
    vc.citySelectViewControllerBlock = ^(NSString *cityName) {
        [weakSelf.csButton setTitle:cityName forState:UIControlStateNormal];
        [weakSelf updateLocationWithMessage:cityName];
    };
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)pushUserHomePageViewControllerWithUid:(NSNumber *)uid {
    MineHomePageViewController *vc = [MineHomePageViewController create];
    vc.uid = [uid intValue];
    vc.hidesBottomBarWhenPushed = YES;
    vc.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleBannerClickedWhenToPlatformWithPlatId:(NSNumber *)ptid platformName:(NSString *)name{
    HotdetailsViewController *hotVc = [[HotdetailsViewController alloc]init];
    hotVc.hidesBottomBarWhenPushed = YES;
    hotVc.ptid = [ptid stringValue];
    hotVc.nameOfPlatform = name;
    [self.navigationController pushViewController:hotVc animated:YES];
}

- (void)pushToPlatformServiceDetailViewControllerWithSvid:(NSNumber *)svid platformName:(NSString *)name{
    PlatformServiceDetailViewController *vc = [PlatformServiceDetailViewController createWithSvid:svid];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark---我是有底线的view---
- (void)BottomLineView
{
    _bottoonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 205*BOScreenH/1334)];
    _bottoonView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    [_homeScrollView addSubview:_bottoonView];
    _bottoonView.hidden = YES;
    
    UIImageView *bottomimage = [[UIImageView alloc]initWithFrame:CGRectMake(325*BOScreenW/750, 25*BOScreenH/1334, 100*BOScreenW/750, 100*BOScreenW/750)];
    bottomimage.image = [UIImage imageNamed:@"img_nomore"];
    [_bottoonView addSubview:bottomimage];
    
    UILabel *bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 150*BOScreenH/1334, BOScreenW, 30*BOScreenH/1334)];
    bottomLabel.text = @"我是有底线的";
    bottomLabel.textColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1];
    bottomLabel.font = [UIFont systemFontOfSize:13];
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    [_bottoonView addSubview:bottomLabel];
}

#pragma mark - <HotCommentCellDelegate>

- (void)hotCommentCellDidClickName:(HotCommentCell *)cell {
    [self pushUserHomePageViewControllerWithUid:cell.model.uid];
}
- (void)hotCommentCellDidClickHeadImageView:(HotCommentCell *)cell {
    [self pushUserHomePageViewControllerWithUid:cell.model.uid];
}

- (void)hotCommentCellDidClickPlatform:(HotCommentCell *)cell {
    if ([cell.model.out_type intValue] == 3) {
        [self handleBannerClickedWhenToPlatformWithPlatId:cell.model.zid platformName:cell.model.object];
    }else if ([cell.model.out_type intValue] == 9) {
        [self pushToPlatformServiceDetailViewControllerWithSvid:cell.model.zid platformName:cell.model.object];
    }
    
}

- (void)hotCommentCellAlertToPushLogin:(HotCommentCell *)cell {
    [self pushToLoginViewController];
}
#pragma mark--首页显示网页
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
- (void)webViewHidden:(BOOL)isHidden
{
    self.webView.hidden = isHidden;
    self.homeScrollView.hidden = !isHidden;
    self.topView.hidden = !isHidden;
}

#pragma mark - <LocationManagerDelegate>

- (void)locationManagerUpdateLocation:(LocationManager *)manager {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"is_lock_loaction_city"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"is_lock_loaction_city"] integerValue] == 1) return;
    if (![self.csButton.titleLabel.text isEqualToString:manager.city]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",manager.city] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"is_lock_loaction_city"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self updateLocationWithMessage:manager.city];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - helpMethod


- (void)updateLocationWithMessage:(NSString *)message {
    [self.csButton setTitle:message forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setObject:message forKey:@"loaction_city"];
    [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"is_lock_loaction_city"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)addNotificationObserve {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleNotification:) name:WriteCommentComplish object:nil];
}

- (void)removeNotificationObserve {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end


