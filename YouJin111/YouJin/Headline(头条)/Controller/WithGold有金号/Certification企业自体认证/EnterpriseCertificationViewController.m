//
//  EnterpriseCertificationViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "EnterpriseCertificationViewController.h"
#import "KnowTheViewController.h"

@interface EnterpriseCertificationViewController ()

@end

@implementation EnterpriseCertificationViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    _fromStr = @"企业申请";//为了给下一页做判断是那一页过来的
//    // 设置leftButtonItem
//    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
//    self.navigationItem.leftBarButtonItem = btnItem;
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"企业认证"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *arr = @[@"公司名称",@"公司官网",@"运营者姓名",@"上传证件"];
    for (int i = 0; i < 4; i ++)
    {
        UILabel *companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 35*BOScreenH/1334 + i*(30*BOScreenH/1334 + 70*BOScreenH/1334), 180*BOScreenW/750, 30*BOScreenH/1334)];
        companyLabel.text = arr[i];
        companyLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        companyLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:companyLabel];
    }
    for (int i = 0; i < 3; i ++)
    {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 99*BOScreenH/1334 + i*(1*BOScreenH/1334 + 99*BOScreenH/1334), BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
        [self.view addSubview:lineView];
    }
    NSArray *inputArray = @[@"请输入公司名称",@"选填",@"请输入联系人姓名"];
    for (int i = 0; i < 3; i ++)
    {
        UITextField *inputTextField = [[UITextField alloc]initWithFrame:CGRectMake(210*BOScreenW/750, 35*BOScreenH/1334 + i*(30*BOScreenH/1334 + 70*BOScreenH/1334), 510*BOScreenW/750, 30*BOScreenH/1334)];
        inputTextField.placeholder = inputArray[i];
        [inputTextField setValue:[UIColor colorWithHexString:@"#b3b3b3" alpha:1]forKeyPath:@"_placeholderLabel.textColor"];
        [inputTextField setValue:[UIFont boldSystemFontOfSize:14]forKeyPath:@"_placeholderLabel.font"];
        inputTextField.textAlignment = NSTextAlignmentRight;
        inputTextField.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        inputTextField.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:inputTextField];
    }
    //请上传盖有公司公章的营业执照复印件
    UILabel *businessLabel=[[UILabel alloc]initWithFrame:CGRectMake(210*BOScreenW/750, 335*BOScreenH/1334, 510*BOScreenW/750, 30*BOScreenH/1334)];
    businessLabel.textAlignment = NSTextAlignmentRight;
    businessLabel.font = [UIFont systemFontOfSize:14];
    businessLabel.textColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1];
    [self.view addSubview:businessLabel];
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:@"请上传盖有公司公章的营业执照复印件"];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:@"复印件"];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#f64949" alpha:1] range:range1];
    businessLabel.attributedText=hintString;
    
    //证件图片
    UIImageView *certificateImage = [[UIImageView alloc]initWithFrame:CGRectMake(560*BOScreenW/750, 400*BOScreenH/1334, 160*BOScreenW/750, 160*BOScreenW/750)];
    certificateImage.image = [UIImage imageNamed:@"img_picbox"];
    certificateImage.userInteractionEnabled = YES;
    [self.view addSubview:certificateImage];
    //证件图片上面的按钮
    UIButton *certificateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    certificateButton.frame = CGRectMake(0, 0, 160*BOScreenW/750, 160*BOScreenW/750);
    [certificateImage addSubview:certificateButton];
   
    //提交资料
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(80*BOScreenW/750, 692*BOScreenH/1334, 590*BOScreenW/750, 88*BOScreenH/1334);
    [submitButton setTitle:@"提交资料" forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    submitButton.backgroundColor= [UIColor colorWithHexString:@"#4697fb" alpha:1];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitButton.layer.cornerRadius = 22;
    submitButton.layer.masksToBounds = YES;
    [submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    if (iPhone5)
    {
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 299*BOScreenH/1334, BOScreenW-30*BOScreenW/750, 2*BOScreenH/1334)];
        lineview.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
        [self.view addSubview:lineview];
        
        businessLabel.frame = CGRectMake(170*BOScreenW/750, 335*BOScreenH/1334, 550*BOScreenW/750, 30*BOScreenH/1334);
        businessLabel.font = [UIFont systemFontOfSize:13];

        submitButton.layer.cornerRadius = 18;
    }
    if (iPhone6P)
    {
        submitButton.layer.cornerRadius = 24;
    }
}
#pragma mark---提交资料的点击事件---
- (void)submitButtonClick
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
