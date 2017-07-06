//
//  PresentWebVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PresentWebVC.h"
#import <WebKit/WebKit.h>
@interface PresentWebVC ()

@end

@implementation PresentWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  设置自定义的导航条
    [self setupNavigationView];
    
    // 设置wkWebView
    [self setWKWebView];
}

// 添加顶部的导航条
- (void)setupNavigationView {
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 64)];
    
    [self.view addSubview:navigationBar];
    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 添加返回按钮
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 32, 50 * BOWidthRate, 20)];
    [backBtn setImage:[UIImage imageNamed:@"common_icon_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    [navigationBar addSubview:backBtn];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20 * BOWidthRate, 0, 0);
    // 添加控制器的titleView
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((BOScreenW - 150 * BOWidthRate) * 0.5, 30, 150 * BOWidthRate, 24)];
    [label setText:self.titleString];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:19]];
    [label setTextColor:[UIColor whiteColor]];
    label.textAlignment = NSTextAlignmentCenter;
    [navigationBar addSubview:label];
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 设置底部的webView
- (void)setWKWebView {
    WKWebView *webView = [[WKWebView alloc] init];
    webView.frame = CGRectMake(0, 64, BOScreenW, BOScreenH - 64);
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:webView];
 
}
@end
