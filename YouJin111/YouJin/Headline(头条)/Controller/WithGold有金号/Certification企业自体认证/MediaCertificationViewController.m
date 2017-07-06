//
//  MediaCertificationViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MediaCertificationViewController.h"
#import "KnowTheViewController.h"

@interface MediaCertificationViewController ()

@end

@implementation MediaCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _fromStr = @"自媒体申请";//为了给下一页做判断是那一页过来的
//    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
//    self.navigationItem.leftBarButtonItem = btnItem;
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"自媒体认证"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *sinceArr = @[@"真实姓名",@"个人说明"];
    for (int i = 0; i < 2; i ++)
    {
        UILabel *sinceLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 35*BOScreenH/1334 + i*(30*BOScreenH/1334 + 70*BOScreenH/1334), 180*BOScreenW/750, 30*BOScreenH/1334)];
        sinceLabel.text = sinceArr[i];
        sinceLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        sinceLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:sinceLabel];
    }
    for (int i = 0; i < 2; i ++)
    {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 99*BOScreenH/1334 + i*(1*BOScreenH/1334 + 99*BOScreenH/1334), BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
        [self.view addSubview:lineView];
    }
    NSArray *inputArray = @[@"请输入您的真实姓名",@"如：律师"];
    for (int i = 0; i < 2; i ++)
    {
        UITextField *sinceTextField = [[UITextField alloc]initWithFrame:CGRectMake(210*BOScreenW/750, 35*BOScreenH/1334 + i*(30*BOScreenH/1334 + 70*BOScreenH/1334), 510*BOScreenW/750, 30*BOScreenH/1334)];
        sinceTextField.placeholder = inputArray[i];
        [sinceTextField setValue:[UIColor colorWithHexString:@"#b3b3b3" alpha:1]forKeyPath:@"_placeholderLabel.textColor"];
        [sinceTextField setValue:[UIFont boldSystemFontOfSize:14]forKeyPath:@"_placeholderLabel.font"];
        sinceTextField.textAlignment = NSTextAlignmentRight;
        sinceTextField.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        sinceTextField.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:sinceTextField];
    }
    //提交资料
    UIButton *sinceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sinceButton.frame = CGRectMake(80*BOScreenW/750, 340*BOScreenH/1334, 590*BOScreenW/750, 88*BOScreenH/1334);
    [sinceButton setTitle:@"提交资料" forState:UIControlStateNormal];
    [sinceButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    sinceButton.backgroundColor= [UIColor colorWithHexString:@"#4697fb" alpha:1];
    [sinceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sinceButton.layer.cornerRadius = 22;
    sinceButton.layer.masksToBounds = YES;
    [sinceButton addTarget:self action:@selector(sinceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sinceButton];
    
    if (iPhone5)
    {
        sinceButton.layer.cornerRadius = 18;
    }
    if (iPhone6P)
    {
        sinceButton.layer.cornerRadius = 24;
    }
}
#pragma mark---提交资料的点击事件---
- (void)sinceButtonClick
{
    KnowTheViewController *knowVc = [[KnowTheViewController alloc]init];
    knowVc.str = _fromStr;
    knowVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:knowVc animated:YES];
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
