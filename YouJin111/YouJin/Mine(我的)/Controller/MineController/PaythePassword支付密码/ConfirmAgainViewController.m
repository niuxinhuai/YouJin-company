//
//  ConfirmAgainViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/23.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "ConfirmAgainViewController.h"

@interface ConfirmAgainViewController ()<UITextFieldDelegate>
@property (nonatomic ,strong)UIButton *rightButton;//rightBarButton
@property (nonatomic ,strong)NSMutableArray *roundArr;//存放小黑圆点view的数组
@property (nonatomic ,strong)UITextField *passTextField;//唯一的一个输入的键盘
@end

@implementation ConfirmAgainViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"设置支付密码"];
    //设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    self.navigationItem.leftBarButtonItem = btnItem;
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _rightButton.frame= CGRectMake(0, 0, 130*BOScreenW/750, 40*BOScreenH/1334);
    [_rightButton setTitle:@"确认" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor colorWithHexString:@"#ffffff" alpha:0.5] forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -14;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _roundArr = [[NSMutableArray alloc]init];
    [self setUpToPayThePassword];//重置支付密码的接口数据
    //设置支付密码
    [self thePasswordView];
    _passTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    _passTextField.delegate = self;
    _passTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_passTextField addTarget:self action:@selector(textFieldDiChangeth:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_passTextField];
    [_passTextField becomeFirstResponder];
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
        if ([sender.text isEqualToString:self.onPassString])
        {
            NSLog(@"设置密码一致");
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"at"] = tokenString;
            parameters[@"sid"] = USERSid;
            parameters[@"uid"] = USERUID;
            parameters[@"paypass"] = sender.text;
            [manager POST:[NSString stringWithFormat:@"%@Ucenter/resetPaypass",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([responseObject[@"r"] integerValue] == 1)
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"设置成功" preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                         [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
                    }]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                else
                {
                    NSLog(@"返回信息描述%@",responseObject[@"msg"]);
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"设置失败" preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
                    }]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"请求失败%@",error);
            }];
            
        }else
        {
            NSLog(@"bu一致");
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"两次密码输入不一致" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
}
#pragma mark---设置支付密码---
- (void)thePasswordView
{
    //输入六位数支付密码
    UILabel *pleaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(42*BOScreenW/750, 38*BOScreenH/1334, 666*BOScreenW/750, 40*BOScreenH/1334)];
    pleaseLabel.text = @"请在次输入6位数支付密码";
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
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
#pragma mark ---重置支付密码的接口数据---
- (void)setUpToPayThePassword
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"uid"] = USERUID;
    parameters[@"paypass"] = @"222222";
    [manager POST:[NSString stringWithFormat:@"%@Ucenter/resetPaypass",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}

@end
