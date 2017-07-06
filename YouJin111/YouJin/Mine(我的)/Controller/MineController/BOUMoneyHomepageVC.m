//
//  BOUMoneyHomepageVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOUMoneyHomepageVC.h"
#import "BOUMoneyBillVC.h"
#import "BOUMoneyRuleVC.h"
#import "BOUMoneyRankVC.h"
#import "BOWithdrawDepositVC.h"
#import "SetPayPasswordViewController.h"
#import "UMoneyPageItem.h"
#import "ResetLoginPasswordVC.h"
@interface BOUMoneyHomepageVC ()
@property (nonatomic, weak) UIView *topView;

@property (nonatomic, weak) AFHTTPSessionManager *mgr;

/**保存请求到数据的item*/
@property (nonatomic, strong) UMoneyPageItem *item;

/**记录金币总数的label*/
@property (nonatomic, weak) UILabel *numberLabel;

/**记录今日金币数的label*/
@property (nonatomic, weak) UILabel *todayIncomeLabel;
@end

@implementation BOUMoneyHomepageVC
- (void)dealloc {
    NSLog(@"BOUMoneyHomepageVC");
}
#pragma mark - 网络请求对象
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    [self requstNetData];
    // 设置上部的View
    [self setupTopView];
    // 设置底部的View
    [self setupBottomView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 用分类实现颜色和透明度转化为图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithAlpha:0.01] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    // 设置navigationItem的左边按钮
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    //    self.navigationItem.leftBarButtonItem = btnItem;
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 请求网络数据
- (void)requstNetData {
    NSString *url = [NSString stringWithFormat:@"%@Ucenter/getMyAccountInfo",BASEURL];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"at"] = tokenString;
    dictionary[@"sid"] = USERSid;
    dictionary[@"uid"] = USERUID;
    [self.mgr POST:url parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.item = [UMoneyPageItem mj_objectWithKeyValues:responseObject[@"data"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 设置上部的View
- (void)setupTopView {
    // 创建topView
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topW = BOScreenW;
    CGFloat topH = 280 * BOHeightRate;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(topX, topY, topW, topH)];
    self.topView = topView;
    [self.view addSubview:topView];
    
    // 添加底部的imageView
    
    UIImageView *basementImageV = [[UIImageView alloc] initWithFrame:topView.bounds];
    basementImageV.image = [UIImage imageNamed:@"img_bluebg"];
    [topView addSubview:basementImageV];
    // 添加我的U币label
    CGFloat myUX = (BOScreenW - 60 * BOWidthRate) * 0.5;
    CGFloat myUY = 93 * BOHeightRate;
    CGFloat myUW = 60 * BOWidthRate;
    CGFloat myUH = 15 * BOHeightRate;
    UILabel *myUMoneyLable = [[UILabel alloc] initWithFrame:CGRectMake(myUX, myUY, myUW, myUH)];
    myUMoneyLable.text = @"我的U币";
    [myUMoneyLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    [myUMoneyLable setTextColor:[UIColor whiteColor]];
    myUMoneyLable.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:myUMoneyLable];
    // 添加金币数的label
    CGFloat numberX = 0;
    CGFloat numberY = CGRectGetMaxY(myUMoneyLable.frame) + 19 * BOHeightRate;
    CGFloat numberW = BOScreenW;
    CGFloat numberH = 40 * BOHeightRate;
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(numberX, numberY, numberW, numberH)];
    self.numberLabel = numberLabel;
    numberLabel.text = @"356,650";
    numberLabel.textColor = [UIColor whiteColor];
    [numberLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:40]];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:numberLabel];
    // 添加今日收入的label
    CGFloat todayX = 0;
    CGFloat todayY = CGRectGetMaxY(numberLabel.frame) + 28 * BOWidthRate;
    CGFloat todayW = BOScreenW;
    CGFloat todayH = 15 * BOHeightRate;
    UILabel *todayIncomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(todayX, todayY, todayW, todayH)];
    self.todayIncomeLabel = todayIncomeLabel;
    [todayIncomeLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    todayIncomeLabel.text = @"今日收入 +26,950";
    todayIncomeLabel.textColor = [UIColor colorWithHexString:@"ACC8F9" alpha:1];
    todayIncomeLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:todayIncomeLabel];
    // 添加提现按钮
    CGFloat incarnateX = (BOScreenW - 230 * BOWidthRate) * 0.5;
    CGFloat incarnateY = 257 * BOHeightRate;
    CGFloat incarnateW = 230 * BOWidthRate;
    CGFloat incarnateH = 70 * BOHeightRate;
    UIButton *incarnateBtn = [[UIButton alloc] initWithFrame:CGRectMake(incarnateX, incarnateY, incarnateW, incarnateH)];
    [incarnateBtn setImage:[UIImage imageNamed:@"btn_tixian_nor"] forState:UIControlStateNormal];
    [incarnateBtn setImage:[UIImage imageNamed:@"btn_tixian_pre"] forState:UIControlStateHighlighted];
    //[incarnateBtn addTarget:self action:@selector(incarnateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:incarnateBtn];
}
#pragma mark - 提现按钮的点击事件
- (void)incarnateBtnClick {
    BOWithdrawDepositVC *withdrawDepositVC = [[BOWithdrawDepositVC alloc] init];
    withdrawDepositVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:withdrawDepositVC animated:YES];
}
#pragma mark - 设置底部的View
- (void)setupBottomView {
    // 创建第一个View
    CGFloat firstX = 10 * BOWidthRate;
    CGFloat firstY = CGRectGetMaxY(self.topView.frame) + 55 * BOHeightRate;
    CGFloat firstW = (BOScreenW - 31 * BOWidthRate) * 0.5;
    CGFloat firstH = 150 * BOHeightRate;
    UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(firstX, firstY, firstW, firstH)];
    firstView.layer.cornerRadius = 10 * BOWidthRate;
    firstView.layer.cornerRadius = 10 * BOWidthRate;
    firstView.layer.shadowOpacity = 0.08;
    firstView.layer.shadowOffset = CGSizeMake(2.5 , 4);
    firstView.layer.shadowColor = [UIColor blackColor].CGColor;
    firstView.backgroundColor = [UIColor whiteColor];
//    firstView.layer.shadowOffset
    [self.view addSubview:firstView];
    // 创建第二个View
    CGFloat secondX = CGRectGetMaxX(firstView.frame) + 11 * BOWidthRate;
    CGFloat secondY = firstY;
    CGFloat secondW = firstW;
    CGFloat secondH = firstH;
    UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(secondX, secondY, secondW, secondH)];
    secondView.layer.cornerRadius = 10 * BOWidthRate;
    secondView.layer.cornerRadius = 10 * BOWidthRate;
    secondView.layer.shadowOpacity = 0.08;
    secondView.layer.shadowOffset = CGSizeMake(2.5 , 4);
    secondView.layer.shadowColor = [UIColor blackColor].CGColor;
    secondView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:secondView];
    // 创建第三个View
    CGFloat thirdX = firstX;
    CGFloat thirdY = CGRectGetMaxY(firstView.frame) + 10 * BOHeightRate;
    CGFloat thirdW = firstW;
    CGFloat thirdH = firstH;
    UIView *thirdView = [[UIView alloc] initWithFrame:CGRectMake(thirdX, thirdY, thirdW, thirdH)];
    thirdView.layer.cornerRadius = 10 * BOWidthRate;
    thirdView.layer.cornerRadius = 10 * BOWidthRate;
    thirdView.layer.shadowOpacity = 0.08;
    thirdView.layer.shadowOffset = CGSizeMake(2.5 , 4);
    thirdView.layer.shadowColor = [UIColor blackColor].CGColor;
    thirdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:thirdView];
    // 创建第四个View
    CGFloat fourX = secondX;
    CGFloat fourY = thirdY;
    CGFloat fourW = firstW;
    CGFloat fourH = firstH;
    UIView *fourthView = [[UIView alloc] initWithFrame:CGRectMake(fourX, fourY, fourW, fourH)];
    fourthView.layer.cornerRadius = 10 * BOWidthRate;
    fourthView.layer.shadowOpacity = 0.08;
    fourthView.layer.shadowOffset = CGSizeMake(2.5 , 4);
    fourthView.layer.shadowColor = [UIColor blackColor].CGColor;
    fourthView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:fourthView];
    
    //设置第一个View的子控件
    // 设置收支明细的button
    CGFloat incomeX = (firstW - 110 * BOWidthRate) * 0.5;
    CGFloat incomeY = 15 * BOHeightRate;
    CGFloat incomeW = 110 * BOWidthRate;
    CGFloat incomeH = 100 * BOHeightRate;
    UIButton *incomeBtn = [[UIButton alloc] initWithFrame:CGRectMake(incomeX, incomeY, incomeW, incomeH)];
    [incomeBtn setBackgroundImage:[UIImage imageNamed:@"img_szmx"] forState:UIControlStateNormal];
    [incomeBtn addTarget:self action:@selector(incomeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    incomeBtn.adjustsImageWhenHighlighted = NO;
    [firstView addSubview:incomeBtn];
    // 添加收支明细的label
    CGFloat incomeLX = 0;
    CGFloat incomeLY = CGRectGetMaxY(incomeBtn.frame) + 10 * BOHeightRate;
    CGFloat incomeLW = firstW;
    CGFloat incomeLH = 15 * BOHeightRate;
    UILabel *incomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(incomeLX, incomeLY, incomeLW, incomeLH)];
    incomeLabel.text = @"收支明细";
    incomeLabel.textColor = [UIColor colorWithHexString:@"#A8B2BD" alpha:1];
    [incomeLabel setFont:[UIFont systemFontOfSize:14]];
    incomeLabel.textAlignment = NSTextAlignmentCenter;
    [firstView addSubview:incomeLabel];
    
    // 添加第二个View的子控件
    // 添加U币规则按钮
    CGFloat ruleX = incomeX;
    CGFloat ruleY = incomeY;
    CGFloat ruleW = incomeW;
    CGFloat ruleH = incomeH;
    UIButton *ruleBtn = [[UIButton alloc] initWithFrame:CGRectMake(ruleX, ruleY, ruleW, ruleH)];
    [ruleBtn setBackgroundImage:[UIImage imageNamed:@"img_ubgz"] forState:UIControlStateNormal];
    [ruleBtn addTarget:self action:@selector(ruleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    ruleBtn.adjustsImageWhenHighlighted = NO;
    [secondView addSubview:ruleBtn];
    // 添加U币规则label
    CGFloat ruleLX = incomeLX;
    CGFloat ruleLY = incomeLY;
    CGFloat ruleLW = incomeLW;
    CGFloat ruleLH = incomeLH;
    UILabel *ruleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ruleLX, ruleLY, ruleLW, ruleLH)];
    ruleLabel.text = @"U币规则";
    ruleLabel.textColor = [UIColor colorWithHexString:@"#A8B2BD" alpha:1];
    [ruleLabel setFont:[UIFont systemFontOfSize:14]];
    ruleLabel.textAlignment = NSTextAlignmentCenter;
    [secondView addSubview:ruleLabel];
    
    // 添加第三个View的子控件
    // 添加U币排行按钮
    CGFloat rankX = incomeX;
    CGFloat rankY = incomeY;
    CGFloat rankW = incomeW;
    CGFloat rankH = incomeH;
    UIButton *rankBtn = [[UIButton alloc] initWithFrame:CGRectMake(rankX, rankY, rankW, rankH)];
    [rankBtn setBackgroundImage:[UIImage imageNamed:@"img_ubph"] forState:UIControlStateNormal];
    [rankBtn addTarget:self action:@selector(rankBtnClick) forControlEvents:UIControlEventTouchUpInside];
    rankBtn.adjustsImageWhenHighlighted = NO;
    [thirdView addSubview:rankBtn];
    // 添加U币排行label
    CGFloat rankLX = incomeLX;
    CGFloat rankLY = incomeLY;
    CGFloat rankLW = incomeLW;
    CGFloat rankLH = incomeLH;
    UILabel *rankLabel = [[UILabel alloc] initWithFrame:CGRectMake(rankLX, rankLY, rankLW, rankLH)];
    rankLabel.text = @"U币排行";
    rankLabel.textColor = [UIColor colorWithHexString:@"#A8B2BD" alpha:1];
    [rankLabel setFont:[UIFont systemFontOfSize:14]];
    rankLabel.textAlignment = NSTextAlignmentCenter;
    [thirdView addSubview:rankLabel];
    
    // 添加第四个View的子控件
    // 添加支付密码按钮
    CGFloat passwordX = incomeX;
    CGFloat passwordY = incomeY;
    CGFloat passwordW = incomeW;
    CGFloat passwordH = incomeH;
    UIButton *passwordBtn = [[UIButton alloc] initWithFrame:CGRectMake(passwordX, passwordY, passwordW, passwordH)];
    [passwordBtn setBackgroundImage:[UIImage imageNamed:@"img_zfmm"] forState:UIControlStateNormal];
    [passwordBtn addTarget:self action:@selector(passwordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    passwordBtn.adjustsImageWhenHighlighted = NO;
    [fourthView addSubview:passwordBtn];
    // 添加U币排行label
    CGFloat passwordLX = incomeLX;
    CGFloat passwordLY = incomeLY;
    CGFloat passwordLW = incomeLW;
    CGFloat passwordLH = incomeLH;
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(passwordLX, passwordLY, passwordLW, passwordLH)];
    passwordLabel.text = @"支付密码";
    passwordLabel.textColor = [UIColor colorWithHexString:@"#A8B2BD" alpha:1];
    [passwordLabel setFont:[UIFont systemFontOfSize:14]];
    passwordLabel.textAlignment = NSTextAlignmentCenter;
    [fourthView addSubview:passwordLabel];

}
#pragma mark - 点击了收支明细按钮
- (void)incomeBtnClick {
    BOUMoneyBillVC *uMoneyBillVC = [[BOUMoneyBillVC alloc] init];
    uMoneyBillVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:uMoneyBillVC animated:YES];
}
#pragma mark - 点击了U币规则按钮
- (void)ruleBtnClick {
    BOUMoneyRuleVC *uMoneyRuleVC = [[BOUMoneyRuleVC alloc] init];
    uMoneyRuleVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:uMoneyRuleVC animated:YES];
}
#pragma mark - 点击了U币排行按钮
- (void)rankBtnClick {
    BOUMoneyRankVC *uMoneyRankVC = [[BOUMoneyRankVC alloc] init];
    uMoneyRankVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:uMoneyRankVC animated:YES];
}
#pragma mark - 点击了支付密码按钮
- (void)passwordBtnClick
{
    if ([twoChange intValue] == 0) {
        ResetLoginPasswordVC *resetLoginPasswordVC = [[ResetLoginPasswordVC alloc] init];
        resetLoginPasswordVC.titleString = @"设置支付密码";
        resetLoginPasswordVC.flag = 1;
        [self.navigationController pushViewController:resetLoginPasswordVC animated:YES];
    }else if ([twoChange intValue] == 1) {
        ResetLoginPasswordVC *resetLoginPasswordVC = [[ResetLoginPasswordVC alloc] init];
        resetLoginPasswordVC.titleString = @"重置支付密码";
        resetLoginPasswordVC.flag = 1;
        [self.navigationController pushViewController:resetLoginPasswordVC animated:YES];
    }

//    SetPayPasswordViewController *setVc = [[SetPayPasswordViewController alloc]init];
//    [self.navigationController pushViewController:setVc animated:YES];
}
#pragma mark - 重写item的set方法
- (void)setItem:(UMoneyPageItem *)item {
    _item = item;
    int sumNumber = [item.balance intValue];
    int todayNumber = [item.today_add intValue];
    if (sumNumber == 0) {
        self.numberLabel.text = @"0";
    }else {
       self.numberLabel.text = _item.balance;
    }
   
    if (todayNumber == 0) {
        self.todayIncomeLabel.text = [NSString stringWithFormat:@"今日收入 0"];
    }else {
        self.todayIncomeLabel.text = [NSString stringWithFormat:@"今日收入 +%@",[self stringWithNumber:todayNumber]];
    }
}

- (NSString *)stringWithNumber:(int)number {
    NSMutableArray *arrayM = [NSMutableArray array];
    while (number % 1000) {
        [arrayM addObject:[NSString stringWithFormat:@"%d", number % 1000]];
        number = number / 1000;
        if (number == 0) {
            break;
        }
    }
    NSMutableString *string = [[NSMutableString alloc] init];
    for (NSInteger i = arrayM.count - 1; i >= 0; i--) {
        if (i == 0) {
            [string appendFormat:@"%@",arrayM[i]];
        }else {
            [string appendFormat:@"%@,",arrayM[i]];
        }
    }
    return string;
}
@end
