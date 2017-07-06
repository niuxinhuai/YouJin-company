//
//  BORegisterVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BORegisterVC.h"
#import "NSString+Hash.h"
#import <SMS_SDK/SMSSDK.h>
#import "MMNumberKeyboard.h"
#import "SVProgressHUD.h"
#import "PresentWebVC.h"
#import <IQKeyboardManager.h>
@interface BORegisterVC()<MMNumberKeyboardDelegate>
/**背景的imageView*/
@property (nonatomic, weak) UIImageView *backgroundImageV;
/**返回按钮*/
@property (nonatomic, weak) UIButton *backBtn;

/**中部的View*/
@property (nonatomic, weak) UIView *middleView;

/**验证码的textField*/
@property (nonatomic, weak) UITextField *VerifyTextF;

/**手机号的textField*/
@property (nonatomic, weak) UITextField *PhoneNumberTF;

/**密码的textField*/
@property (nonatomic, weak) UITextField *passwordTF;
@property (nonatomic, weak) AFHTTPSessionManager *mgr;

/**获取验证码的butto*/
@property (nonatomic, weak) UIButton *getBtn;

@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, assign) int timeValue;

@end

@implementation BORegisterVC
- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceSecond) userInfo:nil repeats:YES];
        
        //刚开始进来 关闭定时器
        [_timer setFireDate:[NSDate distantFuture]];
    }
    return _timer;
}
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAutoDismissKeyboardGesture];
    self.timeValue = 60;
    // 添加顶部的View
    [self setupTopView];
    // 添加中部的View
    [self setupMiddleView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    [[IQKeyboardManager sharedManager]setEnable:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager]setEnable:YES];
}

#pragma mark - 添加顶部的View
- (void)setupTopView {
    // 创建顶部的View
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topW = BOScreenW;
    CGFloat topH = 185 * BOHeightRate;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(topX, topY, topW, topH)];
    [self.view addSubview:topView];
    
    // 添加背景的imageView
    UIImageView *backgroundImageV = [[UIImageView alloc] init];
    self.backgroundImageV = backgroundImageV;
    [topView addSubview:backgroundImageV];
    // 添加返回按钮
    UIButton *backBtn = [[UIButton alloc] init];
    self.backBtn = backBtn;
    [topView addSubview:backBtn];
    // 设置背景的imageView
    CGFloat backgroundX = 0;
    CGFloat backgroundY = 0;
    CGFloat backgroundW = BOScreenW;
    CGFloat backgroundH = topView.height;
    self.backgroundImageV.frame = CGRectMake(backgroundX, backgroundY, backgroundW, backgroundH);
    self.backgroundImageV.backgroundColor = [UIColor whiteColor];
    [self.backgroundImageV setImage:[UIImage imageNamed:@"img_denglubgwanquan"]];

    // 设置返回按钮
    CGFloat backX = 15 * BOWidthRate;
    CGFloat backY = 15 * BOHeightRate;
    CGFloat backW = 25 * BOWidthRate;
    CGFloat backH = 25 * BOHeightRate;
    self.backBtn.frame = CGRectMake(backX, backY, backW, backH);
    [self.backBtn setImage:[UIImage imageNamed:@"icon_closed"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(CloseCurrentView) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - 关闭当前的View
- (void)CloseCurrentView {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 设置View的子控件
- (void)setupMiddleView {
    // 创建中部的scrollView
    CGFloat middleX = 0;
    CGFloat middleY = 185 * BOHeightRate;
    CGFloat middleW = BOScreenW;
    CGFloat middleH =BOScreenH - middleY;
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(middleX, middleY, middleW, middleH)];
    middleView.backgroundColor = [UIColor whiteColor];
    self.middleView = middleView;
    [self.view addSubview:middleView];
    // 创建请输入手机号的textView
    CGFloat phoneX = (BOScreenW - 295 * BOWidthRate) * 0.5 + 10 * BOWidthRate;
    CGFloat phoneY = 36 * BOHeightRate;
    CGFloat phoneW = 250 * BOWidthRate;
    CGFloat phoneH = 20 * BOHeightRate;
    UITextField *PhoneNumberTF = [[UITextField alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneW, phoneH)];
    //创建和配置键盘。
    PhoneNumberTF.keyboardType = UIKeyboardTypeNumberPad;
    [PhoneNumberTF addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    self.PhoneNumberTF = PhoneNumberTF;
    PhoneNumberTF.placeholder = @"请输入手机号";
    [self.middleView addSubview:PhoneNumberTF];
    // 添加第一条分割线
    CGFloat firstX = (BOScreenW - 295 * BOWidthRate) * 0.5;
    CGFloat firstY = CGRectGetMaxY(PhoneNumberTF.frame) + 16 * BOHeightRate;
    CGFloat firstW = 295 * BOWidthRate;
    CGFloat firstH = 1;
    UIView *leftFirstDivisionView = [[UIView alloc] initWithFrame:CGRectMake(firstX, firstY, firstW, firstH)];
    leftFirstDivisionView.backgroundColor = [UIColor colorWithHexString:@"#DFE3E6" alpha:1];
    [self.middleView addSubview:leftFirstDivisionView];
    
    // 创建请输入验证码的textView
    CGFloat verifyX = phoneX;
    CGFloat verifyY = CGRectGetMaxY(leftFirstDivisionView.frame) + 36 * BOHeightRate;
    CGFloat verifyW = phoneW;
    CGFloat verifyH = 20 * BOHeightRate;
    UITextField *VerifyTextF = [[UITextField alloc] initWithFrame:CGRectMake(verifyX, verifyY, verifyW, verifyH)];
    VerifyTextF.keyboardType = UIKeyboardTypeNumberPad;
    //创建和配置键盘。
//    MMNumberKeyboard *keyboard1 = [[MMNumberKeyboard alloc] initWithFrame:CGRectZero];
//    keyboard1.allowsDecimalPoint = YES;
//    keyboard1.returnKeyTitle = @"完成";
//    keyboard1.delegate = self;
//    VerifyTextF.inputView = keyboard1;
    self.VerifyTextF = VerifyTextF;
    VerifyTextF.placeholder = @"请输入验证码";
    [self.middleView addSubview:VerifyTextF];
    // 添加获取验证码的按钮
    CGFloat getX = 245 * BOWidthRate;
    CGFloat getY = CGRectGetMaxY(leftFirstDivisionView.frame) + 24 * BOHeightRate;
    CGFloat getW = 90 * BOWidthRate;
    CGFloat getH = 30 * BOHeightRate;
    UIButton *getBtn = [[UIButton alloc] initWithFrame:CGRectMake(getX, getY, getW, getH)];
    [getBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getBtn setTitleColor:BOColor(174, 174, 175) forState:UIControlStateDisabled];
    [getBtn setBackgroundImage:[UIImage imageWithColor:BOColor(242, 242, 245) WithAlpha:1] forState:UIControlStateDisabled];
    [getBtn setTitleColor:[UIColor colorWithHexString:@"#FEFEFE" alpha:1] forState:UIControlStateNormal];
    getBtn.backgroundColor = [UIColor colorWithHexString:@"#A5DB30" alpha:1];
    [getBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    getBtn.layer.cornerRadius = 15 * BOHeightRate;
    getBtn.layer.masksToBounds = YES;
    getBtn.enabled = NO;
    [getBtn addTarget:self action:@selector(getBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.getBtn = getBtn;
    [self.middleView addSubview:getBtn];
    // 创建第二条分割线
    CGFloat secondX = firstX;
    CGFloat secondY = CGRectGetMaxY(VerifyTextF.frame) + 16 * BOHeightRate;
    CGFloat secondW = 295 * BOWidthRate;
    CGFloat secongH = 1;
    UIView *leftSecondDivisionView = [[UIView alloc] initWithFrame:CGRectMake(secondX, secondY, secondW, secongH)];
    leftSecondDivisionView.backgroundColor = [UIColor colorWithHexString:@"#DFE3E6" alpha:1];
    [self.middleView addSubview:leftSecondDivisionView];
    // 添加请输入6-12位数字或字母密码
    CGFloat passwordX = phoneX;
    CGFloat passwordY = CGRectGetMaxY(leftSecondDivisionView.frame) + 36 * BOHeightRate;
    CGFloat passwordW = 230 * BOWidthRate;
    CGFloat passwordH = 20 * BOHeightRate;
    UITextField *passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(passwordX, passwordY, passwordW, passwordH)];
    self.passwordTF = passwordTF;
    //创建和配置键盘。
//    MMNumberKeyboard *keyboard2 = [[MMNumberKeyboard alloc] initWithFrame:CGRectZero];
//    keyboard2.allowsDecimalPoint = YES;
//    keyboard2.returnKeyTitle = @"完成";
//    keyboard2.delegate = self;
//    passwordTF.inputView = keyboard2;
    passwordTF.secureTextEntry = YES;
    passwordTF.placeholder = @"请输入6-12位数字或字母密码";
    [middleView addSubview:passwordTF];
    // 添加眼睛imageView
    CGFloat eyeX = 300 * BOWidthRate;
    CGFloat eyeY = passwordY;
    CGFloat eyeWH = 20 * BOWidthRate;
    UIButton *eyeBtn = [[UIButton alloc] initWithFrame:CGRectMake(eyeX, eyeY, eyeWH, eyeWH)];
    [eyeBtn addTarget:self action:@selector(eyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [eyeBtn setImage:[UIImage imageNamed:@"icon_xianshi_nor"] forState:UIControlStateNormal];
    [eyeBtn setImage:[UIImage imageNamed:@"icon_xianshi_pre"] forState:UIControlStateSelected];
    [middleView addSubview:eyeBtn];
    // 添加第三条分割线
    CGFloat thirdX = firstX;
    CGFloat thirdY = CGRectGetMaxY(passwordTF.frame) + 16 * BOHeightRate;
    CGFloat thirdW = 295 * BOWidthRate;
    CGFloat thirdH = 1;
    UIView *thirdDivisionView = [[UIView alloc] initWithFrame:CGRectMake(thirdX, thirdY, thirdW, thirdH)];
    thirdDivisionView.backgroundColor = [UIColor colorWithHexString:@"#DFE3E6" alpha:1];
    [self.middleView addSubview:thirdDivisionView];
    // 添加注册按钮背景View
    CGFloat backVX = firstX;
    CGFloat backVY = CGRectGetMaxY(thirdDivisionView.frame) +  34 * BOHeightRate;
    CGFloat backVW = secondW;
    CGFloat backVH = 44 * BOHeightRate;
    UIView *leftBackView = [[UIView alloc] initWithFrame:CGRectMake(backVX, backVY, backVW, backVH)];
    leftBackView.backgroundColor = [UIColor colorWithHexString:@"#4697FB" alpha:1];
    [self.middleView addSubview:leftBackView];
    leftBackView.layer.cornerRadius = 22 * BOHeightRate;
    leftBackView.layer.masksToBounds = YES;
    // 添加注册按钮
    
    UIButton *leftLoginBtn = [[UIButton alloc] init];
    leftLoginBtn.frame = leftBackView.bounds;
    [leftLoginBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [leftLoginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [leftLoginBtn setTitleColor:[UIColor colorWithHexString:@"#FEFEFE" alpha:1] forState:UIControlStateNormal];
    [leftLoginBtn addTarget:self action:@selector(rigisterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftBackView addSubview:leftLoginBtn];
    
    // 添加注册即表示你同意lable
    UILabel *agreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(leftBackView.frame) + 14 * BOHeightRate, BOScreenW, 13 * BOHeightRate)];
    [agreeLabel setFont:[UIFont systemFontOfSize:12]];
    agreeLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    agreeLabel.userInteractionEnabled = YES;
    agreeLabel.textAlignment = NSTextAlignmentCenter;
    [middleView addSubview:agreeLabel];
    
    // 给label添加点按手势
    UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLabel)];
    [agreeLabel addGestureRecognizer:PrivateLetterTap];
    // 设置富文本属性
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"注册即表示你同意有金用户服务协议"];
    [AttributedStr setAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12],NSFontAttributeName,[UIColor colorWithHexString:@"#999999" alpha:1],NSForegroundColorAttributeName, nil] range:NSMakeRange(0, 8)];
    [AttributedStr setAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12],NSFontAttributeName,[UIColor colorWithHexString:@"#68A8F9" alpha:1],NSForegroundColorAttributeName, nil] range:NSMakeRange(8, AttributedStr.length - 8)];
    agreeLabel.attributedText = AttributedStr;
}

#pragma mark - 同意用户协议的点击事件
- (void)clickLabel {
    PresentWebVC *presentWebVC = [[PresentWebVC alloc] init];
    presentWebVC.titleString = @"用户服务协议";
    presentWebVC.urlString = [NSString stringWithFormat:@"%@mobile/page/userAgreement.html",BASEWEBURl];
    [self presentViewController:presentWebVC animated:YES completion:nil];
}
#pragma mark - textField的值改变监听方法
- (void)textFieldChange: (UITextField *)textField {
    if (self.PhoneNumberTF.text.length == 11) {
        self.getBtn.enabled = YES;
    }else if (self.PhoneNumberTF.text.length < 11) {
        self.getBtn.enabled = NO;
    }
}
#pragma mark - 设置密码text是密文还是明文
- (void)eyeBtnClick:(UIButton *)btn {
    if (btn.selected == YES) {
        btn.selected = NO;
        self.passwordTF.secureTextEntry = YES;
    }else {
        btn.selected = YES;
        self.passwordTF.secureTextEntry = NO;
    }
}
#pragma mark - 获取验证码按钮的点击方法
- (void)getBtnClick:(UIButton *)btn {
    [self.timer setFireDate:[NSDate distantPast]];
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.PhoneNumberTF.text
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error){
                                     if (!error) {
                                         
                                     } else {
                                         
                                     }
                                 }];
}
#pragma mark - 注册的按钮的点击
- (void)rigisterBtnClick:(UIButton *)btn {
    if (self.PhoneNumberTF.text.length == 0) {
        [self toast:@"号码不能空" complete:nil];
    }else if (self.VerifyTextF.text.length == 0) {
        [self toast:@"验证码不能为空" complete:nil];
    }else if (self.passwordTF.text.length == 0) {
        [self toast:@"密码不能为空" complete:nil];
    }else if(self.PhoneNumberTF.text.length != 0 && self.VerifyTextF.text.length != 0 && self.passwordTF.text.length != 0) {
        // 验证码登录
        NSString *loadString = [NSString stringWithFormat:@"%@App/register",BASEURL];
//        NSString *loadString = @"http://120.24.43.90/index_wx.php/App/mrcode";
        NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
        parameters1[@"mobile"] = self.PhoneNumberTF.text;
        parameters1[@"verycode"] = self.VerifyTextF.text ;
        //    parameters1[@"sid"] = nil;
        parameters1[@"at"] = tokenString;
        parameters1[@"password"] = [self.passwordTF.text md5String];
        parameters1[@"os"] = @"Ios";
        [self.mgr POST:loadString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"r"] intValue] == 1) {
                [self toast:@"注册成功" complete:nil];
                [self pushRegisterSuccessNotification];
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


#pragma mark - helpMethod

- (void)pushRegisterSuccessNotification {
    if ([self.delegate respondsToSelector:@selector(BORegisterVCDelegateDidRegisterSuccess:)]) {
        [self.delegate BORegisterVCDelegateDidRegisterSuccess:self];
    }
}

@end
