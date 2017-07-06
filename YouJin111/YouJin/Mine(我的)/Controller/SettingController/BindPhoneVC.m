//
//  BindPhoneVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/20.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BindPhoneVC.h"
#import <SMS_SDK/SMSSDK.h>

@interface BindPhoneVC ()
@property (nonatomic, weak) UITextField *phoneNumberTF;

@property (nonatomic, weak) UITextField *verifyTextF;

/**获取验证码的btn*/
@property (nonatomic, weak) UIButton *getBtn;
@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, assign) int timeValue;

@property (nonatomic, weak) AFHTTPSessionManager *mgr;
@end

@implementation BindPhoneVC
#pragma mark - 懒加载数据
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
    NSLog(@"%@",self.weixinString);
    self.timeValue = 60;
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置顶部的导航条
    [self setupNavigationView];
    
    // 设置手机输入框以及验证码输入框
    [self setupViewChildView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneNumberTF resignFirstResponder];
    [self.verifyTextF resignFirstResponder];
}
// 添加顶部的导航条
- (void)setupNavigationView {
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 64)];
    
    [self.view addSubview:navigationBar];
    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 添加返回按钮
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 32, 50 * BOWidthRate, 20)];
    [backBtn setImage:[UIImage imageNamed:@"common_icon_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    [navigationBar addSubview:backBtn];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20 * BOWidthRate, 0, 0);
    // 添加控制器的titleView
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((BOScreenW - 150 * BOWidthRate) * 0.5, 30, 150 * BOWidthRate, 24)];
    [label setText:@"绑定手机号"];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:19]];
    [label setTextColor:[UIColor whiteColor]];
    label.textAlignment = NSTextAlignmentCenter;
    [navigationBar addSubview:label];
}

#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置View的子控件
- (void)setupViewChildView {
    // 创建请输入手机号的textView
    CGFloat phoneX = (BOScreenW - 295 * BOWidthRate) * 0.5;
    CGFloat phoneY = 100 * BOHeightRate;
    CGFloat phoneW = 250 * BOWidthRate;
    CGFloat phoneH = 20 * BOHeightRate;
    UITextField *phoneNumberTF = [[UITextField alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneW, phoneH)];
    [phoneNumberTF addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    self.phoneNumberTF = phoneNumberTF;
    phoneNumberTF.placeholder = @"请输入手机号";
    phoneNumberTF.keyboardType = UIKeyboardTypeNumberPad;
    //    //创建和配置键盘。
    //    MMNumberKeyboard *keyboard = [[MMNumberKeyboard alloc] initWithFrame:CGRectZero];
    //    keyboard.allowsDecimalPoint = YES;
    //    keyboard.returnKeyTitle = @"完成";
    //    keyboard.delegate = self;
    //    leftPhoneNumberTF.inputView = keyboard;
    [self.view addSubview:phoneNumberTF];
    // 添加第一条分割线
    CGFloat firstX = (BOScreenW - 295 * BOWidthRate) * 0.5;
    CGFloat firstY = CGRectGetMaxY(phoneNumberTF.frame) + 16 * BOHeightRate;
    CGFloat firstW = 295 * BOWidthRate;
    CGFloat firstH = 1;
    UIView *leftFirstDivisionView = [[UIView alloc] initWithFrame:CGRectMake(firstX, firstY, firstW, firstH)];
    leftFirstDivisionView.backgroundColor = [UIColor colorWithHexString:@"#DFE3E6" alpha:1];
    [self.view addSubview:leftFirstDivisionView];
    
    // 创建请输入验证码的textView
    CGFloat verifyX = phoneX;
    CGFloat verifyY = CGRectGetMaxY(leftFirstDivisionView.frame) + 36 * BOHeightRate;
    CGFloat verifyW = phoneW;
    CGFloat verifyH = 20 * BOHeightRate;
    UITextField *verifyTextF = [[UITextField alloc] initWithFrame:CGRectMake(verifyX, verifyY, verifyW, verifyH)];
    self.verifyTextF = verifyTextF;
    //    MMNumberKeyboard *keyboard1 = [[MMNumberKeyboard alloc] initWithFrame:CGRectZero];
    //    keyboard1.allowsDecimalPoint = YES;
    //    keyboard1.returnKeyTitle = @"完成";
    //    keyboard1.delegate = self;
    //    leftVerifyTextF.inputView = keyboard1;
    self.verifyTextF = verifyTextF;
    verifyTextF.keyboardType = UIKeyboardTypeNumberPad;
    verifyTextF.placeholder = @"请输入验证码";
    [self.view addSubview:verifyTextF];
    // 添加获取验证码的按钮
    CGFloat getX = 245 * BOWidthRate;
    CGFloat getY = CGRectGetMaxY(leftFirstDivisionView.frame) + 24 * BOHeightRate;
    CGFloat getW = 90 * BOWidthRate;
    CGFloat getH = 30 * BOHeightRate;
    UIButton *getBtn = [[UIButton alloc] initWithFrame:CGRectMake(getX, getY, getW, getH)];
    self.getBtn = getBtn;
    [getBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getBtn setTitleColor:BOColor(174, 174, 175) forState:UIControlStateDisabled];
    [getBtn setTitleColor:[UIColor colorWithHexString:@"#FEFEFE" alpha:1] forState:UIControlStateNormal];
    getBtn.enabled = NO;
    [getBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#A5DB30" alpha:1] WithAlpha:1] forState:UIControlStateNormal];
    [getBtn setBackgroundImage:[UIImage imageWithColor:BOColor(242, 242, 245) WithAlpha:1] forState:UIControlStateDisabled];
    getBtn.backgroundColor = [UIColor colorWithHexString:@"#A5DB30" alpha:1];
    [getBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    getBtn.layer.cornerRadius = 15 * BOHeightRate;
    getBtn.layer.masksToBounds = YES;
    [getBtn addTarget:self action:@selector(getBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getBtn];
    // 创建第二条分割线
    CGFloat secondX = firstX;
    CGFloat secondY = CGRectGetMaxY(verifyTextF.frame) + 16 * BOHeightRate;
    CGFloat secondW = 295 * BOWidthRate;
    CGFloat secongH = 1;
    UIView *leftSecondDivisionView = [[UIView alloc] initWithFrame:CGRectMake(secondX, secondY, secondW, secongH)];
    leftSecondDivisionView.backgroundColor = [UIColor colorWithHexString:@"#DFE3E6" alpha:1];
    [self.view addSubview:leftSecondDivisionView];
    
    // 添加登录按钮背景View
    CGFloat backVX = firstX;
    CGFloat backVY = CGRectGetMaxY(leftSecondDivisionView.frame) +  34 * BOHeightRate;
    CGFloat backVW = secondW;
    CGFloat backVH = 44 * BOHeightRate;
    UIView *leftBackView = [[UIView alloc] initWithFrame:CGRectMake(backVX, backVY, backVW, backVH)];
    leftBackView.backgroundColor = [UIColor colorWithHexString:@"#4697FB" alpha:1];
    [self.view addSubview:leftBackView];
    leftBackView.layer.cornerRadius = 22 * BOHeightRate;
    leftBackView.layer.masksToBounds = YES;
    // 添加登录按钮
    UIButton *leftLoginBtn = [[UIButton alloc] init];
    leftLoginBtn.frame = leftBackView.bounds;
    [leftLoginBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [leftLoginBtn setTitle:@"绑定" forState:UIControlStateNormal];
    [leftLoginBtn setTitleColor:[UIColor colorWithHexString:@"#FEFEFE" alpha:1] forState:UIControlStateNormal];
    [leftLoginBtn addTarget:self action:@selector(leftLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftBackView addSubview:leftLoginBtn];
    
}
#pragma mark - textField的值改变监听方法
- (void)textFieldChange: (UITextField *)textField {
    if (self.phoneNumberTF.text.length == 11) {
        self.getBtn.enabled = YES;
    }else if (self.phoneNumberTF.text.length < 11) {
        self.getBtn.enabled = NO;
    }
}
#pragma mark - 获取验证码按钮的点击方法
- (void)getBtnClick:(UIButton *)btn {
    [self.timer setFireDate:[NSDate distantPast]];
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumberTF.text
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error){
                                     if (!error) {
                                         
                                     } else {
                                         
                                     }
                                 }];
}

#pragma mark - 左边验证码登录的按钮的点击
- (void)leftLoginBtnClick:(UIButton *)btn {
    if (self.phoneNumberTF.text.length == 0) {
        [self toast:@"号码不能空" complete:nil];
    }else if (self.verifyTextF.text.length == 0) {
        [self toast:@"验证码不能为空" complete:nil];
    }else if(self.verifyTextF.text.length != 0 && self.verifyTextF.text.length != 0) {
//        // 把数组转成json
//        NSData *data=[NSJSONSerialization dataWithJSONObject:self.weixinArrayM options:NSJSONWritingPrettyPrinted error:nil];
//        NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        // 验证码登录
        NSString *loadString = [NSString stringWithFormat:@"%@App/login", BASEURL];
        NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
        parameters1[@"mobile"] = self.phoneNumberTF.text;
        parameters1[@"verycode"] = self.verifyTextF.text;
        //    parameters1[@"sid"] = nil;
        parameters1[@"os"] = @"Ios";
        parameters1[@"at"] = tokenString;
        parameters1[@"login_type"] = @"verycode";
        parameters1[@"is_other_way"] = @"1";
        parameters1[@"weixin_array"] = self.weixinString;
        NSLog(@"%@", parameters1);
        [self.mgr POST:loadString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"r"] intValue] == 1) {
                [self toast:@"绑定成功" complete:nil];
                NSDictionary *dictionary = responseObject[@"data"];
                [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"uid"] forKey:@"uid"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"uname"] forKey:@"uname"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"mobile"] forKey:@"mobile"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"sid"] forKey:@"sid"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:nil];
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [self toast:responseObject[@"msg"] complete:nil];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }
    
}
#pragma mark - 计时器的操作
- (void)reduceSecond {
    if (_timeValue == 0)
    {
        self.timeValue = 60;
        [self.getBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        self.getBtn.enabled = YES;
        //关闭定时器
        [self.timer setFireDate:[NSDate distantFuture]];
        return;
    }
    self.getBtn.enabled = NO;
    [self.getBtn setTitle:[NSString stringWithFormat:@"%ds后重发", _timeValue] forState:UIControlStateDisabled];
    self.timeValue -= 1;
}


@end
