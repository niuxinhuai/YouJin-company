//
//  SignInViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "SignInViewController.h"
#import "UIImage+UIColor.h"
#import "TopSignView.h"
#import "SignPageTableViewCell.h"
#import "MasksView.h"
#import "SignRulesViewController.h"
#import "CheckAnswerViewController.h"
#import "SignInsModel.h"
#import "SignInPageModel.h"
#import "ShareManager.h"

@interface SignInViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic ,strong)MasksView *masView;//遮罩view
@property (nonatomic ,strong)TopSignView *topSiView;//阅读签到 和 签到的view
@property (nonatomic ,copy)NSString *nsuserStr;//纯值
@property (nonatomic ,copy)NSString *statusStr;//判断是否已经签到
@end

@implementation SignInViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"签到"];
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    _nsuserStr = @"789";
    self.view.backgroundColor = [UIColor whiteColor];
    //底部滑动的scrview
    UIScrollView *homeScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    homeScrView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    homeScrView.showsVerticalScrollIndicator = NO;
//    homeScrView.contentSize = CGSizeMake(BOScreenW, 2397*BOScreenH/1334+64);
    homeScrView.contentSize = CGSizeMake(BOScreenW, BOScreenH);
    [self.view addSubview:homeScrView];
    
    //阅读签到 和 签到的view
//    _topSiView = [[TopSignView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 832*BOScreenH/1334)];
    _topSiView = [[TopSignView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 280*BOScreenH/1334)];
    [_topSiView.sigInButton addTarget:self action:@selector(sigInButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_topSiView.fouButton addTarget:self action:@selector(fouButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_topSiView.shoutButton addTarget:self action:@selector(shoutButtonClick) forControlEvents:UIControlEventTouchUpInside];//喊好友签到的按钮
    [homeScrView addSubview:_topSiView];
    
//    //热门活动
//    CGFloat topSiViewY = CGRectGetMaxY(_topSiView.frame);
//    UITableView *hotTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, topSiViewY, BOScreenW, 1565*BOScreenH/1334) style:UITableViewStylePlain];
//    hotTableView.delegate = self;
//    hotTableView.dataSource = self;
//    hotTableView.scrollEnabled = NO;
//    hotTableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    [homeScrView addSubview:hotTableView];
    
    //遮罩view
    _masView = [[MasksView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    [[UIApplication sharedApplication].keyWindow addSubview:_masView];
//    [self.navigationController.view addSubview:_masView];
    //签到页面 叉号的点击事件
    [_masView.crossBtn addTarget:self action:@selector(crossBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //签到规则的点击事件
    [_masView.theRulesBtn addTarget:self action:@selector(theRulesBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //添加手势单击事件
    UITapGestureRecognizer *Gess = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GesClicks:)];
    Gess.delegate = self;
    Gess.numberOfTapsRequired = 1;
    [_masView addGestureRecognizer:Gess];
    _masView.hidden = YES;
    
    [self signInPageData];//签到页面的数据
    
//    NSLog(@"_statusStrggg%@",_statusStr);
//    if ([self.numberString isEqualToString:@"shouye"])
//    {
//        NSLog(@"_statusStrhhhh%@",_statusStr);
//        if ([resp])
//        {
//            [self dailyCheckData];//判断是否签到数据接口
//        }else
//        {
//            [self dailyCheckData];//判断是否签到数据接口
//        }
//    } else
//    {
//        NSLog(@"我的");
//        [self dailyCheckData];//每日签到的数据
//    }

    
//    if ([self.numberString isEqualToString:@"shouye"])
//    {
//    } else
//    {
//        NSLog(@"我的");
//        [self dailyCheckData];//每日签到的数据
//    }
        if ([self.numberString isEqualToString:@"wode"])
        {
            [self dailyCheckData];//每日签到的数据
        }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellString = @"cell";
    SignPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[SignPageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    //点击cell没有阴影
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 290*BOScreenH/1334;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    return 30*BOScreenH/1334;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 30*BOScreenH/1334)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
#pragma mark---签到的点击按钮---
- (void)sigInButtonClick
{
//    _masView.hidden = NO;
    [self dailyCheckData];//判断是否签到数据接口
}
#pragma mark---遮罩view的单击手势事件---
- (void)GesClicks:(UITapGestureRecognizer *)sender
{
    _masView.hidden = YES;
    [self dailyCheckData];//判断是否签到数据接口
    [self signInPageData];//签到页面数据接口
}
#pragma mark---单击手势的代理---
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:_masView.aFewDaysImage])
    {
        return NO;
    }
    return YES;
}
#pragma mark---点击签到显示的叉号---
- (void)crossBtnClick
{
    _masView.hidden = YES;
    [self signInPageData];//签到页面数据接口
}
#pragma mark---签到规则的点击事件---
- (void)theRulesBtnClick
{
    _masView.hidden = YES;
    SignRulesViewController *signVc = [[SignRulesViewController alloc]init];
    [self.navigationController pushViewController:signVc animated:YES];
}
#pragma mark---阅读签到下面的四个button的点击事件---
- (void)fouButtonClick:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 1000:
        {
            NSLog(@"11111");
            break;
        }
        case 1001:
        {
            NSLog(@"22222");
            break;
        }
        case 1002:
        {
            NSLog(@"3333");
            break;
        }
        case 1003:
        {
            CheckAnswerViewController *datVc = [[CheckAnswerViewController alloc]init];
            [self.navigationController pushViewController:datVc animated:YES];
            NSLog(@"44444");
            break;
        }
            
        default:
            break;
    }
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark---判断是否签到数据接口----
- (void)dailyCheckData
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"uid"] = USERUID;
    [manager POST:[NSString stringWithFormat:@"%@App/signin",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"签到的接口数据是真的醉了嗯啊%@",responseObject);
        if ([responseObject[@"r"] integerValue] == 1)
        {
                _masView.hidden = NO;
                [self signInPageData];//签到页面数据接口
                [_topSiView.sigInButton setTitle:@"" forState:UIControlStateNormal];
                [_topSiView.sigInButton setBackgroundImage:[UIImage imageNamed:@"btn_qiandao_dis"] forState:UIControlStateNormal];
                _topSiView.sigInButton.userInteractionEnabled = NO;
            
            SignInsModel *model = [SignInsModel mj_objectWithKeyValues:responseObject[@"data"]];
            _masView.item = model;
        }else if ([responseObject[@"r"] integerValue] == 0)
        {
            _masView.hidden = YES;
            [_topSiView.sigInButton setTitle:@"" forState:UIControlStateNormal];
            [_topSiView.sigInButton setBackgroundImage:[UIImage imageNamed:@"btn_qiandao_dis"] forState:UIControlStateNormal];
            _topSiView.sigInButton.userInteractionEnabled = NO;
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
#pragma mark---签到页面数据接口----
- (void)signInPageData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"uid"] = USERUID;
    [manager POST:[NSString stringWithFormat:@"%@App/signinPageInfo",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"opopopopopopop%@",responseObject);
        if ([responseObject[@"r"] integerValue] == 1)
        {
            SignInPageModel *model = [SignInPageModel mj_objectWithKeyValues:responseObject[@"base"]];
            _topSiView.item = model;
            //判断返回的值是否已经签到
            _statusStr = responseObject[@"status"];
            
//            NSLog(@"_statusStrggg%@",_statusStr);
            if ([self.numberString isEqualToString:@"shouye"])
            {
//                NSLog(@"_statusStrhhhh%@",_statusStr);
                if ([responseObject[@"status"] intValue] == 1)
                {
                    [_topSiView.sigInButton setTitle:@"" forState:UIControlStateNormal];
                    [_topSiView.sigInButton setBackgroundImage:[UIImage imageNamed:@"btn_qiandao_dis"] forState:UIControlStateNormal];
                    _topSiView.sigInButton.userInteractionEnabled = NO;
//                    [self dailyCheckData];//判断是否签到数据接口
                }else
                {
                    
                }
            }
        }else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
//喊好友签到的点击事件
- (void)shoutButtonClick
{
    ShareManager *manager = [ShareManager shareManagerStandardWithDelegate:nil];
    [manager shareInView:self.view text:@"金融界的大众点评，每天上百万人在这里进行理财交流，你也一起来玩转理财吧。" image:[UIImage imageNamed:@"LOGO"] url:[NSString stringWithFormat:@"%@mobile/page/invitationFriendsrRegister.html",BASEWEBURl] title:@"快来领现金奖励，人人有份" objid:nil];
}
@end
