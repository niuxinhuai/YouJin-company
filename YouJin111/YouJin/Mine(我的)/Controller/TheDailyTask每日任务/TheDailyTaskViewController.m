//
//  TheDailyTaskViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "TheDailyTaskViewController.h"
#import "UIImage+UIColor.h"
#import "TheDailyTaskTableViewCell.h"
#import "SignInViewController.h"
#import "ShareViewController.h"
#import "MoreTaskViewController.h"
#import "DailyTaskModel.h"

@interface TheDailyTaskViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)NSArray *colorArr;//存放圆角大色块的颜色
@property (nonatomic ,strong)NSArray *logoArr;//存放logo的名字
@property (nonatomic ,strong)NSMutableArray *sevenOnArr;//每日签到等等
@property (nonatomic ,strong)NSArray *rewardArr;//奖励
@property (nonatomic ,strong)NSArray *goToArr;//去签到
@property (nonatomic ,strong)UITableView *taskTableView;//每日任务的tableview
@property (nonatomic ,strong)UIView *shareView;//第五区的区未view
@property (nonatomic ,assign)BOOL openShut;//判断展开和收缩
@property (nonatomic ,assign)float FooterInSectionheig;//记录五区未的高度
@property (nonatomic ,strong)DailyTaskModel *model;//tableview的model
@end

@implementation TheDailyTaskViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"每日任务"];
//    // 设置leftButtonItem
//    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
//    self.navigationItem.leftBarButtonItem = btnItem;
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    //rightBarButtonItem
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,130*BOScreenW/750,40*BOScreenH/1334)];
    [rightButton setTitle:@"U币规则" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithHexString:@"#ffffff" alpha:1] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
   // self.navigationItem.rightBarButtonItem = rightBtnItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    self.numberS = @"shouye";
    [self theDailyTaskData];//接口数据
    _FooterInSectionheig = 0.001;//记录五区未的高度
    _openShut = YES;//判断是展开还是收缩
    _colorArr = [[NSArray alloc]initWithObjects:@"#ff667a",@"#fea54c",@"#4dbbfa",@"#4dbbfa",@"#4dbbfa",@"#6dc772",@"#fea54c", nil];
    _logoArr = [[NSArray alloc]initWithObjects:@"mission_icon_mrqd",@"mission_icon_yqhy",@"mission_icon_fbdp",@"mission_icon_fbdt",@"mission_icon_fbpl",@"mission_icon_fxrw",@"mission_icon_gdrw", nil];
    _sevenOnArr = [[NSMutableArray alloc]initWithObjects:@"每日签到",@"邀请好友",@"发表点评",@"发表动态",@"发表评论",@"分享任务",@"", nil];
    _rewardArr = [[NSArray alloc]initWithObjects:@"50-300",@"1000",@"100／次",@"100",@"20／次",@"10",@"", nil];
    _goToArr = [[NSArray alloc]initWithObjects:@"去签到",@"去邀请",@"",@"去发表",@"",@"",@"", nil];
    
//    //每日任务tableView
//    _taskTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64) style:UITableViewStyleGrouped];
//    _taskTableView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
//    _taskTableView.delegate = self;
//    _taskTableView.dataSource = self;
//    _taskTableView.showsVerticalScrollIndicator = NO;
//    _taskTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:_taskTableView];
    
    //区未的view
    [self viewForFooter];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellString = @"cell";
    TheDailyTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"vvvv"];
    if (cell == nil)
    {
        cell = [[TheDailyTaskTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.leftView.backgroundColor = [UIColor colorWithHexString:_colorArr[indexPath.section] alpha:1];
    cell.logeImageView.image = [UIImage imageNamed:_logoArr[indexPath.section]];
    cell.sevenOnLabel.text = _sevenOnArr[indexPath.section];
    
    //label中间添加图片
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"奖励:  %@",_rewardArr[indexPath.section]]];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"common_icon_ub"];
    attch.bounds = CGRectMake(0, -2, 27*BOScreenW/750, 27*BOScreenW/750);
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:4];//在第几个文字后面
    cell.awardLabel.attributedText = attri;
    //字体显示两种颜色
    NSRange nineredRangeTwo = NSMakeRange([[attri string] rangeOfString:_rewardArr[indexPath.section]].location, [[attri string] rangeOfString:_rewardArr[indexPath.section]].length);
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5a00" alpha:1] range:nineredRangeTwo];
    [cell.awardLabel setAttributedText:attri];
    [cell.awardLabel sizeToFit];

    if (indexPath.section == 6)
    {
        cell.sevenOnLabel.hidden = YES;
        cell.awardLabel.hidden = YES;
    }
    //去签到
    [cell.goToBtn setTitle:_goToArr[indexPath.section] forState:UIControlStateNormal];
    if (indexPath.section == 0)
    {
        if ([_model.is_signin intValue]==1)
        {
            [cell.goToBtn setTitle:@"已签到" forState:UIControlStateNormal];
        }else
        {
            [cell.goToBtn setTitle:@"去签到" forState:UIControlStateNormal];
        }
    }
    if (indexPath.section == 2 || indexPath.section >3)
    {
        cell.goToBtn.hidden = YES;
    }
    
    //1/5 3/5
    cell.fiveLabel.hidden = YES;
    if (indexPath.section == 2)
    {
        cell.fiveLabel.hidden = NO;
        NSLog(@"_model.dianping_num%@",_model.dianping_num);
        NSString *fiveStr = _model.dianping_num;
        cell.fiveLabel.text = [NSString stringWithFormat:@"%@/5",_model.dianping_num];
        //字体显示两种颜色
        NSMutableAttributedString *attris = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@／5",fiveStr]];
        NSRange nineredRangeTwos = NSMakeRange([[attris string] rangeOfString:fiveStr].location, [[attris string] rangeOfString:fiveStr].length);
        [attris addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5a00" alpha:1] range:nineredRangeTwos];
        [cell.fiveLabel setAttributedText:attris];
    }
    if (indexPath.section == 4)
    {
        cell.fiveLabel.hidden = NO;
        NSString *fivesStr = _model.pinglun_num;
        cell.fiveLabel.text = [NSString stringWithFormat:@"%@/5",fivesStr];
        //字体显示两种颜色
        NSMutableAttributedString *attris = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@／5",fivesStr]];
        NSRange nineredRangeTwos = NSMakeRange([[attris string] rangeOfString:fivesStr].location, [[attris string] rangeOfString:fivesStr].length);
        [attris addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5a00" alpha:1] range:nineredRangeTwos];
        [cell.fiveLabel setAttributedText:attris];
    }
    
    //分享任务 3/5的Label
    cell.oneLabel.hidden = YES;
    cell.oneButton.hidden = YES;
    if (indexPath.section == 5)
    {
        cell.oneLabel.hidden = NO;
        cell.oneButton.hidden = NO;
        
        NSString *oneString = _model.share_num;
        //label中间添加图片
        NSMutableAttributedString *attriss = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@／5 ",oneString]];
        NSTextAttachment *attchss = [[NSTextAttachment alloc] init];
        attchss.image = [UIImage imageNamed:@"common_icon_xiala"];
        attchss.bounds = CGRectMake(0, 2, 14*BOScreenW/750, 8*BOScreenW/750);
        NSAttributedString *stringss = [NSAttributedString attributedStringWithAttachment:attchss];
        [attriss insertAttributedString:stringss atIndex:4];//在第几个文字后面
        cell.oneLabel.attributedText = attriss;
        //字体显示两种颜色
        NSRange nineredRangeTwoss = NSMakeRange([[attriss string] rangeOfString:oneString].location, [[attriss string] rangeOfString:oneString].length);
        [attriss addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5a00" alpha:1] range:nineredRangeTwoss];
        [cell.oneLabel setAttributedText:attriss];
    }
    
    //更多每日任务，请戳这里～
    cell.lastLabel.hidden = YES;
    if (indexPath.section == 6)
    {
        cell.lastLabel.hidden = NO;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//点击没有阴影
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170*BOScreenH/1334;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 30*BOScreenH/1334;
    }
    return 20*BOScreenH/1334;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 30*BOScreenH/1334)];
    bgview.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    return bgview;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        SignInViewController *sigViewController = [[SignInViewController alloc]init];
        sigViewController.hidesBottomBarWhenPushed = YES;
        sigViewController.numberString = self.numberS;
        [self.navigationController pushViewController:sigViewController animated:YES];
    }
    if (indexPath.section == 1)
    {
        ShareViewController *shareVc = [[ShareViewController alloc]init];
        shareVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shareVc animated:YES];
    }
    if (indexPath.section == 3)
    {
        self.tabBarController.selectedIndex = 3;
    }
    if (indexPath.section == 5)
    {
        if (_openShut)
        {
            _shareView.hidden = NO;
            _FooterInSectionheig = 450*BOScreenH/1334;
            [_taskTableView reloadData];
            _openShut = NO;
        }else
        {
            _shareView.hidden = YES;
            _FooterInSectionheig = 0.001;
            [_taskTableView reloadData];
            _openShut = YES;
        }
    }
    if (indexPath.section == 6)
    {
        MoreTaskViewController *moreVc = [[MoreTaskViewController alloc]init];
        [self.navigationController pushViewController:moreVc animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 5)
    {
        return _FooterInSectionheig;
    }
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 5)
    {
        return _shareView;
    }
    return nil;
}
#pragma mark---区未的view---
- (void)viewForFooter
{
    //五个分享的view
    _shareView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 0, 690*BOScreenW/750, 450*BOScreenH/1334)];
    _shareView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 0, 690*BOScreenW/750, 450*BOScreenH/1334)];
    bgview.backgroundColor =[UIColor whiteColor];
    [_shareView addSubview:bgview];
    
    NSArray *shareArr = @[@"分享头条",@"分享车贷排行榜",@"分享活期排行榜",@"分享有金评级",@"分享示范基金"];
    for (int i = 0; i < 5; i ++)
    {
        //绿色的小圆点
        UIView *greenView = [[UIView alloc]initWithFrame:CGRectMake(20*BOScreenW/750, 38*BOScreenH/1334+i*(14*BOScreenW/750 + 76*BOScreenH/1334), 14*BOScreenW/750, 14*BOScreenW/750)];
        greenView.backgroundColor = [UIColor colorWithHexString:@"#6dc772" alpha:1];
        greenView.layer.cornerRadius = 3;
        greenView.layer.masksToBounds = YES;
        [bgview addSubview:greenView];
        //五个分享Label
        UILabel *shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(54*BOScreenW/750, 25*BOScreenH/1334 + i*(40*BOScreenH/1334 + 50*BOScreenH/1334), 300*BOScreenW/750, 40*BOScreenH/1334)];
        shareLabel.text = shareArr[i];
        shareLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
        shareLabel.font = [UIFont systemFontOfSize:16];
        [bgview addSubview:shareLabel];
        
        //五个奖励Label
        UILabel   *_awardLabel = [[UILabel alloc]init];
        _awardLabel.text = @"奖励:  10";
        _awardLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        _awardLabel.font = [UIFont systemFontOfSize:13];
        
        //根据字体得到NSString的尺寸
        CGSize sizes = [_awardLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_awardLabel.font,NSFontAttributeName, nil]];
        //名字的W
        CGFloat nameWs = sizes.width;
        _awardLabel.frame = CGRectMake(364*BOScreenW/750, 25*BOScreenH/1334 + i*(40*BOScreenH/1334 + 50*BOScreenH/1334), nameWs,40*BOScreenH/1334);
        [bgview addSubview:_awardLabel];
        
        //label中间添加图片
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@"奖励:  10"];
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        attch.image = [UIImage imageNamed:@"common_icon_ub"];
        attch.bounds = CGRectMake(0, -2, 27*BOScreenW/750, 27*BOScreenW/750);
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        [attri insertAttributedString:string atIndex:4];//在第几个文字后面
        _awardLabel.attributedText = attri;
        
        //字体显示两种颜色
        NSRange nineredRangeTwo = NSMakeRange([[attri string] rangeOfString:@"10"].location, [[attri string] rangeOfString:@"10"].length);
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5a00" alpha:1] range:nineredRangeTwo];
        [_awardLabel setAttributedText:attri];
        [_awardLabel sizeToFit];
        
        //五个对号
        UIImageView *checkImage = [[UIImageView alloc]initWithFrame:CGRectMake(628*BOScreenW/750, 30*BOScreenH/1334 + i*(30*BOScreenH/1334 + 60*BOScreenH/1334), 42*BOScreenW/750, 30*BOScreenH/1334)];
        checkImage.image = [UIImage imageNamed:@"mission_img_finish"];
        [bgview addSubview:checkImage];
    }
    for (int i = 0; i < 4; i ++)
    {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(54*BOScreenW/750, 89*BOScreenH/1334+i*(90*BOScreenH/1334), 636*BOScreenW/750, 1*BOScreenH/1334)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
        [bgview addSubview:lineView];
    }
    _shareView.hidden = YES;
}
#pragma mark---每日任务的接口---
- (void)theDailyTaskData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"uid"] = USERUID;
    [manager POST:[NSString stringWithFormat:@"%@Ucenter/dayTaskInfo",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"ffffffffff%@",responseObject);
        if ([responseObject[@"r"] integerValue] == 1)
        {
            _model = [DailyTaskModel mj_objectWithKeyValues:responseObject[@"info"]];
            
            //每日任务tableView
            _taskTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64) style:UITableViewStyleGrouped];
            _taskTableView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
            _taskTableView.delegate = self;
            _taskTableView.dataSource = self;
            _taskTableView.showsVerticalScrollIndicator = NO;
            _taskTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self.view addSubview:_taskTableView];
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
