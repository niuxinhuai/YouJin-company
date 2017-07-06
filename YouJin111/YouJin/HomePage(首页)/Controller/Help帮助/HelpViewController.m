//
//  HelpViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HelpViewController.h"
#import "UIImage+UIColor.h"
#import "HotIssueTableViewCell.h"
#import "AboutYoujinViewController.h"
#import "AboutYoujindetailViewController.h"
#import "QYSDK.h"


@interface HelpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UIScrollView *baseScrView;//底部滑动的scrView
@property(nonatomic ,strong)NSMutableArray *buttonBgImageArray;//六个按钮背景图片的array
@property(nonatomic ,strong)NSMutableArray *sixLabelArrray;//六个labeltext Array
@property(nonatomic ,strong)NSMutableArray *hotIssueArr;//热门问题的数据
@property (nonatomic ,strong)NSMutableArray *detailNextArr;//问题详情页的数据


@property (nonatomic ,strong)NSMutableArray *youjinArr;
@property (nonatomic ,strong)NSMutableArray *youjinArrs;

@property (nonatomic ,strong)NSMutableArray *toutiaoArr;
@property (nonatomic ,strong)NSMutableArray *toutiaoArrs;

@property (nonatomic ,strong)NSMutableArray *qvjinArr;
@property (nonatomic ,strong)NSMutableArray *qvjinArrs;

@property (nonatomic ,strong)NSMutableArray *dongtaiArr;
@property (nonatomic ,strong)NSMutableArray *dongtaiArrs;

@property (nonatomic ,strong)NSMutableArray *ubiArr;
@property (nonatomic ,strong)NSMutableArray *ubiArrs;

@end

@implementation HelpViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.title = @"帮助";
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"帮助"];
//    // 设置leftButtonItem
//    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
//    self.navigationItem.leftBarButtonItem = btnItem;
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    //热门问题的五个cell
    _hotIssueArr = [[NSMutableArray alloc]initWithObjects:@"有金是什么？",@"为什么我不能发表头条文章？",@"什么是取金？",@"U币是什么？",@"U币有什么用途？", nil];
    //下一页问题详情的数据
    _detailNextArr = [[NSMutableArray alloc]initWithObjects:@"你好，有金是柚今科技旗下国内首个专注金融点评的APP，是金融与社交相结合的产品。",@"你好，目前头条文章仅对有金号开放，您可以在头条页面选择[有金号]>[申请]，根据页面提示操作进行申请。",@"你好，取金是有金推出的一个奖励版块，完成相应的取金，可以获取U币，U币可以用来打赏、提现等。",@"你好，U币是有金APP的内部积分，是用户完成相应任务后得到的积分奖励。",@"你好，目前U币有以下几种用途：1、头条文章的打赏；2、兑换现金；3、积分商城内兑换商品；4、积分商城内抽奖；5、提现。", nil];
    
    
    _youjinArr = [NSMutableArray arrayWithObjects:@"有金是什么？", @"如何登录有金？",@"登录有金提示密码错误怎么办？",@"昵称设置规则？", nil];
    _youjinArrs = [NSMutableArray arrayWithObjects:@"你好，有金是柚今科技旗下国内首个专注金融点评的APP，是金融与社交相结合的产品。", @"你好，目前登录有金有以下三个方法：1、通过手机号码登录，2、通过微信、微博、QQ第三方账号登录。",@"你好，如忘记密码您可以使用验证码登录，在设置中根据页面提示操作重置密码即可。",@"你好，昵称最多可设置7个汉字或15个字符，可设置含有中文、英文、数字组合的昵称，但不建议设置特殊符号。", nil];
    
    
    
    _toutiaoArr = [[NSMutableArray alloc]initWithObjects:@"为什么我不能发表头条文章？", @"企业怎么申请有金号？",@"个人怎么申请有金号？",@"为什么我发布的头条文章看不到？",@"为什么我的头条文章被删了？",@"发现内容质量问题？",@"如何分享头条文章？", nil];
    _toutiaoArrs = [[NSMutableArray alloc]initWithObjects:@"你好，目前头条文章仅对有金号开放，您可以在头条页面选择[有金号]>[申请]，根据页面提示操作进行申请。", @"你好，您可以选择[申请]>[企业申请]，企业申请需要上传的材料有公司名称、公司官网、运营者姓名和盖有公章的营业执照复印件。我们会在1个工作日内完成审核并反馈结果。",@"你好，您可以选择[申请]>[自媒体申请]，自媒体申请需要上传的资料有真实姓名和个人说明。自媒体提交申请后在30日内发布一篇有效头条文章即可审核通过。",@"你好，如您申请的是自媒体有金号，在申请后30日内发布头条文章需要审核，30日后则无需审核。",@"你好，被删帖的原因，可能是文章存在违规内容或者是被网友举报过多，如果您需要申诉，可以选择[在线客服]一栏反馈，我们会尽快与您联系。",@"你好，当您发现这类问题时，可以在文章底部选择[投诉]一栏反馈，我们欢迎您积极反馈这类问题。",@"你好，当您想要分享该篇文章时，点击下方栏中的分享按钮，选择希望分享的渠道图标即可。", nil];
    
    _qvjinArr = [[NSMutableArray alloc]initWithObjects:@"什么是取金？",@"完成取金U币奖励要多久才到？",@"哪里可以看到我的任务完成情况？",@"我完成了取金为什么没有U币奖励？", nil];
    _qvjinArrs = [[NSMutableArray alloc]initWithObjects:@"你好，取金是有金推出的一个奖励版块，完成相应的取金，可以获取U币，U币可以用来打赏、提现等。", @"你好，您申请提交后，经我们审核通过后，一般会在1~2工作日内发放到您的账户。",@"你好，您可以在我的界面选择[u币]>[收支明细]>[取金记录]，查看完成情况。",@"你好，没有U币奖励的原因可能有：1.您未从取金页面参加（从其它页面完成无法获得U币奖励）。2.您没有按照取金页的要求完成。3.您的账号存在问题（如作弊、账号异常等）。", nil];
    
    _dongtaiArr = [[NSMutableArray alloc]initWithObjects:@"动态发表规则？",@"我不能发布动态？", nil];
    _dongtaiArrs = [[NSMutableArray alloc]initWithObjects:@"你好，我们鼓励用户自发地分享财经消息和对金融行情的观点，但反对利用动态进行如下行为或传播如下内容：1.诱导行为：利诱、胁迫、煽动其他用户等以达到目的行为。2.谣言：如**贷跑路等。对企业或个人进行没有依据地的恶意攻击或者严重侵权。3.违反国家法律法规：如分裂国家、贩卖毒品枪支、涉黑涉暴、色情、非法博彩、诈骗等违法违规的内容。4.其它干扰动态正常使用的行为：如过度发布动态导致刷屏等。若出现上述行为或内容，一经发现或者被举报，我们会进行严格处理。",@"你好，如您违反规则将有可能被限制发布动态。您可通过[在线客服]进行申诉。", nil];

    _ubiArr = [[NSMutableArray alloc]initWithObjects:@"U币是什么？",@"U币有什么用途？",@"U币怎么获得？",@"我的U币流水在哪里查看？",@"U币在哪里提现？",@"U币提现规则？",@"U币提现需要身份认证吗？",@"支付密码忘了怎么办？",@"我申请了提现，多久才能收到现金？", nil];
    _ubiArrs = [[NSMutableArray alloc]initWithObjects:@"你好，U币是有金APP的内部积分，是用户完成相应任务后得到的积分奖励。",@"你好，目前U币有以下几种用途：1、头条文章的打赏；2、兑换现金；3、积分商城内兑换商品；4、积分商城内抽奖；5、提现。", @"你好，目前U币可以通过完成每日任务和取金任务获得。",@"你好，您可以在我的界面选择[u币]>[收支明细]，查看U币的收入和支出。",@"你好，您可以在我的界面选择[u币]>[提现]，选择相对应的提现金额即可。",@"你好，10000U币可兑换1元人民币。目前我们仅支持提现到微信钱包。",@"你好，您的微信钱包必须是通过实名制认证才可以完成提现。目前我们为了加强账户完全，添加了支付密码功能，请您先设置您的支付密码。",@"你好，如忘记支付密码，您可以在支付密码界面根据页面提示操作重置密码即可。",@"你好，在您申请提现后一个工作日（24小时）内，您申请的金额将会打入您的微信账户。", nil];
    
    //六个按钮的背景图片
    _buttonBgImageArray = [[NSMutableArray alloc]initWithObjects:@"icon_gyyj",@"icon_ttwt",@"icon_qjwt",@"icon_dtwt",@"icon_ubwt",@"icon_qtzx", nil];
    //六个label text
    _sixLabelArrray = [[NSMutableArray alloc]initWithObjects:@"关于有金",@"头条问题",@"取金问题",@"动态问题",@"U币问题",@"其他咨询", nil];
    
    //底部滑动的scr
    _baseScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    _baseScrView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _baseScrView.showsVerticalScrollIndicator = NO;
    _baseScrView.contentSize = CGSizeMake(BOScreenW, 1229*BOScreenH/1334 + 64 + 90*BOScreenH/1334);
    [self.view addSubview:_baseScrView];
    
    //设置顶部的图片
    UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 300*BOScreenH/1334)];
    topImage.image = [UIImage imageNamed:@"HELPbanner"];
    [_baseScrView addSubview:topImage];
    
    //设置六个按钮
    [self setSixButton];
    
    //创建底部的tableview
    UITableView *hotTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 800*BOScreenH/1334, BOScreenW, 519*BOScreenH/1334) style:UITableViewStylePlain];
    hotTableView.delegate = self;
    hotTableView.dataSource = self;
    hotTableView.scrollEnabled = NO;
    [_baseScrView addSubview:hotTableView];
}
#pragma mark---设置六个按钮---
- (void)setSixButton
{
    UIView *buttonbgView = [[UIView alloc]initWithFrame:CGRectMake(0, 300*BOScreenH/1334, BOScreenW, 500*BOScreenH/1334)];
    buttonbgView.backgroundColor = [UIColor whiteColor];
    [_baseScrView addSubview:buttonbgView];
    
    UIView *onelineView = [[UIView alloc]initWithFrame:CGRectMake(0, 249*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
    onelineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
    [buttonbgView addSubview:onelineView];
    
    for (int i = 0; i < 2; i++)
    {
        UIView *twoLineView = [[UIView alloc]initWithFrame:CGRectMake(250*BOScreenW/750 + i*(250*BOScreenW/750+1*BOScreenW/750), 0, 1*BOScreenW/750, 500*BOScreenH/1334)];
        twoLineView.backgroundColor =[UIColor colorWithHexString:@"#dfe3e6" alpha:1];
        [buttonbgView addSubview:twoLineView];
    }
    
    for (int i =0; i < 6; i++)
    {
        int indexX = i%3;
        int indexY = i/3;
        UIButton *sixbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        sixbutton.frame = CGRectMake(70*BOScreenW/750 + indexX*(110*BOScreenW/750 + 140*BOScreenW/750), 48*BOScreenH/1334 + indexY*(110*BOScreenW/750 + 140*BOScreenH/1334), 110*BOScreenW/750, 110*BOScreenW/750);
        [sixbutton setBackgroundImage:[UIImage imageNamed:_buttonBgImageArray[i]] forState:UIControlStateNormal];
        sixbutton.tag = 100+i;
        [sixbutton addTarget:self action:@selector(sixbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonbgView addSubview:sixbutton];
        
        UILabel *sixLabel = [[UILabel alloc]initWithFrame:CGRectMake(40*BOScreenW/750 + indexX*(170*BOScreenW/750 + 80*BOScreenW/750), 173*BOScreenH/1334 + indexY*(215*BOScreenH/1334 + 30*BOScreenH/1334), 170*BOScreenW/750, 40*BOScreenH/1334)];
        sixLabel.text = _sixLabelArrray[i];
        sixLabel.textAlignment = NSTextAlignmentCenter;
        sixLabel.font = [UIFont systemFontOfSize:13];
        sixLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        [buttonbgView addSubview:sixLabel];
    }
}
#pragma mark---tableview代理---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90*BOScreenH/1334;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellString = @"cell";
    UINib *nib = [UINib nibWithNibName:@"HotIssueTableViewCell" bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:cellString];
    
    HotIssueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[HotIssueTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.problemLabel.text = _hotIssueArr[indexPath.row];
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70*BOScreenH/1334;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerbgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 70*BOScreenH/1334)];
    headerbgView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 15*BOScreenH/1334, 150*BOScreenW/750, 40*BOScreenH/1334)];
    headerLabel.text = @"热门问题";
    headerLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    headerLabel.font = [UIFont systemFontOfSize:13];
    [headerbgView addSubview:headerLabel];
    return headerbgView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AboutYoujindetailViewController *aboVc = [[AboutYoujindetailViewController alloc]init];
    aboVc.titleViewString = @"问题详情";
    aboVc.problomString = _hotIssueArr[indexPath.row];
    aboVc.detailString = _detailNextArr[indexPath.row];
    [self.navigationController pushViewController:aboVc animated:YES];
}
#pragma mark---六个按钮的点击事件---
- (void)sixbuttonClick:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 100:
        {
            AboutYoujinViewController *aboutVc = [[AboutYoujinViewController alloc] init];
            aboutVc.titleviewstr = @"关于有金";
            aboutVc.numberArr = _youjinArr;
            aboutVc.detailArr = _youjinArrs;
            [self.navigationController pushViewController:aboutVc animated:YES];
            break;
        }
        case 101:
        {
            AboutYoujinViewController *aboutVc = [[AboutYoujinViewController alloc] init];
            aboutVc.titleviewstr = @"头条问题";
            aboutVc.numberArr = _toutiaoArr;
            aboutVc.detailArr = _toutiaoArrs;
            [self.navigationController pushViewController:aboutVc animated:YES];
            break;
        }
        case 102:
        {
            AboutYoujinViewController *aboutVc = [[AboutYoujinViewController alloc] init];
            aboutVc.titleviewstr = @"取金问题";
            aboutVc.numberArr = _qvjinArr;
            aboutVc.detailArr = _qvjinArrs;
            [self.navigationController pushViewController:aboutVc animated:YES];
            break;
        }
        case 103:
        {
            AboutYoujinViewController *aboutVc = [[AboutYoujinViewController alloc] init];
            aboutVc.titleviewstr = @"动态问题";
            aboutVc.numberArr = _dongtaiArr;
            aboutVc.detailArr = _dongtaiArrs;
            [self.navigationController pushViewController:aboutVc animated:YES];
            break;
        }
        case 104:
        {
            AboutYoujinViewController *aboutVc = [[AboutYoujinViewController alloc] init];
            aboutVc.titleviewstr = @"U币问题";
            aboutVc.numberArr = _ubiArr;
            aboutVc.detailArr = _ubiArrs;
            [self.navigationController pushViewController:aboutVc animated:YES];
            break;
        }
        case 105:
        {
            [self pushToServiceController];
            break;
        }

        default:
            break;
    }
}
#pragma mark - 在线客服中返回我的
- (void)backMine {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushToServiceController {
    QYSource *source = [[QYSource alloc] init];
    source.title =  @"我的";
    source.urlString = @"https://8.163.com/";
    QYSessionViewController *sessionViewController = [[QYSDK sharedSDK] sessionViewController];
    sessionViewController.sessionTitle = @"在线客服";
    sessionViewController.source = source;
    sessionViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(backMine)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    sessionViewController.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController pushViewController:sessionViewController animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    // [self presentViewController:nav animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
