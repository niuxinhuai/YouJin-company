//
//  InvestmentInPuzzleViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/14.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "InvestmentInPuzzleViewController.h"

@interface InvestmentInPuzzleViewController ()<UIWebViewDelegate>

@end

@implementation InvestmentInPuzzleViewController
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"投资饼图"];
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    self.navigationItem.leftBarButtonItem = btnItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64)];
    webView.delegate = self;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobile/page/invest.html",BASEWEBURl]]];
    [self.view addSubview: webView];
    [webView loadRequest:request];
}
-(void)webViewDidStartLoad:(UIWebView*)webView
{
    NSLog(@"加载中。。。");
}
-(void)webViewDidFinishLoad:(UIWebView*)webView
{
    NSLog(@"加载完成");
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
