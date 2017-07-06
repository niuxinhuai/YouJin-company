//
//  KnowTheViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "KnowTheViewController.h"

@interface KnowTheViewController ()

@end

@implementation KnowTheViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
//    self.navigationItem.leftBarButtonItem = btnItem;
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    if ([_str isEqualToString:@"自媒体申请"])
    {
        self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"自媒体认证"];
    }
    if([_str isEqualToString:@"企业申请"])
    {
        self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"企业认证"];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    //大图片
    UIImageView *bigImage = [[UIImageView alloc]initWithFrame:CGRectMake(235*BOScreenW/750, 178*BOScreenH/1334, 280*BOScreenW/750, 280*BOScreenW/750)];
    bigImage.image = [UIImage imageNamed:@"img_d"];
    [self.view addSubview:bigImage];
    //申请已提交，请在30日内发布一篇有效头条文章即可通过审核
    UILabel *hasBeenSubmitted = [[UILabel alloc]initWithFrame:CGRectMake(106*BOScreenW/750, 488*BOScreenH/1334, 536*BOScreenW/750, 80*BOScreenH/1334)];
    hasBeenSubmitted.font = [UIFont systemFontOfSize:14];
    hasBeenSubmitted.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    hasBeenSubmitted.numberOfLines = 0;
    [self.view addSubview:hasBeenSubmitted];
    if ([_str isEqualToString:@"自媒体申请"])
    {
        hasBeenSubmitted.text = @"申请已提交，请在30日内发布一篇有效头条文章即可通过审核";
        //设置行间距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing = 6;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:paragraphStyle};
        hasBeenSubmitted.attributedText = [[NSAttributedString alloc]initWithString:hasBeenSubmitted.text attributes:attributes];
        if (iPhone5)
        {
            hasBeenSubmitted.text = @"申请已提交，请在30日内发布一篇有效头条文章即可通过审核";
        }
    }
    if([_str isEqualToString:@"企业申请"])
    {
        hasBeenSubmitted.text = @"申请已提交，1个工作日内完成审核";
        hasBeenSubmitted.textAlignment = NSTextAlignmentCenter;
    }
    //知道了
    UIButton *knowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    knowButton.frame = CGRectMake(80*BOScreenW/750, 666*BOScreenH/1334, 590*BOScreenW/750, 88*BOScreenH/1334);
    [knowButton setTitle:@"知道了" forState:UIControlStateNormal];
    [knowButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    knowButton.backgroundColor= [UIColor colorWithHexString:@"#ffa238" alpha:1];
    [knowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [knowButton addTarget:self action:@selector(complish:) forControlEvents:UIControlEventTouchUpInside];
    knowButton.layer.cornerRadius = 22;
    knowButton.layer.masksToBounds = YES;
    [self.view addSubview:knowButton];
    
    if (iPhone5)
    {
        knowButton.layer.cornerRadius = 18;
    }
    if (iPhone6P)
    {
        knowButton.layer.cornerRadius = 24;
    }
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:NSClassFromString(@"GoldMainViewController")]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)complish:(UIButton *)button {
    [self leftBarButtonItemClick];
}

@end
