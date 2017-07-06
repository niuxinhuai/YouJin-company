//
//  ResetLoginPasswordVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "ResetLoginPasswordVC.h"
#import "SettingLoginPasswordVC.h"
#import <SMS_SDK/SMSSDK.h>
#import "SetPayPasswordViewController.h"
@interface ResetLoginPasswordVC ()
@property (nonatomic, weak) UILabel *presentLable;

@property (nonatomic, weak) UITextField *securityTextF;

@property (nonatomic, weak) UITextField *phoneTextF;

@property (nonatomic, assign) int timeValue;

/**获取验证码的点击按钮*/
@property (nonatomic, weak) UIButton *getSecurityCodeBtn;

@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, weak) UIBarButtonItem *rightBtnItem;

@property (nonatomic, weak) AFHTTPSessionManager *mgr;
@end

@implementation ResetLoginPasswordVC
#pragma mark - 懒加载
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}
- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceSecond) userInfo:nil repeats:YES];
        
        //刚开始进来 关闭定时器
        [_timer setFireDate:[NSDate distantFuture]];
    }
    return _timer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    self.timeValue = 60;
    // 添加手机号的View
    [self setupPhoneNumberView];
    // 添加验证码的View
    [self setupSecurityCodeView];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 设置navigationItem的左边按钮
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    //    self.navigationItem.leftBarButtonItem = btnItem;
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];

    
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:self.titleString];
    self.navigationItem.titleView = titleView;
    
    // 设置rightButtonItem
    UIBarButtonItem *rightBtnItem = [UIBarButtonItem btnWithImage:nil title:@"下一步" titleColor:[UIColor whiteColor] target:self action:@selector(requestNetData)];
    self.rightBtnItem = rightBtnItem;
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.securityTextF resignFirstResponder];
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - push下一个界面
- (void)pushNextPageWithNumber:(int)number {
    
    SettingLoginPasswordVC *settingLoginPasswordVC = [[SettingLoginPasswordVC alloc] init];
    if (number == 1) {
        settingLoginPasswordVC.titleString = @"重置登录密码";
    }else {
        settingLoginPasswordVC.titleString = @"设置登录密码";
    }
    settingLoginPasswordVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingLoginPasswordVC animated:YES];
}
#pragma mark - 设置手机号的View
- (void)setupPhoneNumberView {
    // 创建手机号的View
    CGFloat phoneNumX = 0;
    CGFloat phoneNumY = 8 * BOHeightRate;
    CGFloat phoneNumW = BOScreenW;
    CGFloat phoneNumH = 45 * BOHeightRate;
    UIView *phoneNumberView = [[UIView alloc] initWithFrame:CGRectMake(phoneNumX, phoneNumY, phoneNumW, phoneNumH)];
    phoneNumberView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneNumberView];
    // 创建手机号的label
    CGFloat phoneLX = 15 * BOWidthRate;
    CGFloat phoneLY = 12.5 * BOHeightRate;
    CGFloat phoneLW = 55 * BOWidthRate;
    CGFloat phoneLH = 20 * BOHeightRate;
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(phoneLX, phoneLY, phoneLW, phoneLH)];
    phoneLabel.text = @"手机号";
    [phoneLabel setFont:[UIFont systemFontOfSize:15]];
    [phoneLabel setTextColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
    [phoneNumberView addSubview:phoneLabel];
    //创建手机号的textfiled
    CGFloat phoneTX = CGRectGetMaxX(phoneLabel.frame) + 15 * BOWidthRate;
    CGFloat phoneTY = phoneLY;
    CGFloat phoneTW = 140 * BOWidthRate;
    CGFloat phoneTH = 20 * BOHeightRate;
    UITextField *phoneTextF = [[UITextField alloc] initWithFrame:CGRectMake(phoneTX, phoneTY, phoneTW, phoneTH)];
    self.phoneTextF = phoneTextF;
    [phoneTextF setFont:[UIFont systemFontOfSize:14]];
    [phoneTextF setTextColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
    phoneTextF.text = USERMobile;
    phoneTextF.enabled = NO;
    [phoneTextF setFont:[UIFont systemFontOfSize:14]];
//    phoneTextF.placeholder = @"请输入手机号";
    [phoneNumberView addSubview:phoneTextF];
    // 创建分割线View
    CGFloat divisionX = 280 * BOWidthRate;
    CGFloat divisionY = 10 * BOHeightRate;
    CGFloat divisionW = 1;
    CGFloat divisionH = 25 * BOHeightRate;
    UIView *divisionView = [[UIView alloc] initWithFrame:CGRectMake(divisionX, divisionY, divisionW, divisionH)];
    divisionView.backgroundColor = [UIColor colorWithHexString:@"D2D6D9" alpha:1];
    [phoneNumberView addSubview:divisionView];
    // 创建获取验证码的button
    CGFloat getX = 290 * BOWidthRate;
    CGFloat getY = 12.5 * BOHeightRate;
    CGFloat getW = 75 * BOWidthRate;
    CGFloat getH = 20 * BOHeightRate;
    UIButton *getSecurityCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(getX, getY, getW, getH)];
    [getSecurityCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getSecurityCodeBtn setTitleColor:[UIColor colorWithHexString:@"2D84F2" alpha:1] forState:UIControlStateNormal];
    [getSecurityCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [getSecurityCodeBtn addTarget:self action:@selector(getBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [getSecurityCodeBtn setTitleColor:BOColor(174, 174, 175) forState:UIControlStateDisabled];
//    [getSecurityCodeBtn setTitleColor:[UIColor colorWithHexString:@"#FEFEFE" alpha:1] forState:UIControlStateNormal];
//    [getSecurityCodeBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#A5DB30" alpha:1] WithAlpha:1] forState:UIControlStateNormal];
//    [getSecurityCodeBtn setBackgroundImage:[UIImage imageWithColor:BOColor(242, 242, 245) WithAlpha:1] forState:UIControlStateDisabled];
//    getSecurityCodeBtn.backgroundColor = [UIColor colorWithHexString:@"#A5DB30" alpha:1];
    self.getSecurityCodeBtn = getSecurityCodeBtn;
    [phoneNumberView addSubview:getSecurityCodeBtn];
}
#pragma mark - 设置验证码的View
- (void)setupSecurityCodeView {
    // 创建验证码的View
    CGFloat securityX = 0;
    CGFloat securityY = 61 * BOHeightRate;
    CGFloat securityW = BOScreenW;
    CGFloat securityH = 45 * BOHeightRate;
    UIView *securityCodeView = [[UIView alloc] initWithFrame:CGRectMake(securityX, securityY, securityW, securityH)];
    securityCodeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:securityCodeView];
    // 创建验证码label
    CGFloat securityCodeX = 15 * BOWidthRate;
    CGFloat securityCodeY = 12.5 * BOHeightRate;
    CGFloat securityCodeW = 55 * BOWidthRate;
    CGFloat securityCodeH = 20 * BOHeightRate;
    UILabel *securityCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(securityCodeX, securityCodeY, securityCodeW, securityCodeH)];
    securityCodeLabel.text = @"验证码";
    [securityCodeLabel setFont:[UIFont systemFontOfSize:15]];
    [securityCodeLabel setTextColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
    [securityCodeView addSubview:securityCodeLabel];
    // 创建请输入验证码的textFiled
    CGFloat securityTX = CGRectGetMaxX(securityCodeLabel.frame) + 15 * BOWidthRate;
    CGFloat securityTY = securityCodeY;
    CGFloat securityTW = 140 * BOWidthRate;
    CGFloat securityTH = 20 * BOHeightRate;
    UITextField *securityTextF = [[UITextField alloc] initWithFrame:CGRectMake(securityTX, securityTY, securityTW, securityTH)];
    securityTextF.keyboardType = UIKeyboardTypeNumberPad;
    self.securityTextF = securityTextF;
    [securityTextF setFont:[UIFont systemFontOfSize:14]];
    [securityTextF setTextColor:[UIColor colorWithHexString:@"#B3B3B3" alpha:1]];
    securityTextF.placeholder = @"请输入验证码";
    [securityCodeView addSubview:securityTextF];
}
#pragma mark - 验证码点击事件的触发
- (void)securityCodeBtnClick: (UIButton *)btn {
    if (!btn.selected) {
        [self setupPresentLabel];
        btn.selected = YES;
    }else {
        btn.selected = NO;
        [self.presentLable removeFromSuperview];
    }
//    [self setupPresentLabel];
}
#pragma mark - 设置点击验证码按钮弹出的label
- (void)setupPresentLabel {
    CGFloat presentX = 290 * BOWidthRate;
    CGFloat presentY = 65 * BOHeightRate;
    CGFloat presentW = 70 * BOWidthRate;
    CGFloat presentH = 18 * BOHeightRate;
    UILabel *presentLabel = [[UILabel alloc] initWithFrame:CGRectMake(presentX, presentY, presentW, presentH)];
    presentLabel.text = @"59S后重发";
    presentLabel.textColor = [UIColor colorWithHexString:@"B3B3B3" alpha:1];
    [presentLabel setFont:[UIFont systemFontOfSize:14]];
    self.presentLable = presentLabel;
    [self.view addSubview:presentLabel];
}

#pragma mark - 计时器的操作
- (void)reduceSecond {
    if (_timeValue == 0)
    {
        self.timeValue = 60;
        self.getSecurityCodeBtn.enabled = YES;
        [self.getSecurityCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        self.rightBtnItem.enabled = NO;
        //关闭定时器
        [self.timer setFireDate:[NSDate distantFuture]];
        return;
    }
    self.getSecurityCodeBtn.enabled = NO;
    [self.getSecurityCodeBtn setTitle:[NSString stringWithFormat:@"%dS后重发",self.timeValue] forState:UIControlStateNormal];
    self.timeValue -= 1;
}

#pragma mark - 获取验证码按钮的点击方法
- (void)getBtnClick:(UIButton *)btn {
    [self.timer setFireDate:[NSDate distantPast]];
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:USERMobile
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error){
                                     if (!error) {
                                         
                                     } else {
                                        
                                         
                                     }
                                 }];
}
#pragma mark - rightBtnItemClick
- (void)rightBtnItemClick {
    if (self.flag == 0) {
        [self requestNetData];
    }
    if (self.flag == 1)
    {
        [self requestNetDataOne];
    }
}
#pragma mark - 设置登陆密码的网络请求
- (void)requestNetData {
    if (self.securityTextF.text.length == 4) {
        // 请求网贷页其他数据
        NSString *loadString = [NSString stringWithFormat:@"%@Ucenter/isSetPass",BASEURL];
        NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
        parameters1[@"at"] = tokenString;
        parameters1[@"sid"] = USERSid;
        parameters1[@"uid"] = USERUID;
        parameters1[@"type"] = @"login";
        parameters1[@"mobile"] = USERMobile;
        parameters1[@"verycode"] = self.securityTextF.text;
        parameters1[@"os"] = @"Ios";
        [self.mgr POST:loadString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"r"] intValue] == 1) {
                if ([responseObject[@"status"] intValue] == 1) {
                    [self pushNextPageWithNumber:1];
                }else {
                    [self pushNextPageWithNumber:0];
                }
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

    }else {
        [self toast:@"验证码错误" complete:nil];
    }
   
}
#pragma mark - 设置支付密码的网络请求
- (void)requestNetDataOne {
    // 请求网贷页其他数据
    NSString *loadString = [NSString stringWithFormat:@"%@Ucenter/isSetPass",BASEURL];
    NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
    parameters1[@"at"] = tokenString;
    parameters1[@"sid"] = USERSid;
    parameters1[@"uid"] = USERUID;
    parameters1[@"type"] = @"pay";
    parameters1[@"mobile"] = USERMobile;
    parameters1[@"verycode"] = self.securityTextF.text;
    parameters1[@"os"] = @"Ios";
    [self.mgr POST:loadString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] intValue] == 1) {
        SetPayPasswordViewController *setPassWord = [[SetPayPasswordViewController alloc]init];
                    [self.navigationController pushViewController:setPassWord animated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


@end
