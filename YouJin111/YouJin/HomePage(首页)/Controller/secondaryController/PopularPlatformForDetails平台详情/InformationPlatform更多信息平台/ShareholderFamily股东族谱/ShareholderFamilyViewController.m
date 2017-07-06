//
//  ShareholderFamilyViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/14.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "ShareholderFamilyViewController.h"
#import "ShareManager.h"

@interface ShareholderFamilyViewController ()<UIWebViewDelegate>
@end

@implementation ShareholderFamilyViewController
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"股东结构"];
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    //设置rightBarButtonItem
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,60*BOScreenW/750,60*BOScreenH/1334)];
    [rightButton setImage:[UIImage imageNamed:@"icon_fenxiang"] forState:UIControlStateNormal];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64)];
    webView.delegate = self;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobile/page/shareholderStructure_app.html?ptid=%@",BASEWEBURl,self.ptidString]]];
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
- (void)rightButtonClick
{
    NSString *titleString = [NSString stringWithFormat:@"%@实际股权控制人是？",self.namestr];
    ShareManager *manager = [ShareManager shareManagerStandardWithDelegate:nil];
    [manager shareInView:self.view text:@"在有金APP让你一目了然，查平台实际控制人就是那么轻松。" image:[UIImage shareImageWithUrl:self.imageUrlstr] url:[NSString stringWithFormat:@"%@mobile/page/shareholderStructure_s.html?ptid=%@",BASEWEBURl,self.ptidString] title:titleString objid:nil];
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
