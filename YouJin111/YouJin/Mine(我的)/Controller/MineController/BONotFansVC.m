//
//  BONotFansVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BONotFansVC.h"

@interface BONotFansVC ()

@end

@implementation BONotFansVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    [self setupView];
}

#pragma mark - 添加View的图片和label
- (void)setupView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((BOScreenW - 125) * 0.5 * BOWidthRate, 172 * BOHeightRate, 125 * BOWidthRate, 125 * BOWidthRate)];
    imageView.image = [UIImage imageNamed:@"img_b"];
    [self.view addSubview:imageView];
    
    // 添加label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 30 * BOHeightRate, BOScreenW, 15 * BOHeightRate)];
    label.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    label.text = [NSString stringWithFormat:@"你还没有任何%@",self.titleString];
    [label setFont:[UIFont systemFontOfSize:13]];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
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
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
