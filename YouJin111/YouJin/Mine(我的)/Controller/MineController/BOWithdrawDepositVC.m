//
//  BOWithdrawDepositVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOWithdrawDepositVC.h"
#import "DCPaymentView.h"
@interface BOWithdrawDepositVC ()
@property (nonatomic, weak) UIButton *selectBtn;
@property (nonatomic, assign) CGFloat userMoney;
@end

@implementation BOWithdrawDepositVC
- (void)setSelectBtn:(UIButton *)selectBtn {
    _selectBtn.selected = NO;
    selectBtn.selected = YES;
    _selectBtn = selectBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BOColor(244, 245, 247);
    self.userMoney = 56.66;
    // 设置上部的View
    [self setupTopView];
    // 设置中部的View
    [self setupMiddleView];
    // 设置底部的提现按钮
    [self setupBottomBtn];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:0.01] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // 隐藏底部的tabbar
    //    self.tabBarController.tabBar.hidden = YES;
    
    // 设置navigationItem的左边按钮
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    //    self.navigationItem.leftBarButtonItem = btnItem;
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"提现"];
    self.navigationItem.titleView = titleView;
    
    // 设置rightButtonItem
    UIBarButtonItem *rightItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"icon_help"] selImage:[UIImage imageNamed:@"icon_help"] target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 设置头部的View
- (void)setupTopView {
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topW = BOScreenW;
    CGFloat topH = 183 * BOHeightRate;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(topX, topY, topW, topH)];
    topView.backgroundColor = BOColor(51, 134, 240);
    [self.view addSubview:topView];
    
    // 添加箭头的图片
    CGFloat arrowX = (BOScreenW - 150 * BOWidthRate) * 0.5;
    CGFloat arrowY = 98 * BOHeightRate;
    CGFloat arrowW = 150 * BOWidthRate;
    CGFloat arrowH = 11 * BOHeightRate;
    UIImageView *arrowIamgeV = [[UIImageView alloc] initWithFrame:CGRectMake(arrowX, arrowY, arrowW, arrowH)];
    arrowIamgeV.image = [UIImage imageNamed:@"img_jiantou"];
    [topView addSubview:arrowIamgeV];
    // 添加金额的label
    CGFloat moneyX = arrowX;
    CGFloat moneyY = 80 * BOHeightRate;
    CGFloat moneyW = 150 * BOWidthRate;
    CGFloat moneyH = 15 * BOHeightRate;
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyX, moneyY, moneyW, moneyH)];
    moneyLabel.text = @"金额";
    [moneyLabel setFont:[UIFont systemFontOfSize:13]];
    [moneyLabel setTextColor:[UIColor whiteColor]];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:moneyLabel];
    // 添加U币icon
    CGFloat uMoneyX = 48 * BOWidthRate;
    CGFloat uMoneyY = 86 * BOHeightRate;
    CGFloat uMoneyWH = 39 * BOWidthRate;
    UIImageView *uMoneyIcon = [[UIImageView alloc] initWithFrame:CGRectMake(uMoneyX, uMoneyY, uMoneyWH, uMoneyWH)];
    uMoneyIcon.image = [UIImage imageNamed:@"img_ubi"];
    [topView addSubview:uMoneyIcon];
    // 添加我的U币label
    CGFloat uMoneyLX = 37.5 * BOWidthRate;
    CGFloat uMoneyLY = CGRectGetMaxY(uMoneyIcon.frame) + 14 * BOHeightRate;
    CGFloat uMoneyLW = 60 * BOWidthRate;
    CGFloat uMoneyLH = 15 * BOHeightRate;
    UILabel *uMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(uMoneyLX, uMoneyLY, uMoneyLW, uMoneyLH)];
    uMoneyLabel.text = @"我的U币";
    [uMoneyLabel setFont:[UIFont systemFontOfSize:12]];
    uMoneyLabel.textAlignment = NSTextAlignmentCenter;
    uMoneyLabel.textColor = [UIColor whiteColor];
    [topView addSubview:uMoneyLabel];
    // 添加微信的icon
    CGFloat weixinX = arrowX - 67.5 * BOHeightRate + CGRectGetMaxX(arrowIamgeV.frame);
    CGFloat weixinY = 86 * BOHeightRate;
    CGFloat weixinWH = uMoneyWH;
    UIImageView *weixinIcon = [[UIImageView alloc] initWithFrame:CGRectMake(weixinX, weixinY, weixinWH, weixinWH)];
    weixinIcon.image = [UIImage imageNamed:@"img_wxqb"];
    [topView addSubview:weixinIcon];
    // 添加微信钱包的label
    CGFloat weixinLX = weixinX - 21.5 * BOWidthRate;
    CGFloat weixinLY = CGRectGetMaxY(weixinIcon.frame) + 14 * BOHeightRate;
    CGFloat weixinLW = 80 * BOWidthRate;
    CGFloat weixinLH = 15 * BOHeightRate;
    UILabel *weixinLabel = [[UILabel alloc] initWithFrame:CGRectMake(weixinLX, weixinLY, weixinLW, weixinLH)];
    weixinLabel.text = @"微信钱包";
    [weixinLabel setFont:[UIFont systemFontOfSize:12]];
    weixinLabel.textColor = [UIColor whiteColor];
    weixinLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:weixinLabel];
    // 添加微信号lable
    CGFloat weixinNumX = weixinLX;
    CGFloat weixinNumY = CGRectGetMaxY(weixinLabel.frame) + 5 * BOHeightRate;
    CGFloat weixinNumW = weixinLW;
    CGFloat weixinNumH = 15 * BOHeightRate;
    UILabel *weixinNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(weixinNumX, weixinNumY, weixinNumW, weixinNumH)];
    weixinNumLabel.text = @"aced_7633";
    [weixinNumLabel setFont:[UIFont systemFontOfSize:12]];
    weixinNumLabel.textColor = [UIColor colorWithHexString:@"#BED3FA" alpha:1];
    weixinNumLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:weixinNumLabel];

}

#pragma mark - 设置中部的View
- (void)setupMiddleView {
    CGFloat middleX = 0;
    CGFloat middleY = 191 * BOHeightRate;
    CGFloat middleW = BOScreenW;
    CGFloat middleH = 163 * BOHeightRate;
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(middleX, middleY, middleW, middleH)];
    middleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:middleView];
    // 添加提现金额的label
    CGFloat numberX = 10 * BOWidthRate;
    CGFloat numberY = 15 * BOHeightRate;
    CGFloat numberW = 80 * BOWidthRate;
    CGFloat numbetH = 15 * BOHeightRate;
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(numberX, numberY, numberW, numbetH)];
    numberLabel.text = @"提现金额";
    [numberLabel setFont:[UIFont systemFontOfSize:14]];
    numberLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    [middleView addSubview:numberLabel];
    // 添加体现1元的按钮
    CGFloat oneX = 10 * BOWidthRate;
    CGFloat oneY = CGRectGetMaxY(numberLabel.frame) + 30 * BOHeightRate;
    CGFloat oneW = 60 * BOWidthRate;
    CGFloat oneH = 40 * BOHeightRate;
    UIButton *oneButton = [[UIButton alloc] initWithFrame:CGRectMake(oneX, oneY, oneW, oneH)];
    [oneButton setTitle:@"1元" forState:UIControlStateNormal];
    [self setupBtnCircular:oneButton WithMoney:1.0];
    [oneButton addTarget:self action:@selector(oneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    if (oneButton.isEnabled) {
        self.selectBtn = oneButton;
    }
    [middleView addSubview:oneButton];
    // 添加提现50元的按钮
    CGFloat fiftyX = CGRectGetMaxX(oneButton.frame) + 15 * BOWidthRate;
    CGFloat fiftyY = CGRectGetMaxY(numberLabel.frame) + 30 * BOHeightRate;
    CGFloat fiftyW = 60 * BOWidthRate;
    CGFloat fiftyH = 40 * BOHeightRate;
    UIButton *fiftyButton = [[UIButton alloc] initWithFrame:CGRectMake(fiftyX, fiftyY, fiftyW, fiftyH)];
    [self setupBtnCircular:fiftyButton WithMoney: 50];
    [fiftyButton setTitle:@"50元" forState:UIControlStateNormal];
    [fiftyButton addTarget:self action:@selector(fiftyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:fiftyButton];
    // 添加提现100元的按钮
    CGFloat oneHundredX = CGRectGetMaxX(fiftyButton.frame) + 15 * BOWidthRate;
    CGFloat oneHundredY = CGRectGetMaxY(numberLabel.frame) + 30 * BOHeightRate;
    CGFloat oneHundredW = 60 * BOWidthRate;
    CGFloat oneHundredH = 40 * BOHeightRate;
    UIButton *oneHundredButton = [[UIButton alloc] initWithFrame:CGRectMake(oneHundredX, oneHundredY, oneHundredW, oneHundredH)];
    [self setupBtnCircular:oneHundredButton WithMoney: 100];
    [oneHundredButton setTitle:@"100元" forState:UIControlStateNormal];
    [oneHundredButton addTarget:self action:@selector(oneHundredButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:oneHundredButton];
    // 添加提现200元的按钮
    CGFloat twoHundredX = CGRectGetMaxX(oneHundredButton.frame) + 15 * BOWidthRate;
    CGFloat twoHundredY = CGRectGetMaxY(numberLabel.frame) + 30 * BOHeightRate;
    CGFloat twoHundredW = 60 * BOWidthRate;
    CGFloat twoHundredH = 40 * BOHeightRate;
    UIButton *twoHundredButton = [[UIButton alloc] initWithFrame:CGRectMake(twoHundredX, twoHundredY, twoHundredW, twoHundredH)];
    [self setupBtnCircular:twoHundredButton WithMoney:200];
       [twoHundredButton setTitle:@"200元" forState:UIControlStateNormal];
    [twoHundredButton addTarget:self action:@selector(twoHundredButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:twoHundredButton];
    
    // 添加分割线View
    UIView *divisionView = [[UIView alloc] initWithFrame:CGRectMake(10 * BOWidthRate, 128 * BOHeightRate, BOScreenW, 1)];
    divisionView.backgroundColor = [UIColor colorWithHexString:@"#DFE3E6" alpha:1];
    [middleView addSubview:divisionView];
    
    // 添加我的U币
    CGFloat uMoneyX = 10 * BOWidthRate;
    CGFloat uMoneyY = CGRectGetMaxY(divisionView.frame) + 10 * BOHeightRate;
    CGFloat uMoneyW = 125 * BOWidthRate;
    CGFloat uMoneyH = 15 * BOHeightRate;
    UILabel *uMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(uMoneyX, uMoneyY, uMoneyW, uMoneyH)];
    uMoneyLabel.text = @"我的U币 556,650";
    uMoneyLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    [uMoneyLabel setFont:[UIFont systemFontOfSize:13]];
    [middleView addSubview:uMoneyLabel];
    // 添加钱的label
    CGFloat moneyX = 150 * BOWidthRate;
    CGFloat moneyY = uMoneyY;
    CGFloat moneyW = 150 * BOWidthRate;
    CGFloat moneyH = 15 * BOHeightRate;
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyX, moneyY, moneyW, moneyH)];
    moneyLabel.text = @"折合 ￥55.6";
    moneyLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    [moneyLabel setFont:[UIFont systemFontOfSize:13]];
    [middleView addSubview:moneyLabel];
}
#pragma mark - 添加底部的提现按钮
- (void)setupBottomBtn {
    // 添加提现按钮背景View
    CGFloat backVX = (BOScreenW - 295 * BOWidthRate) * 0.5;
    CGFloat backVY = 385 * BOHeightRate;
    CGFloat backVW = 295 * BOWidthRate;
    CGFloat backVH = 45 * BOHeightRate;
    UIButton *withdrawBtn = [[UIButton alloc] initWithFrame:CGRectMake(backVX, backVY, backVW, backVH)];
    [withdrawBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#FFA238" alpha:1] WithAlpha:1] forState:UIControlStateNormal];
    [withdrawBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#FFCF99" alpha:1] WithAlpha:1] forState:UIControlStateDisabled];
    [withdrawBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [withdrawBtn setTitle:@"提现" forState:UIControlStateNormal];
    [withdrawBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] forState:UIControlStateNormal];
    withdrawBtn.layer.cornerRadius = 22.5 * BOHeightRate;
    withdrawBtn.layer.masksToBounds = YES;
    [withdrawBtn addTarget:self action:@selector(withdrawBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:withdrawBtn];

}
#pragma mark - 点击1元提现按钮
- (void)oneButtonClick: (UIButton *)btn {
    [self setSelectBtn:btn];
}
#pragma mark - 点击50元提现按钮
- (void)fiftyButtonClick: (UIButton *)btn {
    [self setSelectBtn:btn];
}
#pragma mark - 点击100元提现按钮
- (void)oneHundredButtonClick: (UIButton *)btn {
    [self setSelectBtn:btn];
}
#pragma mark - 点击200元提现按钮
- (void)twoHundredButtonClick: (UIButton *)btn {
    [self setSelectBtn:btn];
}
#pragma mark - 设置提现按钮的圆角半径
- (void)setupBtnCircular: (UIButton *)btn WithMoney:(CGFloat)money{
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#CCCCCC" alpha:1] WithAlpha:1] forState:UIControlStateDisabled];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] WithAlpha:1] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#FBDB6A" alpha:1] WithAlpha:1] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor colorWithHexString:@"#333333" alpha:1] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC" alpha:1].CGColor;
    btn.layer.borderWidth = 1;
    
    if (self.userMoney < money) {
        btn.enabled = NO;
    }
}
#pragma mark - 点击提现后弹框
- (void)withdrawBtnClick {
    DCPaymentView *payAlert = [[DCPaymentView alloc]init];
    payAlert.title = @"请输入支付密码";
    payAlert.detail = @"提现";
    payAlert.amount= 10;
    [payAlert show];
    payAlert.completeHandle = ^(NSString *inputPwd) {
        NSLog(@"密码是%@",inputPwd);
    };

}
@end
