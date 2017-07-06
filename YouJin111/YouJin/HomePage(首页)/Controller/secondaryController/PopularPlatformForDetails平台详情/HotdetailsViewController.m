//
//  HotdetailsViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HotdetailsViewController.h"
#import "nameView.h"
#import "ActivityView.h"
#import "TheInvestorTableViewCell.h"
#import "IpcView.h"
#import "UIImage+UIColor.h"
#import "InformationPlatformViewController.h"
#import "PlatformDetailsModel.h"
#import "OperationsTeamModel.h"
#import "WriteCommentsOnViewController.h"
#import "FinancingSituationView.h"
#import "RongZiModel.h"
#import "WebsiteWebViewController.h"
#import "DownloadsViewController.h"
#import "NewActivitiesWebViewController.h"
#import "UserCommentsOnViewController.h"
//点评的tableview
#import "UserCommentTableViewCell.h"
#import "BiaoQianModel.h"
#import "UserCommentCell.h"
#import "ShareManager.h"
#import "CommentInsideViewController.h"
#import "BannerWebViewViewController.h"

@interface HotdetailsViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UserCommentCellDelegate,BONoteVerifyLogiinDelegate>

@property (nonatomic ,strong)UIScrollView *baseScrView;//承载滑动的scrView
@property (nonatomic ,strong)nameView *topView;//店面详情view
@property (nonatomic ,strong)ActivityView *websiteView;//活动 官网 平台 平台信息 融资
@property (nonatomic ,strong)IpcView *ipcIDView;//ipc 监管 客服 公众号 地址
@property (nonatomic ,strong)UIView *activityView;//最新活动
@property (nonatomic ,strong)UIView *commentsView;//用户点评
@property (nonatomic ,assign)NSInteger lastcontentOffset;//根据差值判断ScrollView是上滑还是下拉
@property (nonatomic ,strong)UIVisualEffectView *effectView;//写点评的毛玻璃效果View
@property (nonatomic ,strong)UIButton *returnButton;//返回按钮
@property (nonatomic ,strong)UIButton *collectionButton;//收藏按钮
@property (nonatomic ,strong)UIButton *sharingButton;//分享按钮
@property (nonatomic ,strong)UIImageView *activityimage;//最新活动的图片
@property (nonatomic ,strong)UIView *reviewView;//上传第一条点评
@property (nonatomic ,strong)FinancingSituationView *finanView;//融资情况的tableview区头view
@property (nonatomic ,strong)PlatformDetailsModel *model;//data的数据model
//唯一的tableview投资方
@property (nonatomic ,strong)UITableView *theInvestorTableview;//创建投资方的tableview
@property (nonatomic,strong)NSMutableDictionary *dict;//记录的字典
@property (nonatomic,strong)NSMutableArray *array;//每组的标题
@property (nonatomic ,strong)NSMutableArray *rongZiResultArr;//融资情况
@property (nonatomic ,assign)NSInteger recordonOrOff;

@property (nonatomic ,strong)UILabel *commentsLabel;//用户点评

//点评的tableview
@property (nonatomic ,strong)UITableView *userDPTableview;
@property (nonatomic ,strong)NSMutableArray *dpresultArr;
@property (nonatomic ,copy)NSString *numberZstring;//得到用户点评的条数

@property (nonatomic ,strong)NSMutableArray *kkkkkk;//接受cell的一共多高
@property (nonatomic ,assign)NSNumber *sum;//接受cell的总高
@property (nonatomic ,strong)UIButton *lookButton;//查看更多点评的button

@property (nonatomic ,copy)NSString *zanoutIDString;
@property (nonatomic ,strong)UIView *navigaView;

//最新活动的处理
@property (nonatomic ,assign)CGFloat zxhdHeght;
@property (nonatomic ,assign)CGFloat ipcIDViewYss;
@property (nonatomic ,strong)OperationsTeamModel *models;

//用户点评
@property (nonatomic ,strong)UIButton *commentsbutton;
@property (nonatomic ,assign)NSInteger dpnumber;

@property (nonatomic ,strong)UIButton *rightnagaButton;//收藏按钮
@property (nonatomic ,strong)UILabel *topLabel;
@property (nonatomic ,assign)BOOL guanzhuanniu;


@end

@implementation HotdetailsViewController
-(NSMutableArray *)dpresultArr
{
    if (_dpresultArr == nil)
    {
        _dpresultArr = [NSMutableArray array];
    }
    return _dpresultArr;
}
- (NSMutableArray *)rongZiResultArr
{
    if (_rongZiResultArr == nil)
    {
        _rongZiResultArr = [NSMutableArray array];
    }
    return _rongZiResultArr;
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.view.frame = CGRectMake(0, -20, BOScreenW, BOScreenH + 20);
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 设置状态栏的透明度
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    if ([_xffqString isEqualToString:@"xiaofeifenqiPage"])
    {
        _collectionButton.hidden = YES;
        _rightnagaButton.hidden = YES;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _kkkkkk = [NSMutableArray array];
    _dict = [NSMutableDictionary dictionary];//记录的字典
    _array = [[NSMutableArray alloc] init];//每组的标题//底部tableview的数据接口
    [self PlatformForDetailsData];//平台详情的接口数据
    //底部滑动的scr
    _baseScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH+20)];
    _baseScrView.delegate = self;
    _baseScrView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _baseScrView.showsVerticalScrollIndicator = NO;
    _baseScrView.bounces = NO;
    //    _baseScrView.contentSize = CGSizeMake(BOScreenW, 880*BOScreenH/1334+482*BOScreenH/1334+160*BOScreenH/1334+450*BOScreenH/1334+250*BOScreenH/1334+90*BOScreenH/1334+200*BOScreenH/1334+98*BOScreenH/1334+49*BOScreenH/1334);
    [self.view addSubview:_baseScrView];
    
    //店面详情view
    _topView = [[nameView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 880*BOScreenH/1334)];
    _topView.xffqStr = self.xffqString;
    _topView.xffqTypeString = self.xffqlxStr;
    [_baseScrView addSubview:_topView];
    
    //活动 官网 平台 平台信息 融资
    _websiteView = [[ActivityView alloc]initWithFrame:CGRectMake(0, 896*BOScreenH/1334, BOScreenW, 482*BOScreenH/1334)];
    [_baseScrView addSubview:_websiteView];
    [_websiteView.informationButton addTarget:self action:@selector(informationButtonClick) forControlEvents:UIControlEventTouchUpInside];//更多信息平台的点击事件
    [_websiteView.websiteButton addTarget:self action:@selector(websiteButtonClick) forControlEvents:UIControlEventTouchUpInside];//官网的点击事件
    [_websiteView.terraceAppButton addTarget:self action:@selector(terraceAppButtonClick) forControlEvents:UIControlEventTouchUpInside];//一键下载的点击事件
    [_websiteView.newsButton addTarget:self action:@selector(newsButtonClick) forControlEvents:UIControlEventTouchUpInside];//新手活动的点击事件
    
    //创建投资方的tableview
    _theInvestorTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 1379*BOScreenH/1334, BOScreenW, self.rongZiResultArr.count*(80*BOScreenH/1334)) style:UITableViewStylePlain];
    _theInvestorTableview.delegate = self;
    _theInvestorTableview.dataSource = self;
    [_baseScrView addSubview:_theInvestorTableview];
    
    //ipc 监管 客服 公众号 地址
    CGFloat theInvestorTableviewY = CGRectGetMaxY(_theInvestorTableview.frame);
    _ipcIDView = [[IpcView alloc]initWithFrame:CGRectMake(0, theInvestorTableviewY, BOScreenW, 450*BOScreenH/1334)];
    [_ipcIDView.thePublicButton addTarget:self action:@selector(thePublicButtonClick) forControlEvents:UIControlEventTouchUpInside];//微信公众号的点击事件
    [_baseScrView addSubview:_ipcIDView];
    
    //最新活动
    [self theLatestActivityView];
    //用户点评
    [self userCommentsOnView];
    //上传第一条评论
    [self uploadTheFirstReviewView];
    //写点评
    [self writeCommentsOnView];
    //顶部 返回 收藏 返回
    [self returnsAndCollectionAndSharingButton];
    
    //查看更多点评按钮
    _lookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_lookButton setTitle:@"查看更多点评" forState:UIControlStateNormal];
    [_lookButton setTitleColor:[UIColor colorWithHexString:@"#b3b3b3" alpha:1] forState:UIControlStateNormal];
    _lookButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_lookButton addTarget:self action:@selector(commentsbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [_baseScrView addSubview:_lookButton];
    
    [self settopViewNavigationBar];//设置顶部的NavigationBar
}
//设置NavigationBar
- (void)settopViewNavigationBar
{
    _navigaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 84)];
    _navigaView.backgroundColor = [UIColor colorWithHexString:@"#2d84f2" alpha:1];
    _navigaView.alpha = 0;
    [self.view addSubview:_navigaView];
    
    UIImageView *naviiamgeview = [[UIImageView alloc]initWithFrame:CGRectMake(21*BOScreenW/750, 40+20*BOScreenH/1334, 22*BOScreenW/750, 38*BOScreenH/1334)];
    naviiamgeview.image = [UIImage imageNamed:@"common_icon_back"];
    [_navigaView addSubview:naviiamgeview];
    
    UIButton *leftnagaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftnagaButton.frame = CGRectMake(0, 40, 150*BOScreenW/750, 80*BOScreenH/1334);
    [leftnagaButton addTarget:self action:@selector(leftnagaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_navigaView addSubview:leftnagaButton];
    
    _topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60*BOScreenH/1334+20, BOScreenW, 40*BOScreenH/1334)];
//    _topLabel.text = self.nameOfPlatform;
    _topLabel.textColor = [UIColor colorWithHexString:@"#ffffff" alpha:1];
    _topLabel.textAlignment = NSTextAlignmentCenter;
    [_topLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:19]];
    [_navigaView addSubview:_topLabel];
    
    _rightnagaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightnagaButton.frame = CGRectMake(600*BOScreenW/750, 50*BOScreenH/1334+20, 60*BOScreenW/750, 60*BOScreenW/750);
//    [_rightnagaButton setBackgroundImage:[UIImage imageNamed:@"icon_shoucang_nor"] forState:UIControlStateNormal];
    [_rightnagaButton addTarget:self action:@selector(collectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [_navigaView addSubview:_rightnagaButton];
    
    UIButton *oenrightnagaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oenrightnagaButton.frame = CGRectMake(670*BOScreenW/750, 50*BOScreenH/1334+20, 60*BOScreenW/750, 60*BOScreenW/750);
    [oenrightnagaButton setBackgroundImage:[UIImage imageNamed:@"icon_fenxiang"] forState:UIControlStateNormal];
    [oenrightnagaButton addTarget:self action:@selector(sharingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_navigaView addSubview:oenrightnagaButton];
}
#pragma mark---投资方的tableview的代理方法---
//每组的组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _userDPTableview)
    {
        return nil;
    }
    _finanView = [[FinancingSituationView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 80*BOScreenH/1334)];
    RongZiModel *item = self.rongZiResultArr[section];
    _finanView.timesLabel.text = item.rongzi_date;
    _finanView.anAngelroundLabel.text = item.level;
    _finanView.moreMoneyLabel.text  = item.money;
    //view的tag就等于section 代表点击了哪一个组
    _finanView.tag = section;
    [_finanView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(display1:)]];
    return _finanView;
}
- (void)display1:(UITapGestureRecognizer *)g
{
    //将点击了哪一组转换成字符串
    NSString *str = [NSString stringWithFormat:@"%ld",(long)g.view.tag];
    //从字典里面以第几组为key取出状态值
    //如果状态值为0，代表关闭
    if([self.dict[str] integerValue] == 0)
    {
        _recordonOrOff ++;
        _theInvestorTableview.frame = CGRectMake(0, 1379*BOScreenH/1334, BOScreenW, self.rongZiResultArr.count*(80*BOScreenH/1334)+60*BOScreenH/1334*_recordonOrOff);
        //ipc
        CGFloat theInvestorTableviewY = CGRectGetMaxY(_theInvestorTableview.frame);
        //判断 ipc经营许可证 和 监管协会的有无
        if (_model.icp_xuke.length == 0)
        {
            _ipcIDView.frame = CGRectMake(0, theInvestorTableviewY, BOScreenW, 360*BOScreenH/1334);
        }
        if (_model.jianguan.length == 0)
        {
            _ipcIDView.frame = CGRectMake(0, theInvestorTableviewY, BOScreenW, 360*BOScreenH/1334);
        }
        if (_model.icp_xuke.length == 0 && _model.jianguan.length == 0)
        {
            _ipcIDView.frame = CGRectMake(0, theInvestorTableviewY, BOScreenW, 270*BOScreenH/1334);
        }
        if (_model.icp_xuke.length != 0 && _model.jianguan.length != 0)
        {
            _ipcIDView.frame = CGRectMake(0, theInvestorTableviewY, BOScreenW, 450*BOScreenH/1334);
        }
        //        _ipcIDView.frame = CGRectMake(0, theInvestorTableviewY, BOScreenW, 450*BOScreenH/1334);
        //最新活动
        if (_models.img_url.length == 0)
        {
            CGFloat ipcIDViewY = CGRectGetMaxY(_ipcIDView.frame);
            _activityView.frame = CGRectMake(0, ipcIDViewY, BOScreenW, _zxhdHeght);

        }else
        {
            CGFloat ipcIDViewY = CGRectGetMaxY(_ipcIDView.frame) + 16*BOScreenH/1334;
            _activityView.frame = CGRectMake(0, ipcIDViewY, BOScreenW, _zxhdHeght);
        }
//        CGFloat ipcIDViewY = CGRectGetMaxY(_ipcIDView.frame) + 16*BOScreenH/1334;
//        _activityView.frame = CGRectMake(0, ipcIDViewY, BOScreenW, _zxhdHeght);
        //用户点评
        CGFloat activityViewY = CGRectGetMaxY(_activityView.frame) + 16*BOScreenH/1334;
        _commentsView.frame = CGRectMake(0, activityViewY, BOScreenW, 90*BOScreenH/1334);
        //上传第一条点评
        CGFloat commentsViewY = CGRectGetMaxY(_commentsView.frame);
        _reviewView.frame = CGRectMake(0, commentsViewY, BOScreenW, 200*BOScreenH/1334);
        
        //        CGRect frame = self.userDPTableview.frame;
        //        frame.size.height = [self getTotalHeightWithData:self.dpresultArr];
        //        self.userDPTableview.frame = frame;
        _userDPTableview.frame = CGRectMake(0, commentsViewY, BOScreenW, [self getTotalHeightWithData:self.dpresultArr]);
        CGFloat userDPTableviewY = CGRectGetMaxY(_userDPTableview.frame);
        //设置查看更多点评的按钮位置
        _lookButton.frame = CGRectMake(200*BOScreenW/750, userDPTableviewY + 25*BOScreenH/1334, 350*BOScreenW/750, 30*BOScreenH/1334);
        if (_dpnumber == 0)
        {
            _baseScrView.contentSize = CGSizeMake(BOScreenW, userDPTableviewY + 200*BOScreenH/1334);
        }else
        {
            _baseScrView.contentSize = CGSizeMake(BOScreenW, userDPTableviewY + 80*BOScreenH/1334);
        }
        
        [self.dict setObject:@(1) forKey:str];
    }
    //如果状态值为不为0，代表展开 common_icon_xiala_h
    else
    {
        _recordonOrOff --;
        _theInvestorTableview.frame = CGRectMake(0, 1379*BOScreenH/1334, BOScreenW, self.rongZiResultArr.count*(80*BOScreenH/1334)+60*BOScreenH/1334*_recordonOrOff);
        //ipc
        CGFloat theInvestorTableviewY = CGRectGetMaxY(_theInvestorTableview.frame);
        //判断 ipc经营许可证 和 监管协会的有无
        if (_model.icp_xuke.length == 0)
        {
            _ipcIDView.frame = CGRectMake(0, theInvestorTableviewY, BOScreenW, 360*BOScreenH/1334);
        }
        if (_model.jianguan.length == 0)
        {
            _ipcIDView.frame = CGRectMake(0, theInvestorTableviewY, BOScreenW, 360*BOScreenH/1334);
        }
        if (_model.icp_xuke.length == 0 && _model.jianguan.length == 0)
        {
            _ipcIDView.frame = CGRectMake(0, theInvestorTableviewY, BOScreenW, 270*BOScreenH/1334);
        }
        if (_model.icp_xuke.length != 0 && _model.jianguan.length != 0)
        {
            _ipcIDView.frame = CGRectMake(0, theInvestorTableviewY, BOScreenW, 450*BOScreenH/1334);
        }
        //        _ipcIDView.frame = CGRectMake(0, theInvestorTableviewY, BOScreenW, 450*BOScreenH/1334);
        //最新活动
        if (_models.img_url.length == 0)
        {
            CGFloat ipcIDViewY = CGRectGetMaxY(_ipcIDView.frame);
            _activityView.frame = CGRectMake(0, ipcIDViewY, BOScreenW, _zxhdHeght);
            
        }else
        {
            CGFloat ipcIDViewY = CGRectGetMaxY(_ipcIDView.frame) + 16*BOScreenH/1334;
            _activityView.frame = CGRectMake(0, ipcIDViewY, BOScreenW, _zxhdHeght);
        }
//        CGFloat ipcIDViewY = CGRectGetMaxY(_ipcIDView.frame) + 16*BOScreenH/1334;
//        _activityView.frame = CGRectMake(0, ipcIDViewY, BOScreenW, _zxhdHeght);
        //用户点评
        CGFloat activityViewY = CGRectGetMaxY(_activityView.frame) + 16*BOScreenH/1334;
        _commentsView.frame = CGRectMake(0, activityViewY, BOScreenW, 90*BOScreenH/1334);
        //上传第一条点评
        CGFloat commentsViewY = CGRectGetMaxY(_commentsView.frame);
        _reviewView.frame = CGRectMake(0, commentsViewY, BOScreenW, 200*BOScreenH/1334);
        //        CGRect frame = self.userDPTableview.frame;
        //        frame.size.height = [self getTotalHeightWithData:self.dpresultArr];
        //        self.userDPTableview.frame = frame;
        _userDPTableview.frame = CGRectMake(0, commentsViewY, BOScreenW, [self getTotalHeightWithData:self.dpresultArr]);
        CGFloat userDPTableviewY = CGRectGetMaxY(_userDPTableview.frame);
        //设置查看更多点评的按钮位置
        _lookButton.frame = CGRectMake(200*BOScreenW/750, userDPTableviewY + 25*BOScreenH/1334, 350*BOScreenW/750, 30*BOScreenH/1334);
        if (_dpnumber == 0)
        {
            _baseScrView.contentSize = CGSizeMake(BOScreenW, userDPTableviewY + 200*BOScreenH/1334);
        }else
        {
            _baseScrView.contentSize = CGSizeMake(BOScreenW, userDPTableviewY + 80*BOScreenH/1334);
        }
        [self.dict setObject:@(0) forKey:str];
    }
    //记得一定要刷新tabelView，不然没有效果
    [self.theInvestorTableview reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _userDPTableview)
    {
        return 0.001;
    }
    return 80*BOScreenH/1334;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _userDPTableview)
    {
        return 1;
    }
    return _rongZiResultArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _userDPTableview)
    {
        return self.dpresultArr.count;
    }
    
    /*调用tableView的reloadData方法会重新调用这个方法
     从而从字典里面取出相应组对应的状态码，从而判断是需要展开还是收起
     */
    NSString *str = [NSString stringWithFormat:@"%ld",(long)section];
    //将点击了哪一组转换成字符串
    if([self.dict[str] integerValue] == 1)
    {
        //如果状态值为等于1，代表需要展开返回真正的多少个Cell
        return 1;
    }else{
        //如果状态值为等于0，代表需要收起返回0
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _userDPTableview)
    {
        UserCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserCommentCell class]) forIndexPath:indexPath];
        cell.delegate = self;
        [cell updateBiaoQianModel:self.dpresultArr[indexPath.row]];
        return cell;
    }
    
    static NSString *cellString = @"cell";
    TheInvestorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[TheInvestorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.item = self.rongZiResultArr[indexPath.section];
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _userDPTableview)
    {
        BiaoQianModel *model = self.dpresultArr[indexPath.row];
        
        //        CGFloat maxfloat = [model topCommentCellHeight]+[model topCommentCellHeight];
        //        NSLog(@"ffffffff%f",[model topCommentCellHeight]);
        return [model topCommentCellHeight];
    }
    return 60*BOScreenH/1334;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _userDPTableview)
    {
        UserCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        CommentInsideViewController *commVc = [[CommentInsideViewController alloc]init];
        commVc.hidesBottomBarWhenPushed = YES;
        commVc.pidString = cell.model.pid;
        commVc.outidString = cell.model.pid;
        commVc.outtypeString = @"3";
        commVc.nameString = self.nameOfPlatform;
        commVc.playKeyboard = @"noplayKeyboard";
        [self.navigationController pushViewController:commVc animated:YES];
    }
}
- (void)userCommentCellDidCilckComment:(UserCommentCell *)cell
{
    CommentInsideViewController *commVc = [[CommentInsideViewController alloc]init];
    commVc.hidesBottomBarWhenPushed = YES;
    commVc.pidString = cell.model.pid;
    commVc.outidString = cell.model.pid;
    commVc.outtypeString = @"3";
    commVc.nameString = self.nameOfPlatform;
    commVc.playKeyboard = @"playKeyboard";
    [self.navigationController pushViewController:commVc animated:YES];
}
- (void)userCommentCellDidCilckFavour:(UserCommentCell *)cell
{
    _zanoutIDString = cell.model.pid;
    [self zanOfTheData];
}
#pragma mark---最新活动---
- (void)theLatestActivityView
{
    //最新活动view
    CGFloat ipcIDViewY = CGRectGetMaxY(_ipcIDView.frame) + 16*BOScreenH/1334;
    _activityView = [[UIView alloc]initWithFrame:CGRectMake(0, ipcIDViewY, BOScreenW, 250*BOScreenH/1334)];
    _activityView.backgroundColor = [UIColor whiteColor];
    [_baseScrView addSubview:_activityView];
    
    //最新活动
    UILabel *activityLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 140*BOScreenW/750, 40*BOScreenH/1334)];
    activityLabel.text = @"最新活动";
    activityLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    activityLabel.font = [UIFont systemFontOfSize:15];
    [_activityView addSubview:activityLabel];
    //最新活动的图片
    _activityimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 90*BOScreenH/1334, BOScreenW, 160*BOScreenH/1334)];
    [_activityView addSubview:_activityimage];
    
    UIButton *activityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    activityButton.frame = CGRectMake(0, 90*BOScreenH/1334, BOScreenW, 160*BOScreenH/1334);
    [activityButton addTarget:self action:@selector(activityButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_activityView addSubview:activityButton];
}
#pragma mark---最新活动的点击事件---
- (void)activityButtonClick
{
    BannerWebViewViewController *bannerVc = [[BannerWebViewViewController alloc]init];
    bannerVc.name = @"最新活动";
    bannerVc.url = _models.href_url;
    [self.navigationController pushViewController:bannerVc animated:YES];
}
#pragma mark---用户点评---
- (void)userCommentsOnView
{
    //用户点评view
    CGFloat activityViewY = CGRectGetMaxY(_activityView.frame) + 16*BOScreenH/1334;
    _commentsView = [[UIView alloc]initWithFrame:CGRectMake(0, activityViewY, BOScreenW, 90*BOScreenH/1334)];
    _commentsView.backgroundColor = [UIColor whiteColor];
    [_baseScrView addSubview:_commentsView];
    
    //用户点评
    _commentsLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 200*BOScreenW/750, 40*BOScreenH/1334)];
    //    _commentsLabel.text = @"用户点评";
    _commentsLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    _commentsLabel.font = [UIFont systemFontOfSize:15];
    [_commentsView addSubview:_commentsLabel];
    
    //用户点评的箭头
    UIImageView *commentsImages = [[UIImageView alloc]initWithFrame:CGRectMake(BOScreenW - 45*BOScreenW/750, 30*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
    commentsImages.image = [UIImage imageNamed:@"common_goto"];
    [_commentsView addSubview:commentsImages];
    
    //线view
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 89*BOScreenH/1334, BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"dfe3e6" alpha:1];
    [_commentsView addSubview:lineView];
    
    //用户点评的按钮
    _commentsbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentsbutton.frame = CGRectMake(0, 0, BOScreenW, 90*BOScreenH/1334);
    [_commentsbutton addTarget:self action:@selector(commentsbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [_commentsView addSubview:_commentsbutton];
}
- (void)commentsbuttonClick
{
    UserCommentsOnViewController *userVc = [[UserCommentsOnViewController alloc]init];
    userVc.hidesBottomBarWhenPushed = YES;
    userVc.ptidString = _model.ptid;
    userVc.numberString = _numberZstring;
    userVc.yhdpString = _commentsLabel.text;
    userVc.namestring = self.nameOfPlatform;
    [self.navigationController pushViewController:userVc animated:YES];
}
#pragma mark---上传第一条点评---
- (void)uploadTheFirstReviewView
{
    //上传第一条点评view
    CGFloat commentsViewY = CGRectGetMaxY(_commentsView.frame);
    _reviewView = [[UIView alloc]initWithFrame:CGRectMake(0, commentsViewY, BOScreenW, 200*BOScreenH/1334)];
    _reviewView.backgroundColor = [UIColor whiteColor];
    [_baseScrView addSubview:_reviewView];
    
    //上传第一条点评button
    UIButton *commentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentsButton.frame = CGRectMake(235*BOScreenW/750, 64*BOScreenH/1334, 280*BOScreenW/750, 72*BOScreenH/1334);
    [commentsButton setTitle:@" 上传第1条点评" forState:UIControlStateNormal];
    [commentsButton setImage:[UIImage imageNamed:@"icon_dianping_dark"] forState:UIControlStateNormal];
    [commentsButton setTitleColor:[UIColor colorWithHexString:@"#333333" alpha:1] forState:UIControlStateNormal];
    commentsButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [commentsButton.layer setMasksToBounds:YES];
    [commentsButton.layer setCornerRadius:4];
    [commentsButton.layer setBorderWidth:1.0];
    commentsButton.layer.borderColor = [UIColor colorWithHexString:@"#999999" alpha:1].CGColor;
    [commentsButton addTarget:self action:@selector(commentsButtonClickss) forControlEvents:UIControlEventTouchUpInside];
    [_reviewView addSubview:commentsButton];
}
#pragma mark---上传第一条点评的点击事件---
- (void)commentsButtonClickss
{
    if (USERUID)
    {
        WriteCommentsOnViewController *wriVc = [[WriteCommentsOnViewController alloc]init];
        wriVc.hidesBottomBarWhenPushed = YES;
        //        wriVc.nameString = self.nameOfPlatform;
        wriVc.nameString = _model.name;
        wriVc.ptidStr = _model.ptid;
        wriVc.type = @3;
        [self.navigationController pushViewController:wriVc animated:YES];
    } else
    {
        //登陆界面
        BONoteVerifyLogiin *Logiin = [[BONoteVerifyLogiin alloc]init];
        [self presentViewController:Logiin animated:YES completion:nil];
    } 
}
#pragma mark---写点评---
- (void)writeCommentsOnView
{
    //    //写点评view
    //    UIView *writeCommentView =[[UIView alloc]initWithFrame:CGRectMake(0, BOScreenH - 98*BOScreenH/1334+20, BOScreenW, 98*BOScreenH/1334)];
    //    writeCommentView.backgroundColor = [UIColor colorWithHexString:@"#f7f7fa" alpha:1];
    //    [self.view addSubview:writeCommentView];
    
    //毛玻璃效果
    _effectView =[[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    _effectView.frame = CGRectMake(0, BOScreenH - 98*BOScreenH/1334+20, BOScreenW, 98*BOScreenH/1334);
    _effectView.alpha = 0.97;
    [self.view addSubview:_effectView];
    UIVisualEffectView *sub = [[UIVisualEffectView alloc]initWithEffect:[UIVibrancyEffect effectForBlurEffect:(UIBlurEffect *)_effectView.effect]];
    sub.frame = _effectView.bounds;
    [_effectView.contentView addSubview:sub];
    //写点评的button
    UIButton *commentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentsButton.frame = CGRectMake((BOScreenW-200*BOScreenW/750)/2, 19*BOScreenH/1334, 200*BOScreenW/750, 60*BOScreenH/1334);
    [commentsButton setTitle:@"  写点评" forState:UIControlStateNormal];
    [commentsButton setImage:[UIImage imageNamed:@"icon_xdp"] forState:UIControlStateNormal];
    [commentsButton setTitleColor:[UIColor colorWithHexString:@"#2380f4" alpha:1] forState:UIControlStateNormal];
    commentsButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [commentsButton addTarget:self action:@selector(commentsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [sub addSubview:commentsButton];
    //线view
    UIView *fourLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 1*BOScreenH/1334)];
    fourLineView.backgroundColor = [UIColor colorWithHexString:@"#c6c7c7" alpha:1];
    [sub addSubview:fourLineView];
}
#pragma mark---返回 收藏 分享 button---
- (void)returnsAndCollectionAndSharingButton
{
    //返回
    _returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _returnButton.frame = CGRectMake(20*BOScreenW/750, 52*BOScreenH/1334+20, 64*BOScreenW/750, 64*BOScreenW/750);
    [_returnButton setImage:[UIImage imageNamed:@"icon_backs"] forState:UIControlStateNormal];
    [_returnButton addTarget:self action:@selector(leftnagaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_returnButton];
    //关注
    _collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectionButton.frame = CGRectMake(BOScreenW - 162*BOScreenW/750, 52*BOScreenH/1334+20, 64*BOScreenW/750, 64*BOScreenW/750);
//    [_collectionButton setImage:[UIImage imageNamed:@"icon_shoucangs_nor"] forState:UIControlStateNormal];
    [_collectionButton addTarget:self action:@selector(collectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_collectionButton];
    //分享
    _sharingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sharingButton.frame = CGRectMake(BOScreenW - 84*BOScreenW/750, 52*BOScreenH/1334+20, 64*BOScreenW/750, 64*BOScreenW/750);
    [_sharingButton setImage:[UIImage imageNamed:@"icon_fenxiangs"] forState:UIControlStateNormal];
    [_sharingButton addTarget:self action:@selector(sharingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sharingButton];
}
#pragma mark ---- 关注的点击示事件
- (void)collectionButtonClick:(UIButton *)sender
{
    if (USERUID)
    {
        if (_guanzhuanniu)
        {
            [self cancellationNoticeData];
            _guanzhuanniu = NO;
        }else
        {
            [self payAttentionToFriendsData];
            _guanzhuanniu = YES;
        }
    } else
    {
        //登陆界面
        [self pushToLoginViewController];
    }
}
#pragma mark ---- 分享的点击事件
- (void)sharingButtonClick
{
    NSString *titleString = [NSString stringWithFormat:@"%@欢迎你!",_model.name];
    NSString *detailString = [NSString stringWithFormat:@"%@入驻有金！带来丰厚的新手福利，更全更新的平台档案就在有金APP。",_model.name];
    ShareManager *manager = [ShareManager shareManagerStandardWithDelegate:nil];
    [manager shareInView:self.view text:detailString image:[UIImage shareImageWithUrl:_model.logo] url:[NSString stringWithFormat:@"%@mobile/page/platform.html?ptid=%@",BASEWEBURl,_model.ptid] title:titleString objid:nil];
}
#pragma mark---返回按钮的点击事件---
- (void)leftnagaButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark---判断scrView是上滑还是下滑---
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat hight = scrollView.frame.size.height;
    CGFloat contentOffset = scrollView.contentOffset.y;
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentOffset;
    CGFloat offset = contentOffset - self.lastcontentOffset;
    self.lastcontentOffset = contentOffset;
    //    NSLog(@"hight%f",hight);
    //    NSLog(@"contentOffset%f",contentOffset);
    //    NSLog(@"distanceFromBottom%f",distanceFromBottom);
    //    NSLog(@"offset%f",offset);
    //    NSLog(@"hight%f",hight);
    
    //隐藏顶部的三个按钮
    if (contentOffset > -20)
    {
        _returnButton.hidden = YES;
        _collectionButton.hidden = YES;
        _sharingButton.hidden = YES;
    }
    if (contentOffset == 0)
    {
        _returnButton.hidden = NO;
        if ([_xffqString isEqualToString:@"xiaofeifenqiPage"])
        {
            _collectionButton.hidden = YES;
        }else
        {
            _collectionButton.hidden = NO;
        }
        _sharingButton.hidden = NO;
    }
    
    if (offset > 0 && contentOffset > 0)
    {
        //        NSLog(@"上拉行为");
        [UIView animateWithDuration:0.5 animations:^{
            _effectView.frame = CGRectMake(0, BOScreenH+20, BOScreenW, 98*BOScreenH/1334);
        }];
    }
    if (offset < 0 && distanceFromBottom > hight)
    {
        //        NSLog(@"下拉行为");
        [UIView animateWithDuration:0.5 animations:^{
            _effectView.frame = CGRectMake(0, BOScreenH - 98*BOScreenH/1334+20, BOScreenW, 98*BOScreenH/1334);
        }];
    }
    if (contentOffset == 0)
    {
//        NSLog(@"滑动到顶部");
        [UIView animateWithDuration:0.5 animations:^{
            _effectView.frame = CGRectMake(0, BOScreenH - 98*BOScreenH/1334+20, BOScreenW, 98*BOScreenH/1334);
        }];
    }
    if (distanceFromBottom < hight)
    {
//        NSLog(@"滑动到底部");
        [UIView animateWithDuration:0.5 animations:^{
            _effectView.frame = CGRectMake(0, BOScreenH - 98*BOScreenH/1334+20, BOScreenW, 98*BOScreenH/1334);
        }];
    }
    if (distanceFromBottom == hight)
    {
//        NSLog(@"滑动到底部");
        [UIView animateWithDuration:0.5 animations:^{
            _effectView.frame = CGRectMake(0, BOScreenH + 98*BOScreenH/1334+20, BOScreenW, 98*BOScreenH/1334);
        }];
    }
    
    //当offset值等于64的时候 alpha = 1
    CGFloat alpha = contentOffset * 1 / 64.0;
    if (alpha >= 1)
    {
        alpha = 1;
    }
    _navigaView.alpha = alpha;
}
#pragma mark---更多信息平台的点击事件---
- (void)informationButtonClick
{
    InformationPlatformViewController *informationP = [[InformationPlatformViewController alloc]init];
    informationP.ptid = self.ptid;
    informationP.titleViewString = _topView.shopNameLabel.text;
    [self.navigationController pushViewController:informationP animated:YES];
}
#pragma mark---数据接口----
- (void)PlatformForDetailsData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"ptid"] = self.ptid;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@WdApi/getWdPtInfo",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            _model = [PlatformDetailsModel mj_objectWithKeyValues:responseObject[@"main_data"]];
            //判断是否关注
            if ([_model.is_focus integerValue] == 1)
            {
                _guanzhuanniu = YES;
                [_collectionButton setImage:[UIImage imageNamed:@"icon_shoucangs_pre"] forState:UIControlStateNormal];
                [_rightnagaButton setBackgroundImage:[UIImage imageNamed:@"icon_shoucang_pre"] forState:UIControlStateNormal];
            }else
            {
                [_rightnagaButton setBackgroundImage:[UIImage imageNamed:@"icon_shoucang_nor"] forState:UIControlStateNormal];
                [_collectionButton setImage:[UIImage imageNamed:@"icon_shoucangs_nor"] forState:UIControlStateNormal];
            }
            
            _topLabel.text = _model.name;
            _topView.item = _model;
            _websiteView.item = _model;
            _ipcIDView.item = _model;
            self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:_model.name];
            
            //最新活动的数据
            _models = [OperationsTeamModel mj_objectWithKeyValues:responseObject[@"huodong"]];
            [_activityimage sd_setImageWithURL:[NSURL URLWithString:_models.img_url] placeholderImage:[UIImage imageNamed:@"img_loadingb"]];
            
            //融资情况的数据
            self.rongZiResultArr = [RongZiModel mj_objectArrayWithKeyValuesArray:responseObject[@"rongzi"]];
            
            //判断有无 融资情况
            if (self.rongZiResultArr.count == 0)
            {
                _websiteView.frame = CGRectMake(0, 896*BOScreenH/1334, BOScreenW, 392*BOScreenH/1334);
                _theInvestorTableview.frame = CGRectMake(0, 1289*BOScreenH/1334, BOScreenW, self.rongZiResultArr.count*(80*BOScreenH/1334));
                _ipcIDView.lineVi.hidden = YES;
            }else
            {
                //tableview
                _theInvestorTableview.frame = CGRectMake(0, 1379*BOScreenH/1334, BOScreenW, self.rongZiResultArr.count*(80*BOScreenH/1334));
            }
            
            //ipc
            CGFloat theInvestorTableviewY = CGRectGetMaxY(_theInvestorTableview.frame);
            
            //判断 ipc经营许可证 和 监管协会的有无
            if (_model.icp_xuke.length == 0)
            {
                _ipcIDView.frame = CGRectMake(0, theInvestorTableviewY, BOScreenW, 360*BOScreenH/1334);
            }
            if (_model.jianguan.length == 0)
            {
                _ipcIDView.frame = CGRectMake(0, theInvestorTableviewY, BOScreenW, 360*BOScreenH/1334);
            }
            if (_model.icp_xuke.length == 0 && _model.jianguan.length == 0)
            {
                _ipcIDView.frame = CGRectMake(0, theInvestorTableviewY, BOScreenW, 270*BOScreenH/1334);
            }
            if (_model.icp_xuke.length != 0 && _model.jianguan.length != 0)
            {
                _ipcIDView.frame = CGRectMake(0, theInvestorTableviewY, BOScreenW, 450*BOScreenH/1334);
            }
            //            _ipcIDView.frame = CGRectMake(0, theInvestorTableviewY, BOScreenW, 450*BOScreenH/1334);
            //最新活动
            if (_models.img_url.length == 0)
            {
                _zxhdHeght = 0;
                _ipcIDViewYss = CGRectGetMaxY(_ipcIDView.frame);
            }else
            {
                _zxhdHeght = 250*BOScreenH/1334;
                _ipcIDViewYss = CGRectGetMaxY(_ipcIDView.frame) + 16*BOScreenH/1334;
            }
            _activityView.frame = CGRectMake(0, _ipcIDViewYss, BOScreenW, _zxhdHeght);
            //用户点评
            CGFloat activityViewY = CGRectGetMaxY(_activityView.frame) + 16*BOScreenH/1334;
            _commentsView.frame = CGRectMake(0, activityViewY, BOScreenW, 90*BOScreenH/1334);
            //上传第一条点评
            CGFloat commentsViewY = CGRectGetMaxY(_commentsView.frame);
            _reviewView.frame = CGRectMake(0, commentsViewY, BOScreenW, 200*BOScreenH/1334);
            
            //刷新tableview
            [_theInvestorTableview reloadData];
            
            //            NSLog(@"6666%@",_sum);
            //            CGFloat heightCell = [_sum floatValue];
            //            NSLog(@"333%f",heightCell);
            _userDPTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, commentsViewY, BOScreenW, 10*400*BOScreenH/1334) style:UITableViewStylePlain];
            _userDPTableview.delegate = self;
            _userDPTableview.dataSource = self;
            _userDPTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
            _userDPTableview.showsVerticalScrollIndicator = NO;
            _userDPTableview.scrollEnabled = NO;
            [_userDPTableview registerNib:[UINib nibWithNibName:@"UserCommentCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([UserCommentCell class])];
            [_baseScrView addSubview:_userDPTableview];
            
            [self getdata];
            
            //scr的滑动范围
            //            CGFloat userDPTableviewY = CGRectGetMaxY(_userDPTableview.frame) + 16*BOScreenH/1334;
            //            _baseScrView.contentSize = CGSizeMake(BOScreenW, userDPTableviewY);
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
#pragma mark---写点评的点击事件---
- (void)commentsButtonClick
{
    if (USERUID)
    {
        WriteCommentsOnViewController *wriVc = [[WriteCommentsOnViewController alloc]init];
        __weak typeof(self) weakSelf = self;
        wriVc.callBackBlock = ^(NSString *text){
            [SVProgressHUD setFont:[UIFont systemFontOfSize:14]];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
            [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD setCornerRadius:4.0];
            [SVProgressHUD showImage:nil status:text];
            [SVProgressHUD dismissWithDelay:1];
        
            [weakSelf PlatformForDetailsData];
            [weakSelf getdata];
        };
        
        wriVc.hidesBottomBarWhenPushed = YES;
        //        wriVc.nameString = self.nameOfPlatform;
        wriVc.nameString = _model.name;
        wriVc.ptidStr = _model.ptid;
        wriVc.type = @3;
        [self.navigationController pushViewController:wriVc animated:YES];
    } else
    {
        //登陆界面
        BONoteVerifyLogiin *Logiin = [[BONoteVerifyLogiin alloc]init];
        [self presentViewController:Logiin animated:YES completion:nil];
    }
}
#pragma mark---新手活动的点击事件---
- (void)newsButtonClick
{
    NSArray *newArray = [_model.reg_url componentsSeparatedByString:@"|"];
    if (newArray.count == 2)
    {
        NewActivitiesWebViewController *newVc = [[NewActivitiesWebViewController alloc]init];
        newVc.urlString = newArray[1];
        [self.navigationController pushViewController:newVc animated:YES];
    }else
    {
        _websiteView.newsButton.userInteractionEnabled = NO;
    }
}
#pragma mark---官网的点击事件----
- (void)websiteButtonClick
{
    if (_model.url.length > 0)
    {
        WebsiteWebViewController *websiVc = [[WebsiteWebViewController alloc]init];
        websiVc.urlString = _model.url;
        [self.navigationController pushViewController:websiVc animated:YES];
    }else
    {
        UIAlertController*alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"暂无官网" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            NSLog(@"点击了确定");
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
#pragma mark---一键下载的点击事件---
- (void)terraceAppButtonClick
{
    NSLog(@"一键下载");
    NSArray *integralsArray = [_model.down_url componentsSeparatedByString:@"|"];
    if (integralsArray.count == 1)
    {
        DownloadsViewController *downVc = [[DownloadsViewController alloc]init];
        downVc.urlString = integralsArray[0];
        [self.navigationController pushViewController:downVc animated:YES];
    }else
    {
        UIAlertController*alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"暂无 链接" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            NSLog(@"点击了确定");
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
#pragma mark---微信公众号的点击事件---
- (void)thePublicButtonClick
{
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    NSString *string = _ipcIDView.markLabel.text;
    [pab setString:string];
    if (pab == nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"复制失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了确定");
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"已复制" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了确定");
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.alpha = 1;
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    //把颜色转成图片
//    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
//    //把图片设置为背景
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//}

//接口数据
- (void)getdata
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"ptid"] = self.ptid;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = @"10";
    parameters[@"sid"] = USERSid;
    [manager POST:[NSString stringWithFormat:@"%@WdApi/wdDpList",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            self.dpresultArr = [BiaoQianModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
//            //计算得到cell的总高度
//            for (BiaoQianModel *model in self.dpresultArr)
//            {
//                [_kkkkkk addObject:[NSString stringWithFormat:@"%f",[model topCommentCellHeight]]];
//            }
//            _sum = [_kkkkkk valueForKeyPath:@"@sum.floatValue"];
            
            CGRect frame = self.userDPTableview.frame;
            frame.size.height = [self getTotalHeightWithData:self.dpresultArr];
            self.userDPTableview.frame = frame;
            
//            CGFloat userDPTableviewY = CGRectGetMaxY(_userDPTableview.frame);
//            //设置查看更多点评的按钮位置
//            _lookButton.frame = CGRectMake(200*BOScreenW/750, userDPTableviewY + 25*BOScreenH/1334, 350*BOScreenW/750, 30*BOScreenH/1334);
//            _baseScrView.contentSize = CGSizeMake(BOScreenW, userDPTableviewY + 80*BOScreenH/1334);
//            [self.userDPTableview reloadData];
            _dpnumber = [responseObject[@"count"] integerValue];
            
            if ([responseObject[@"count"] integerValue] == 0)
            {
                _commentsLabel.text = @"用户点评";
                _commentsbutton.userInteractionEnabled = NO;
                _lookButton.hidden = YES;
                
                CGFloat userDPTableviewY = CGRectGetMaxY(_userDPTableview.frame);
                _baseScrView.contentSize = CGSizeMake(BOScreenW, userDPTableviewY + 200*BOScreenH/1334);
                [self.userDPTableview reloadData];

            }else
            {
                _commentsLabel.text = [NSString stringWithFormat:@"用户点评(%@)",responseObject[@"count"]];
                _numberZstring = responseObject[@"count"];
                CGFloat userDPTableviewY = CGRectGetMaxY(_userDPTableview.frame);
                //设置查看更多点评的按钮位置
                _lookButton.frame = CGRectMake(200*BOScreenW/750, userDPTableviewY + 25*BOScreenH/1334, 350*BOScreenW/750, 30*BOScreenH/1334);
                _baseScrView.contentSize = CGSizeMake(BOScreenW, userDPTableviewY + 80*BOScreenH/1334);
                [self.userDPTableview reloadData];
            }
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}

#pragma mark - helpMethod

- (CGFloat)getTotalHeightWithData:(NSArray<BiaoQianModel *> *)datas {
    CGFloat totalHeight = 0;
    for (BiaoQianModel *model in datas) {
        totalHeight += [model topCommentCellHeight];
    }
    return totalHeight;
}
- (void)userCommentCellAlertToLogin:(UserCommentCell *)cell
{
    if (USERUID)
    {
        //        _pidstring = [NSString stringWithFormat:@"%@",cell.commentModel.pid];
        //        [self zanOfTheData];//赞的接口
    } else
    {
        //登陆界面
        [self pushToLoginViewController];
    }
}
- (void)pushToLoginViewController
{
    BONoteVerifyLogiin *noteVerifyLoginVC = [[BONoteVerifyLogiin alloc] init];
    noteVerifyLoginVC.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:noteVerifyLoginVC];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:nil];
}
//登陆成功后的代理
- (void)BONoteVerifyLoginViewControllerDidLoginSucess:(BONoteVerifyLogiin *)loginVc
{
    [self PlatformForDetailsData];
    [self getdata];
}
//赞的接口
- (void)zanOfTheData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"type_id"] = @"5";
    parameters[@"out_id"] = _zanoutIDString;
    [manager POST:[NSString stringWithFormat:@"%@App/star",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            [self getdata];
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
//关注网贷平台
- (void)payAttentionToFriendsData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"uid"] = USERUID;
    parameters[@"ptid"] = _model.ptid;
    [manager POST:[NSString stringWithFormat:@"%@App/focusPingtai",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            [_collectionButton setImage:[UIImage imageNamed:@"icon_shoucangs_pre"] forState:UIControlStateNormal];
            [_rightnagaButton setBackgroundImage:[UIImage imageNamed:@"icon_shoucang_pre"] forState:UIControlStateNormal];
            NSLog(@"返回信息描述88888%@",responseObject[@"msg"]);
        }
        else
        {
            NSLog(@"返回信息描述999999%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
//取消关注网贷平台
- (void)cancellationNoticeData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"uid"] = USERUID;
    parameters[@"ptid"] = _model.ptid;
    [manager POST:[NSString stringWithFormat:@"%@App/cancelFocusPt",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            [_collectionButton setImage:[UIImage imageNamed:@"icon_shoucangs_nor"] forState:UIControlStateNormal];
            [_rightnagaButton setBackgroundImage:[UIImage imageNamed:@"icon_shoucang_nor"] forState:UIControlStateNormal];
            NSLog(@"返回信息描述666666%@",responseObject[@"msg"]);
        }
        else
        {
            NSLog(@"返回信息描述77777%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}

@end
