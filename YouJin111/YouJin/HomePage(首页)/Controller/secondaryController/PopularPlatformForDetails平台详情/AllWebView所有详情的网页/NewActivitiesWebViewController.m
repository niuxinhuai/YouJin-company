//
//  NewActivitiesWebViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NewActivitiesWebViewController.h"

@interface NewActivitiesWebViewController ()<UIWebViewDelegate>

@end

@implementation NewActivitiesWebViewController
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];

    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"新手活动"];

    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff" alpha:1];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64)];
    webView.delegate = self;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [self.view addSubview: webView];
    [webView loadRequest:request];

}
-(void)webViewDidStartLoad:(UIWebView*)webView
{
    NSLog(@"加载中。。。");
}
-(void)webViewDidFinishLoad:(UIWebView*)webView
{
    NSLog(@"完成加载");
}
-(void)webView:(UIWebView*)webView DidFailLoadWithError:(NSError*)error
{
    NSLog(@"加载出错%@",error);
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
