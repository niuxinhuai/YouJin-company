//
//  SettingLoginPasswordVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "SettingLoginPasswordVC.h"
#import "UIImage+UIColor.h"
#import "NSString+Hash.h"
@interface SettingLoginPasswordVC ()
@property (nonatomic, weak) UITextField *passwordTextF;

@property (nonatomic, weak) UIBarButtonItem *rightBtnItem;

@property (nonatomic, weak) AFHTTPSessionManager *mgr;
@end

@implementation SettingLoginPasswordVC
#pragma mark - 懒加载数据
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
    // 添加设置密码的View
    [self setupNewPasswordView];
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

    
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:self.titleString];
    self.navigationItem.titleView = titleView;
    
    // 设置rightButtonItem
    UIBarButtonItem *rightBtnItem = [UIBarButtonItem btnWithImage:nil title:@"完成" titleColor:[UIColor whiteColor] target:self action:@selector(requestNetData)];
    self.rightBtnItem = rightBtnItem;
    //    rightBtnItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightBtnItem;
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置手机号的View
- (void)setupNewPasswordView {
    // 创建新密码的View
    CGFloat phoneNumX = 0;
    CGFloat phoneNumY = 8 * BOHeightRate;
    CGFloat phoneNumW = BOScreenW;
    CGFloat phoneNumH = 45 * BOHeightRate;
    UIView *newPasswordView = [[UIView alloc] initWithFrame:CGRectMake(phoneNumX, phoneNumY, phoneNumW, phoneNumH)];
    newPasswordView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:newPasswordView];
    // 创建新密码的label
    CGFloat phoneLX = 15 * BOWidthRate;
    CGFloat phoneLY = 12.5 * BOHeightRate;
    CGFloat phoneLW = 55 * BOWidthRate;
    CGFloat phoneLH = 20 * BOHeightRate;
    UILabel *newPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(phoneLX, phoneLY, phoneLW, phoneLH)];
    newPasswordLabel.text = @"新密码";
    [newPasswordLabel setFont:[UIFont systemFontOfSize:15]];
    [newPasswordLabel setTextColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
    [newPasswordView addSubview:newPasswordLabel];
    //创建密码的textfiled
    CGFloat phoneTX = CGRectGetMaxX(newPasswordLabel.frame) + 15 * BOWidthRate;
    CGFloat phoneTY = phoneLY;
    CGFloat phoneTW = 140 * BOWidthRate;
    CGFloat phoneTH = 20 * BOHeightRate;
    UITextField *passwordTextF = [[UITextField alloc] initWithFrame:CGRectMake(phoneTX, phoneTY, phoneTW, phoneTH)];
    [passwordTextF setFont:[UIFont systemFontOfSize:14]];
    [passwordTextF setTextColor:[UIColor colorWithHexString:@"#B3B3B3" alpha:1]];
    passwordTextF.placeholder = @"请输入6-12位数字或字母密码";
    passwordTextF.secureTextEntry = YES;
    [passwordTextF addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    self.passwordTextF = passwordTextF;
    [newPasswordView addSubview:passwordTextF];
    // 创建眼睛imageView
    CGFloat eyeX = 339 * BOWidthRate;
    CGFloat eyeY = 12.5 * BOHeightRate;
    CGFloat eyeWH = 20 * BOWidthRate;
    UIButton *eyeBtn = [[UIButton alloc] initWithFrame:CGRectMake(eyeX, eyeY, eyeWH, eyeWH)];
    [eyeBtn setImage:[UIImage imageNamed:@"icon_xianshi_pre"] forState:UIControlStateSelected];
    [eyeBtn setImage:[UIImage imageNamed:@"icon_xianshi_nor"] forState:UIControlStateNormal];
    [eyeBtn addTarget:self action:@selector(eyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [newPasswordView addSubview:eyeBtn];
}
#pragma mark 眼睛btn的点击事件
- (void)eyeBtnClick:(UIButton *)btn {
    if (btn.selected) {
        btn.selected = NO;
        self.passwordTextF.secureTextEntry = YES;
    } else {
        btn.selected = YES;
        self.passwordTextF.secureTextEntry = NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 监听textField的值得改变
- (void)textChange:(UITextField *)textFiled {
    if (textFiled.text.length > 0) {
        self.rightBtnItem.enabled = YES;
    }
}
- (void)requestNetData {
    NSString *url = [NSString stringWithFormat:@"%@Ucenter/resetLoginpass",BASEURL];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"at"] = tokenString;
    dictionary[@"sid"] = USERSid;
    dictionary[@"uid"] = USERUID;
    dictionary[@"loginpass"] = [self.passwordTextF.text md5String];
    
    [self.mgr POST:url parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] intValue] == 1) {
            [self.passwordTextF resignFirstResponder];
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]  animated:YES];
        }
        [self toast:responseObject[@"msg"] complete:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
@end
