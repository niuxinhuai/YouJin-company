//
//  TheLatestTableViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "TheLatestTableViewController.h"

@interface TheLatestTableViewController ()

@end

@implementation TheLatestTableViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"最新利率表"];
//    // 设置leftButtonItem
//    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
//    self.navigationItem.leftBarButtonItem = btnItem;
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f7" alpha:1];
    
    //黄色的view
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 30*BOScreenH/1334, 690*BOScreenW/750, 90*BOScreenH/1334)];
    topView.backgroundColor = [UIColor colorWithHexString:@"#ffac4c" alpha:1];
    [self.view addSubview:topView];
    //白色的view
    UIView *whiView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 120*BOScreenH/1334, 690*BOScreenW/750, 450*BOScreenH/1334)];
    whiView.backgroundColor = [UIColor colorWithHexString:@"#ffffff" alpha:1];
    [self.view addSubview:whiView];
    //细线view
    for (int i = 0; i < 2; i ++)
    {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(229*BOScreenW/750+i*(230*BOScreenW/750), 0*BOScreenH/1334, 1*BOScreenW/750, 450*BOScreenH/1334)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
        [whiView addSubview:lineView];
    }
    for (int i = 0; i < 4; i ++)
    {
        UIView *linesView = [[UIView alloc]initWithFrame:CGRectMake(0, 89*BOScreenH/1334 + i*(90*BOScreenH/1334), 690*BOScreenW/750, 1*BOScreenH/1334)];
        linesView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
        [whiView addSubview:linesView];
    }
    //数据
    NSArray *dataArr = @[@"利率项目",@"商业贷款利率(%)",@"公积金贷款利率(%)",@"5年以上",@"4.90",@"3.25",@"3-5年(含)",@"4.75",@"2.75",@"1-3年(含)",@"4.75",@"2.75",@"1年",@"4.35",@"2.75",@"6个月",@"4.35",@"2.75"];
    for (int i = 0; i < 18; i ++)
    {
        int j = i%3;
        int k = i/3;
        UILabel *dataLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750 + j*(0*BOScreenW/750 + 230*BOScreenW/750), 55*BOScreenH/1334 + k*(40*BOScreenH/1334 + 50*BOScreenH/1334), 230*BOScreenW/750, 40*BOScreenH/1334)];
        dataLabel.text = dataArr[i];
        dataLabel.textAlignment = NSTextAlignmentCenter;
        dataLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        dataLabel.font = [UIFont systemFontOfSize:14];
        if (i < 3)
        {
            dataLabel.textColor = [UIColor colorWithHexString:@"#ffffff" alpha:1];
            dataLabel.font = [UIFont systemFontOfSize:12];
            if (iPhone5)
            {
                dataLabel.font = [UIFont systemFontOfSize:11];
            }
        }
        [self.view addSubview:dataLabel];
    }
    UILabel *downLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 610*BOScreenH/1334, BOScreenW, 40*BOScreenH/1334)];
    downLable.text = @"以上为央行2015年最新公布的贷款基准利率";
    downLable.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    downLable.textAlignment = NSTextAlignmentCenter;
    downLable.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:downLable];
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
