//
//  SetPayPasswordViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "SetPayPasswordViewController.h"
#import "ConfirmAgainViewController.h"

@interface SetPayPasswordViewController ()<UITextFieldDelegate>

@property (nonatomic ,strong)UIButton *rightButton;//rightBarButton
@property (nonatomic ,strong)NSMutableArray *roundArr;//存放小黑圆点view的数组
@property (nonatomic ,strong)UITextField *passTextField;//唯一的一个输入的键盘

@end

@implementation SetPayPasswordViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"设置支付密码"];
    //设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    self.navigationItem.leftBarButtonItem = btnItem;
    
    [_passTextField becomeFirstResponder];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _roundArr = [[NSMutableArray alloc]init];
    //设置支付密码
    [self thePasswordView];
    
    _passTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    _passTextField.delegate = self;
    _passTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_passTextField addTarget:self action:@selector(textFieldDiChangeth:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_passTextField];
}
- (void)textFieldDiChangeth:(UITextField *)sender
{
    NSLog(@"输入de密码个数%lu",sender.text.length);
    NSLog(@"输入的密码%@",sender.text);
    int number = (int)sender.text.length;
    [self setCount:number];
    if (number == 6)
    {
        _rightButton.userInteractionEnabled = YES;
        [_rightButton setTitleColor:[UIColor colorWithHexString:@"#ffffff" alpha:1] forState:UIControlStateNormal];
        [_passTextField resignFirstResponder];
        NSLog(@"已经输入六位密码了键盘失去响应");
        ConfirmAgainViewController *conVc = [[ConfirmAgainViewController alloc]init];
        conVc.onPassString = sender.text;
        [self.navigationController pushViewController:conVc animated:YES];
    }
}
#pragma mark---设置支付密码---
- (void)thePasswordView
{
    //输入六位数支付密码
    UILabel *pleaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(42*BOScreenW/750, 38*BOScreenH/1334, 666*BOScreenW/750, 40*BOScreenH/1334)];
    pleaseLabel.text = @"输入6位数支付密码";
    pleaseLabel.font = [UIFont systemFontOfSize:16];
    pleaseLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    [self.view addSubview:pleaseLabel];
    
    //输入密码的view
    UIView *passBgView = [[UIView alloc]initWithFrame:CGRectMake(42*BOScreenW/750, 108*BOScreenH/1334, 666*BOScreenW/750, 92*BOScreenH/1334)];
    passBgView.backgroundColor = [UIColor whiteColor];
    passBgView.layer.borderWidth = 1;
    passBgView.layer.borderColor = [UIColor colorWithHexString:@"#949799" alpha:1].CGColor;
    passBgView.layer.cornerRadius = 5;
    passBgView.layer.masksToBounds = YES;
    [self.view addSubview:passBgView];
    
    //中间的五个小细线
    for (int i = 0; i < 5; i ++)
    {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(111*BOScreenW/750+i*(111*BOScreenW/750), 0, 1, 92*BOScreenH/1334)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#949799" alpha:1];
        [passBgView addSubview:lineView];
    }
    
    //中间的六个小黑圆
    for (int i = 0; i < 6; i ++)
    {
        UIView *roundView = [[UIView alloc]initWithFrame:CGRectMake(48*BOScreenW/750 + i*(0*BOScreenW/750 + 111*BOScreenW/750), 36*BOScreenH/1334, 20*BOScreenW/750, 20*BOScreenW/750)];
        roundView.backgroundColor = [UIColor blackColor];
        roundView.layer.cornerRadius = 5;
        roundView.layer.masksToBounds = YES;
        [passBgView addSubview:roundView];
        [_roundArr addObject:roundView];
        roundView.hidden = YES;
    }
}
#pragma mark---设置判断小黑圆的显示与隐藏---
- (void)setCount:(int)count
{
    int roundViewCount = (int)_roundArr.count;
    
    for (int i = 0; i < roundViewCount; i++)
    {
        UIView *round = _roundArr[i];
        
        if (i < count)
        {
            round.hidden = NO;
        } else
        {
            round.hidden = YES;
        }
    }
}
#pragma mark---下一步的点击事件---
- (void)rightButtonClick
{
    NSLog(@"23423423");
    ConfirmAgainViewController *conVc = [[ConfirmAgainViewController alloc]init];
    [self.navigationController pushViewController:conVc animated:YES];
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
