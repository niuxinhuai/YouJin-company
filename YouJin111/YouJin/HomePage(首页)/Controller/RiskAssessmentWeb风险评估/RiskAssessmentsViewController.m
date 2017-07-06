//
//  RiskAssessmentsViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/14.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "RiskAssessmentsViewController.h"
#import "ShareManager.h"
@interface RiskAssessmentsViewController ()<UIWebViewDelegate>
@end

@implementation RiskAssessmentsViewController


- (void)viewWillAppear:(BOOL)animated
{
    
    // 设置投资者类型为空
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"type"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController setNavigationBarHidden:NO animated:animated];

    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#eb5e11" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"风险评估"];
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    //设置rightBarButtonItem
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,60*BOScreenW/750,60*BOScreenH/1334)];
    [rightButton setImage:[UIImage imageNamed:@"icon_fenxiang"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark - 右边btnItem的点击事件
- (void)rightButtonClick {
    [[ShareManager shareManagerStandardWithDelegate:nil] shareInView:self.view
                                                                text:@"这是我的财富管家，告诉他你的投资偏好，会为你定制专属的资产配置建议"
                                                               image:[UIImage imageNamed:@"robot1"]
                                                                 url:[NSString stringWithFormat:@"%@mobile/page/investPreferenceBegin.html",BASEWEBURl]
                                                               title:@"你缺智能机器人财富管家吗？来看看"
                                                               objid:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff" alpha:1];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64)];
    webView.delegate = self;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobile/page/investPreferenceBegin.html?uid=%@",BASEWEBURl,USERUID]]];
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
