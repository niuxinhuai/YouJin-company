//
//  IntegralShareViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/19.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "IntegralShareViewController.h"
#import <WebKit/WebKit.h>
@interface IntegralShareViewController ()

@end

@implementation IntegralShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BOColor(249, 250, 250);
    [self setupWkWebView];
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
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
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

#pragma mark - 设置wkWebView
- (void)setupWkWebView {
    
    WKWebView *webView = [[WKWebView alloc] init];
    webView.frame = CGRectMake(0, 0, BOScreenW, BOScreenH - 64);
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:webView];
}

@end
