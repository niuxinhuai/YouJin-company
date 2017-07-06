//
//  BONoteVerifyLogiin.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/14.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BONoteVerifyLogiin.h"
#import "BORegisterVC.h"
#import "NSString+Hash.h"
#import <SMS_SDK/SMSSDK.h>
#import "MMNumberKeyboard.h"
#import "SVProgressHUD.h"
#import "LoginMessageModel.h"
#import "LoginPasswordModel.h"
#import <ShareSDK/ShareSDK.h>
#import "BindPhoneVC.h"
#import "NSMutableDictionary+Utilities.h"
#import "NSString+Utilities.h"
@interface BONoteVerifyLogiin ()<MMNumberKeyboardDelegate,UIScrollViewDelegate,BORegisterVCDelegate>
/**背景的imageView*/
@property (nonatomic, weak) UIImageView *backgroundImageV;

/**返回按钮*/
@property (nonatomic, weak) UIButton *backBtn;

/**验证码的登录按钮*/
@property (nonatomic, weak) UIButton *securityCodeBtn;

/**密码登录按钮*/
@property (nonatomic, weak) UIButton *passwordBtn;

/**scrollView左边的View*/
@property (nonatomic, weak) UIView *leftView;

/**scrollView右边的View*/
@property (nonatomic, weak) UIView *rightView;

/**中部的scrollView*/
@property (nonatomic, weak) UIScrollView *middleScrollView;

/**注册按钮的背景View*/
@property (nonatomic, weak) UIView *registerBackView;

@property (nonatomic, weak) UITextField *leftPhoneNumberTF;

@property (nonatomic, weak) UITextField *leftVerifyTextF;

/**获取验证码的btn*/
@property (nonatomic, weak) UIButton *getBtn;

/**右边textFile的号码*/
@property (nonatomic, weak) UITextField *rightPhoneNumberTF;

/**密码的textfield*/
@property (nonatomic, weak) UITextField *rightVerifyTextF;
@property (nonatomic, weak) AFHTTPSessionManager *mgr;

/**存储密码登录和验证码登录按钮的数组*/
@property (nonatomic, strong) NSMutableArray *btnArrayM;

/**当前处于选中状态的按钮*/
@property (nonatomic, weak) UIButton *selectBtn;

@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, assign) int timeValue;
/**计时的label*/
@property (nonatomic, weak) UILabel *afreshSendLabel;
@end

@implementation BONoteVerifyLogiin
- (void)dealloc {
    NSLog(@"BONoteVerifyLogiin");
}
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
- (NSMutableArray *)btnArrayM {
    if (_btnArrayM == nil) {
        _btnArrayM = [NSMutableArray array];
    }
    return _btnArrayM;
}
- (void)setSelectBtn:(UIButton *)selectBtn {
    [_selectBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    selectBtn.selected = YES;
    _selectBtn = selectBtn;
    if (selectBtn.tag == 1) {
        self.backgroundImageV.highlighted = NO;
    }else if (selectBtn.tag == 2) {
        self.backgroundImageV.highlighted = YES;
    }
    [selectBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAutoDismissKeyboardGesture];
    self.timeValue = 60;
    // 添加顶部的View
    [self setupTopView];
    // 添加中部的scrollView
    [self setupMiddleView];
    // 设置底部的bottomView
    [self setupBottomView];
}


#pragma mark - 在ViewWill中注册通知
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CloseCurrentView) name:@"test" object:nil];
}
#pragma mark - 移除通知
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"test" object:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.leftPhoneNumberTF resignFirstResponder];
    [self.leftVerifyTextF resignFirstResponder];
    [self.rightPhoneNumberTF resignFirstResponder];
    [self.rightVerifyTextF resignFirstResponder];
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
    // 添加验证码登录按钮
    UIButton *securityCodeBtn = [[UIButton alloc] init];
    self.securityCodeBtn = securityCodeBtn;
    [self.btnArrayM addObject:securityCodeBtn];
    [topView addSubview:securityCodeBtn];
    // 添加密码登录按钮
    UIButton *passwordBtn = [[UIButton alloc] init];
    [self.btnArrayM addObject:passwordBtn];
    self.passwordBtn = passwordBtn;
    [topView addSubview:passwordBtn];

    // 设置背景的imageView
    CGFloat backgroundX = 0;
    CGFloat backgroundY = 0;
    CGFloat backgroundW = BOScreenW;
    CGFloat backgroundH = topView.height;
    self.backgroundImageV.frame = CGRectMake(backgroundX, backgroundY, backgroundW, backgroundH);
    self.backgroundImageV.backgroundColor = [UIColor whiteColor];
    [self.backgroundImageV setImage:[UIImage imageNamed:@"img_denglubg_left"]];
    [self.backgroundImageV setHighlightedImage:[UIImage imageNamed:@"img_denglubg_right"]];
    // 设置返回按钮
    CGFloat backX = 15 * BOWidthRate;
    CGFloat backY = 15 * BOHeightRate;
    CGFloat backW = 25 * BOWidthRate;
    CGFloat backH = 25 * BOHeightRate;
    self.backBtn.frame = CGRectMake(backX, backY, backW, backH);
    [self.backBtn setImage:[UIImage imageNamed:@"icon_closed"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(CloseCurrentView) forControlEvents:UIControlEventTouchUpInside];
    // 设置验证码登录按钮
    CGFloat securityY = 137 * BOHeightRate;
    CGFloat securityH = 20 * BOHeightRate;
    
    [self.securityCodeBtn setTitle:@"验证码登录" forState:UIControlStateNormal];
    [self.securityCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.securityCodeBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [self.securityCodeBtn addTarget:self action:@selector(SecurityCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.securityCodeBtn.tag = 1;
    [self.securityCodeBtn sizeToFit];
    self.securityCodeBtn.center = CGPointMake(120 * BOWidthRate, securityY + securityH / 2.0);
    // 设置密码登录按钮
    CGFloat passwordX = CGRectGetMaxX(self.securityCodeBtn.frame) + 66 * BOWidthRate;
    CGFloat passwordY = 137 * BOHeightRate;
    CGFloat passwordW = 65 * BOWidthRate;
    CGFloat passwordH = 20 * BOHeightRate;
    self.passwordBtn.frame = CGRectMake(passwordX, passwordY, passwordW, passwordH);
    [self.passwordBtn setTitle:@"密码登录" forState:UIControlStateNormal];
    [self.passwordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.passwordBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.passwordBtn addTarget:self action:@selector(passwordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.passwordBtn.tag = 2;
    [self.passwordBtn sizeToFit];
    self.passwordBtn.center = CGPointMake(256 * BOWidthRate, securityY + securityH / 2.0);
}
#pragma mark - 关闭当前的View
- (void)CloseCurrentView {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 点击验证码登录的按钮
- (void)SecurityCodeBtnClick: (UIButton *)btn {
        [self.rightPhoneNumberTF resignFirstResponder];
        [self.rightVerifyTextF resignFirstResponder];

    // 设置选中按钮的文字为加粗
    [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [self.passwordBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.securityCodeBtn sizeToFit];
    [self.passwordBtn sizeToFit];
    self.backgroundImageV.highlighted = NO;
    CGPoint point = self.middleScrollView.contentOffset;
    point.x = 0;
    self.middleScrollView.contentOffset = point;
}
#pragma mark - 点击密码登录的按钮
- (void)passwordBtnClick: (UIButton *)btn {
        [self.leftPhoneNumberTF resignFirstResponder];
        [self.leftVerifyTextF resignFirstResponder];

    // 设置选中按钮的文字为加粗
    [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [self.securityCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.securityCodeBtn sizeToFit];
    [self.passwordBtn sizeToFit];
    self.backgroundImageV.highlighted = YES;
    CGPoint point = self.middleScrollView.contentOffset;
    point.x = BOScreenW;
    self.middleScrollView.contentOffset = point;
}
#pragma mark - 设置中部的scrollView
- (void)setupMiddleView {
    // 创建中部的scrollView
    CGFloat middleX = 0;
    CGFloat middleY = 185 * BOHeightRate;
    CGFloat middleW = BOScreenW;
    CGFloat middleH = 340 * BOHeightRate;
    UIScrollView *middleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(middleX, middleY, middleW, middleH)];
    middleScrollView.pagingEnabled = YES;
    middleScrollView.delegate = self;
    middleScrollView.contentSize = CGSizeMake(2 * BOScreenW, 0);
    middleScrollView.bounces = NO;
    middleScrollView.showsHorizontalScrollIndicator = NO;
    self.middleScrollView = middleScrollView;
    [self.view addSubview:middleScrollView];
    // 设置leftView
    CGFloat leftX = 0;
    CGFloat leftY = 0;
    CGFloat leftW = BOScreenW;
    CGFloat leftH = middleH;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(leftX, leftY, leftW, leftH)];
    leftView.backgroundColor = [UIColor whiteColor];
    self.leftView = leftView;
    [middleScrollView addSubview:leftView];
    // 设置左边View的子控件
    [self setupLeftViewChildView];
    // 创建rightView
    CGFloat rightX = BOScreenW;
    CGFloat rightY = 0;
    CGFloat rightW = BOScreenW;
    CGFloat rightH = middleH;
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(rightX, rightY, rightW, rightH)];
    rightView.backgroundColor = [UIColor whiteColor];
    self.rightView = rightView;
    [middleScrollView addSubview:rightView];
    // 设置右边View的子控件
    [self setupRightViewChildView];
    
}
#pragma mark - 设置左边View的子控件
- (void)setupLeftViewChildView {
    // 创建请输入手机号的textView
    CGFloat phoneX = (BOScreenW - 295 * BOWidthRate) * 0.5;
    CGFloat phoneY = 36 * BOHeightRate;
    CGFloat phoneW = 250 * BOWidthRate;
    CGFloat phoneH = 20 * BOHeightRate;
    UITextField *leftPhoneNumberTF = [[UITextField alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneW, phoneH)];
    self.leftPhoneNumberTF = leftPhoneNumberTF;
    [leftPhoneNumberTF addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    leftPhoneNumberTF.placeholder = @"请输入手机号";
    leftPhoneNumberTF.keyboardType = UIKeyboardTypeNumberPad;
//    //创建和配置键盘。
//    MMNumberKeyboard *keyboard = [[MMNumberKeyboard alloc] initWithFrame:CGRectZero];
//    keyboard.allowsDecimalPoint = YES;
//    keyboard.returnKeyTitle = @"完成";
//    keyboard.delegate = self;
//    leftPhoneNumberTF.inputView = keyboard;
    [self.leftView addSubview:leftPhoneNumberTF];
    // 添加第一条分割线
    CGFloat firstX = (BOScreenW - 295 * BOWidthRate) * 0.5;
    CGFloat firstY = CGRectGetMaxY(leftPhoneNumberTF.frame) + 16 * BOHeightRate;
    CGFloat firstW = 295 * BOWidthRate;
    CGFloat firstH = 1;
    UIView *leftFirstDivisionView = [[UIView alloc] initWithFrame:CGRectMake(firstX, firstY, firstW, firstH)];
    leftFirstDivisionView.backgroundColor = [UIColor colorWithHexString:@"#DFE3E6" alpha:1];
    [self.leftView addSubview:leftFirstDivisionView];
    
    // 创建请输入验证码的textView
    CGFloat verifyX = phoneX;
    CGFloat verifyY = CGRectGetMaxY(leftFirstDivisionView.frame) + 36 * BOHeightRate;
    CGFloat verifyW = phoneW;
    CGFloat verifyH = 20 * BOHeightRate;
    UITextField *leftVerifyTextF = [[UITextField alloc] initWithFrame:CGRectMake(verifyX, verifyY, verifyW, verifyH)];
//    MMNumberKeyboard *keyboard1 = [[MMNumberKeyboard alloc] initWithFrame:CGRectZero];
//    keyboard1.allowsDecimalPoint = YES;
//    keyboard1.returnKeyTitle = @"完成";
//    keyboard1.delegate = self;
//    leftVerifyTextF.inputView = keyboard1;
    self.leftVerifyTextF = leftVerifyTextF;
    leftVerifyTextF.keyboardType = UIKeyboardTypeNumberPad;
    leftVerifyTextF.placeholder = @"请输入验证码";
    [self.leftView addSubview:leftVerifyTextF];
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
    [self.leftView addSubview:getBtn];
    // 创建第二条分割线
    CGFloat secondX = firstX;
    CGFloat secondY = CGRectGetMaxY(leftVerifyTextF.frame) + 16 * BOHeightRate;
    CGFloat secondW = 295 * BOWidthRate;
    CGFloat secongH = 1;
    UIView *leftSecondDivisionView = [[UIView alloc] initWithFrame:CGRectMake(secondX, secondY, secondW, secongH)];
    leftSecondDivisionView.backgroundColor = [UIColor colorWithHexString:@"#DFE3E6" alpha:1];
    [self.leftView addSubview:leftSecondDivisionView];
    
    // 添加登录按钮背景View
    CGFloat backVX = firstX;
    CGFloat backVY = CGRectGetMaxY(leftSecondDivisionView.frame) +  34 * BOHeightRate;
    CGFloat backVW = secondW;
    CGFloat backVH = 44 * BOHeightRate;
    UIView *leftBackView = [[UIView alloc] initWithFrame:CGRectMake(backVX, backVY, backVW, backVH)];
    leftBackView.backgroundColor = [UIColor colorWithHexString:@"#4697FB" alpha:1];
    [self.leftView addSubview:leftBackView];
    leftBackView.layer.cornerRadius = 22 * BOHeightRate;
    leftBackView.layer.masksToBounds = YES;
    // 添加登录按钮
    UIButton *leftLoginBtn = [[UIButton alloc] init];
    leftLoginBtn.frame = leftBackView.bounds;
    [leftLoginBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [leftLoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [leftLoginBtn setTitleColor:[UIColor colorWithHexString:@"#FEFEFE" alpha:1] forState:UIControlStateNormal];
    [leftLoginBtn addTarget:self action:@selector(leftLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftBackView addSubview:leftLoginBtn];
    // 添加多少秒后重发的label
    CGFloat afreshX = 245 * BOWidthRate;
    CGFloat afreshY = CGRectGetMaxY(leftBackView.frame) + 15 * BOHeightRate;
    CGFloat afreshW = 90 * BOWidthRate;
    CGFloat afreshH = 30 * BOHeightRate;
    UILabel *afreshSendLabel = [[UILabel alloc] initWithFrame:CGRectMake(afreshX, afreshY, afreshW, afreshH)];
    self.afreshSendLabel = afreshSendLabel;
    afreshSendLabel.hidden = YES;
    afreshSendLabel.text = @"60S后重发";
    [afreshSendLabel setFont:[UIFont systemFontOfSize:12]];
    afreshSendLabel.textColor = [UIColor colorWithHexString:@"A6A6A7" alpha:1];
    afreshSendLabel.textAlignment = NSTextAlignmentCenter;
    afreshSendLabel.backgroundColor = [UIColor colorWithHexString:@"F2F2F5" alpha:1];
    afreshSendLabel.layer.cornerRadius = 15 * BOHeightRate;
    afreshSendLabel.layer.masksToBounds = YES;
    [self.leftView addSubview:afreshSendLabel];
    
}

#pragma mark - 设置右边View的子控件
- (void)setupRightViewChildView {
    // 创建请输入手机号的textView
    CGFloat phoneX = (BOScreenW - 295 * BOWidthRate) * 0.5;
    CGFloat phoneY = 36 * BOHeightRate;
    CGFloat phoneW = 250 * BOWidthRate;
    CGFloat phoneH = 20 * BOHeightRate;
    UITextField *rightPhoneNumberTF = [[UITextField alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneW, phoneH)];
    self.rightPhoneNumberTF = rightPhoneNumberTF;
    rightPhoneNumberTF.keyboardType = UIKeyboardTypeNumberPad;
    //创建和配置键盘。
//    MMNumberKeyboard *keyboard = [[MMNumberKeyboard alloc] initWithFrame:CGRectZero];
//    keyboard.allowsDecimalPoint = YES;
//    keyboard.returnKeyTitle = @"完成";
//    keyboard.delegate = self;
//    rightPhoneNumberTF.inputView = keyboard;
    rightPhoneNumberTF.placeholder = @"请输入手机号";
    [self.rightView addSubview:rightPhoneNumberTF];
    // 添加第一条分割线
    CGFloat firstX = (BOScreenW - 295 * BOWidthRate) * 0.5;
    CGFloat firstY = CGRectGetMaxY(rightPhoneNumberTF.frame) + 16 * BOHeightRate;
    CGFloat firstW = 295 * BOWidthRate;
    CGFloat firstH = 1;
    UIView *rightFirstDivisionView = [[UIView alloc] initWithFrame:CGRectMake(firstX, firstY, firstW, firstH)];
    rightFirstDivisionView.backgroundColor = [UIColor colorWithHexString:@"#DFE3E6" alpha:1];
    [self.rightView addSubview:rightFirstDivisionView];
    
    // 创建请输入密码的textView
    CGFloat verifyX = phoneX;
    CGFloat verifyY = CGRectGetMaxY(rightFirstDivisionView.frame) + 36 * BOHeightRate;
    CGFloat verifyW = phoneW;
    CGFloat verifyH = 20 * BOHeightRate;
    UITextField *rightVerifyTextF = [[UITextField alloc] initWithFrame:CGRectMake(verifyX, verifyY, verifyW, verifyH)];
    self.rightVerifyTextF = rightVerifyTextF;
    rightVerifyTextF.secureTextEntry = YES;
    // 添加眼睛imageView
    CGFloat eyeX = 300 * BOWidthRate;
    CGFloat eyeY = verifyY;
    CGFloat eyeWH = 20 * BOWidthRate;
    UIButton *eyeBtn = [[UIButton alloc] initWithFrame:CGRectMake(eyeX, eyeY, eyeWH, eyeWH)];
    [eyeBtn addTarget:self action:@selector(eyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [eyeBtn setImage:[UIImage imageNamed:@"icon_xianshi_nor"] forState:UIControlStateNormal];
    [eyeBtn setImage:[UIImage imageNamed:@"icon_xianshi_pre"] forState:UIControlStateSelected];
    [self.rightView addSubview:eyeBtn];
    //创建和配置键盘。
//    MMNumberKeyboard *keyboard1 = [[MMNumberKeyboard alloc] initWithFrame:CGRectZero];
//    keyboard1.allowsDecimalPoint = YES;
//    keyboard1.returnKeyTitle = @"完成";
//    keyboard1.delegate = self;
//    rightVerifyTextF.inputView = keyboard1;
    rightVerifyTextF.placeholder = @"请输入密码";
    [self.rightView addSubview:rightVerifyTextF];
    // 创建第二条分割线
    CGFloat secondX = firstX;
    CGFloat secondY = CGRectGetMaxY(rightVerifyTextF.frame) + 16 * BOHeightRate;
    CGFloat secondW = 295 * BOWidthRate;
    CGFloat secongH = 1;
    UIView *rightSecondDivisionView = [[UIView alloc] initWithFrame:CGRectMake(secondX, secondY, secondW, secongH)];
    rightSecondDivisionView.backgroundColor = [UIColor colorWithHexString:@"#DFE3E6" alpha:1];
    [self.rightView addSubview:rightSecondDivisionView];
    
    // 添加登录按钮背景View
    CGFloat backVX = firstX;
    CGFloat backVY = CGRectGetMaxY(rightSecondDivisionView.frame) +  34 * BOHeightRate;
    CGFloat backVW = secondW;
    CGFloat backVH = 44 * BOHeightRate;
    UIView *rightBackView = [[UIView alloc] initWithFrame:CGRectMake(backVX, backVY, backVW, backVH)];
    rightBackView.backgroundColor = [UIColor colorWithHexString:@"#4697FB" alpha:1];
    rightBackView.layer.cornerRadius = 22 * BOHeightRate;
    rightBackView.layer.masksToBounds = YES;
    [self.rightView addSubview:rightBackView];
    // 添加登录按钮
    UIButton *rightLoginBtn = [[UIButton alloc] init];
    rightLoginBtn.frame = rightBackView.bounds;
    [rightLoginBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [rightLoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [rightLoginBtn setTitleColor:[UIColor colorWithHexString:@"#FEFEFE" alpha:1] forState:UIControlStateNormal];
    [rightLoginBtn addTarget:self action:@selector(rightLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBackView addSubview:rightLoginBtn];
    // 添加注册的背景View
    CGFloat registerX = backVX;
    CGFloat registerY = CGRectGetMaxY(rightBackView.frame) + 11 * BOHeightRate;
    CGFloat registerW = backVW;
    CGFloat registerH = backVH;
    UIView *registerBackView = [[UIView alloc] initWithFrame:CGRectMake(registerX, registerY, registerW, registerH)];
    registerBackView.backgroundColor = [UIColor whiteColor];
    registerBackView.layer.borderWidth = 1;
    registerBackView.layer.borderColor = [UIColor colorWithHexString:@"#4697FB" alpha:1].CGColor;
    registerBackView.layer.cornerRadius = 22 * BOHeightRate;
    registerBackView.layer.masksToBounds = YES;
    self.registerBackView = registerBackView;
    [self.rightView addSubview:registerBackView];
    // 添加底部的注册按钮
    
    UIButton *registerBtn = [[UIButton alloc] init];
    registerBtn.frame = registerBackView.bounds;
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor colorWithHexString:@"#4697FB" alpha:1] forState:UIControlStateNormal];
    [registerBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [registerBtn addTarget:self action:@selector(registeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [registerBackView addSubview:registerBtn];
}
#pragma mark - 注册按钮的点击事件
- (void)registeBtnClick: (UIButton *)btn {
    BORegisterVC *registerVC = [[BORegisterVC alloc] init];
    registerVC.delegate = self;
    [self presentViewController:registerVC animated:YES completion:nil];
}
#pragma mark - 添加底部的View
- (void)setupBottomView {
    // 创建底部的View
    CGFloat bottomX = 0;
    CGFloat bottomY = 525 * BOHeightRate;
    CGFloat bottomW = BOScreenW;
    CGFloat bottomH = BOScreenH - 525 * BOHeightRate;
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(bottomX, bottomY, bottomW, bottomH)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    // 添加左边的分割线
    CGFloat leftDivisionX = (BOScreenW - 305 * BOWidthRate) * 0.5;
    CGFloat leftDivisionY = 20 * BOHeightRate;
    CGFloat leftDivisionW = 73 * BOWidthRate;
    CGFloat leftDivisionH = 1;
    UIView *leftDivisionView = [[UIView alloc] initWithFrame:CGRectMake(leftDivisionX, leftDivisionY, leftDivisionW, leftDivisionH)];
    leftDivisionView.backgroundColor = [UIColor colorWithHexString:@"DFE3E6" alpha:1];
    [bottomView addSubview:leftDivisionView];
    // 添加中部的使用第三方账号登录的label
    CGFloat thirdX = CGRectGetMaxX(leftDivisionView.frame) + 12 * BOWidthRate;
    CGFloat thirdY = 12.5 * BOHeightRate;
    CGFloat thirdW = 135 * BOWidthRate;
    CGFloat thirdH = 15 * BOHeightRate;
    UILabel *thirdPartyLabel = [[UILabel alloc] initWithFrame:CGRectMake(thirdX, thirdY, thirdW, thirdH)];
    thirdPartyLabel.text = @"使用第三方账号登录";
    thirdPartyLabel.textColor = [UIColor colorWithHexString:@"#B3B3B3" alpha:1];
    [thirdPartyLabel setFont:[UIFont systemFontOfSize:14]];
    thirdPartyLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:thirdPartyLabel];
    // 添加右边的分割线
    CGFloat rightDivisionX = CGRectGetMaxX(thirdPartyLabel.frame) + 12 * BOWidthRate;
    CGFloat rightDivisionY = leftDivisionY;
    CGFloat rightDivisionW = leftDivisionW;
    CGFloat rightDivisionH = leftDivisionH;
    UIView *rightDivisionView = [[UIView alloc] initWithFrame:CGRectMake(rightDivisionX, rightDivisionY, rightDivisionW, rightDivisionH)];
    rightDivisionView.backgroundColor = [UIColor colorWithHexString:@"DFE3E6" alpha:1];
    [bottomView addSubview:rightDivisionView];
    // 添加微信登录的按钮
    CGFloat weiXinX = (BOScreenW - 40) * 0.5;
    CGFloat weiXinY = CGRectGetMaxY(thirdPartyLabel.frame) + 35 * BOHeightRate;
    CGFloat weiXinWH = 40 * BOWidthRate;
    UIButton *weiXinBtn = [[UIButton alloc] initWithFrame:CGRectMake(weiXinX, weiXinY, weiXinWH, weiXinWH)];
    [weiXinBtn setImage:[UIImage imageNamed:@"icon_wenxin"] forState:UIControlStateNormal];
    [weiXinBtn addTarget:self action:@selector(weixinBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:weiXinBtn];
//    // 添加微博登录的按钮
//    CGFloat weiboX = CGRectGetMaxX(weiXinBtn.frame) + 77.5 * BOWidthRate;
//    CGFloat weiboY = weiXinY;
//    CGFloat weiboWH = weiXinWH;
//    UIButton *weiboBtn = [[UIButton alloc] initWithFrame:CGRectMake(weiboX, weiboY, weiboWH, weiboWH)];
//    [weiboBtn setImage:[UIImage imageNamed:@"icon_weibo"] forState:UIControlStateNormal];
//    [bottomView addSubview:weiboBtn];
//    // 添加QQ登录的按钮
//    CGFloat qqX = CGRectGetMaxX(weiboBtn.frame) + 77.5 * BOWidthRate;
//    CGFloat qqY = weiXinY;
//    CGFloat qqWH = weiXinWH;
//    UIButton *qqBtn = [[UIButton alloc] initWithFrame:CGRectMake(qqX, qqY, qqWH, qqWH)];
//    [qqBtn setImage:[UIImage imageNamed:@"icon_qq"] forState:UIControlStateNormal];
//    [bottomView addSubview:qqBtn];
}

#pragma mark - textField的值改变监听方法
- (void)textFieldChange: (UITextField *)textField {
    if (self.leftPhoneNumberTF.text.length == 11) {
        self.getBtn.enabled = YES;
    }else if (self.leftPhoneNumberTF.text.length < 11) {
        self.getBtn.enabled = NO;
    }
}
#pragma mark - 获取验证码按钮的点击方法
- (void)getBtnClick:(UIButton *)btn {
    [self.timer setFireDate:[NSDate distantPast]];
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.leftPhoneNumberTF.text
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

    if (self.leftPhoneNumberTF.text.length == 0) {
        [self toast:@"号码不能空" complete:nil];
    }else if (self.leftVerifyTextF.text.length == 0) {
        [self toast:@"验证码不能为空" complete:nil];
    }else if(self.leftVerifyTextF.text.length != 0 && self.leftVerifyTextF.text.length != 0) {
        // 验证码登录
        NSString *loadString = [NSString stringWithFormat:@"%@App/login", BASEURL];
        NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
        parameters1[@"mobile"] = self.leftPhoneNumberTF.text;
        parameters1[@"verycode"] = self.leftVerifyTextF.text;
        //    parameters1[@"sid"] = nil;
        parameters1[@"os"] = @"Ios";
        parameters1[@"at"] = tokenString;
        parameters1[@"login_type"] = @"verycode";
        [self.mgr POST:loadString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"r"] intValue] == 1) {
                NSDictionary *dictionary = responseObject[@"data"];
                [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"uid"] forKey:@"uid"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"uname"] forKey:@"uname"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"mobile"] forKey:@"mobile"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"sid"] forKey:@"sid"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self pushLoginSuccessNotification];
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [self toast:responseObject[@"msg"] complete:nil];
            }
          
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        }];

    }
    
}
#pragma mark - 右边密码登录的按钮的点击
- (void)rightLoginBtnClick:(UIButton *)btn {
    if (self.rightPhoneNumberTF.text.length == 0) {
        [self toast:@"号码不能空" complete:nil];
    }else if (self.rightVerifyTextF.text.length == 0) {
        [self toast:@"密码不能为空" complete:nil];
    }else if(self.rightPhoneNumberTF.text.length != 0 && self.rightVerifyTextF.text.length != 0) {
        // 请求cd和salt
        NSString *url = [NSString stringWithFormat:@"%@App/getcd",BASEURL];
        NSMutableDictionary *parameters2 = [NSMutableDictionary dictionary];
        parameters2[@"at"] = tokenString;
        parameters2[@"username"] = self.rightPhoneNumberTF.text;
        [self.mgr POST:url parameters:parameters2 progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"r"] intValue] == 1) {
                LoginPasswordModel *model = [LoginPasswordModel mj_objectWithKeyValues:responseObject];
                // 拼接最终的密码字
                NSString *passwordTemp = [self.rightVerifyTextF.text md5String];
                passwordTemp = [[passwordTemp stringByAppendingString:model.salt] md5String];
                NSString *loadString = [NSString stringWithFormat:@"%@App/login", BASEURL];
                //        NSString *loadString = @"http://120.24.43.90/index_wx.php/App/login";
                NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
                parameters1[@"mobile"] = self.rightPhoneNumberTF.text;
                parameters1[@"password"] = passwordTemp;
                parameters1[@"os"] = @"Ios";
                parameters1[@"at"] = tokenString;
                parameters1[@"login_type"] = @"pass";
                [self.mgr POST:loadString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([responseObject[@"r"] intValue] == 1) {
//                        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                        NSLog(@"%@",responseObject);
                        NSDictionary *dictionary = responseObject[@"data"];
                        [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"uid"] forKey:@"uid"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"uname"] forKey:@"uname"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"mobile"] forKey:@"mobile"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"sid"] forKey:@"sid"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        [self pushLoginSuccessNotification];
                        [self dismissViewControllerAnimated:YES completion:nil];
                    } else {
                        [self toast:responseObject[@"msg"] complete:nil];
                    }
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error]];
                }];

            }
            else {
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
        self.afreshSendLabel.hidden = YES;
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

#pragma mark - <BORegisterVCDelegate>
- (void)BORegisterVCDelegateDidRegisterSuccess:(BORegisterVC *)registerVC {
    [self pushLoginSuccessNotification];
}

#pragma mark - UIScorllViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / BOScreenW;
    if (page == 1) {
        [self.leftPhoneNumberTF resignFirstResponder];
        [self.leftVerifyTextF resignFirstResponder];
    }else if (page == 0) {
        [self.rightPhoneNumberTF resignFirstResponder];
        [self.rightVerifyTextF resignFirstResponder];
    }
    [self setSelectBtn:self.btnArrayM[page]];
}

#pragma mark - 设置密码text是密文还是明文
- (void)eyeBtnClick:(UIButton *)btn {
    if (btn.selected == YES) {
        btn.selected = NO;
        self.rightVerifyTextF.secureTextEntry = YES;
    }else {
        btn.selected = YES;
        self.rightVerifyTextF.secureTextEntry = NO;
    }
}


#pragma mark - 微信登录按钮的点击事件
- (void)weixinBtnClick {
    [ShareSDK authorize:SSDKPlatformTypeWechat settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess)
        {
            
            [self requireBindingStatusWithUserInfo:user platform:SSDKPlatformTypeWechat];
        }
    }];

}

- (void)requireBindingStatusWithUserInfo:(SSDKUser *)user platform:(SSDKPlatformType) platform {
    NSString *url = [NSString stringWithFormat:@"%@Common/othersLoginCallback",BASEURL];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"at"] = tokenString;
    [self requireBindingStatusWayOfRequestBodyWithPlatform:platform requestBody:dictionary];
    NSDictionary *weixinDic = [self extractThirdPartRawValueWithUserInfo:user platform:platform];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:weixinDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    dictionary[@"weixin_array"] = jsonString;
    
    
    [self.mgr POST:url parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"status"] && ![responseObject[@"status"] isKindOfClass:[NSNull class]]) {
            if ([responseObject[@"status"] intValue] == 0) {
                BindPhoneVC *bindPhoneVC = [[BindPhoneVC alloc] init];
                NSMutableString *stringM = [jsonString mutableCopy];
                bindPhoneVC.weixinString = stringM;
                [self.navigationController pushViewController:bindPhoneVC animated:YES];

            }else if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]){
                [self userStorageWithMessage:responseObject[@"data"]];
                [self pushLoginSuccessNotification];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (NSMutableDictionary *)requireBindingStatusWayOfRequestBodyWithPlatform:(SSDKPlatformType) platform requestBody:(NSMutableDictionary *)body {
    switch (platform) {
        case SSDKPlatformTypeWechat:
            [body setObject:@"weixin" forKey:@"way"];
            break;
        case SSDKPlatformTypeQQ:
            [body setObject:@"QQ" forKey:@"way"];
            break;
        case SSDKPlatformTypeSinaWeibo:
            [body setObject:@"weibo" forKey:@"way"];
            break;
        default:
            break;
    }
    return body;
}

- (NSDictionary *)extractThirdPartRawValueWithUserInfo:(SSDKUser *)user platform:(SSDKPlatformType) platform {
    NSMutableDictionary *extractDic = [NSMutableDictionary dictionary];
    NSDictionary *dic = [user.rawData mutableCopy];
    [extractDic setNewObject:dic[@"nickname"] forKey:@"nickname"];
    [extractDic setNewObject:dic[@"openid"] forKey:@"openid"];
    [extractDic setNewObject:dic[@"unionid"] forKey:@"unionid"];
    [extractDic setNewObject:dic[@"sex"] forKey:@"sex"];
    [extractDic setNewObject:dic[@"city"] forKey:@"city"];
    [extractDic setNewObject:dic[@"province"] forKey:@"province"];
    [extractDic setNewObject:dic[@"country"] forKey:@"country"];
    [extractDic setNewObject:dic[@"headimgurl"] forKey:@"head_image"];
    return extractDic;
}


- (void)loginWithMobilePhone:(NSString *)phone password:(NSString *)password verycode:(NSString *)code sid:(NSNumber *)sid loginType:(NSString *)type thirdWay:(BOOL)isThirdWay weixinArray:(NSDictionary *)wxDic {
    NSString *loadString = [NSString stringWithFormat:@"%@App/login", BASEURL];
    NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
    [parameters1 setNewObject:phone forKey:@"mobile"];
    [parameters1 setNewObject:code forKey:@"verycode"];
    [parameters1 setNewObject:sid forKey:@"sid"];
    [parameters1 setNewObject:@"Ios" forKey:@"os"];
    [parameters1 setNewObject:tokenString forKey:@"at"];
    [parameters1 setNewObject:type forKey:@"login_type"];
    [parameters1 setNewObject:@(isThirdWay) forKey:@"is_other_way"];
    [parameters1 setNewObject:[NSString jsonStringWithDictionary:wxDic] forKey:@"weixin_array"];
    [self.mgr POST:loadString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //            NSLog(@"%@",responseObject);
        if ([responseObject[@"r"] intValue] == 1) {
            //                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [self userStorageWithMessage:responseObject[@"data"]];
            [self pushLoginSuccessNotification];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


- (void)userStorageWithMessage:(NSDictionary *)message {
    [[NSUserDefaults standardUserDefaults] setObject:message[@"uid"] forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults] setObject:message[@"uname"] forKey:@"uname"];
    [[NSUserDefaults standardUserDefaults] setObject:message[@"mobile"] forKey:@"mobile"];
    [[NSUserDefaults standardUserDefaults] setObject:message[@"sid"] forKey:@"sid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)pushLoginSuccessNotification {
    if ([self.delegate respondsToSelector:@selector(BONoteVerifyLoginViewControllerDidLoginSucess:)]) {
        [self.delegate BONoteVerifyLoginViewControllerDidLoginSucess:self];
    }
}


@end
