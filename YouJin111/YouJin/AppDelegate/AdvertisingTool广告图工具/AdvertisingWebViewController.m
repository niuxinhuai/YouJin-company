//
//  AdvertisingWebViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "AdvertisingWebViewController.h"

@interface AdvertisingWebViewController ()<UIWebViewDelegate>

@end

@implementation AdvertisingWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff" alpha:1];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 64)];
    view.backgroundColor = [UIColor colorWithHexString:@"#2d84f2" alpha:1];
    [self.view addSubview:view];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 60*BOScreenH/1334, 28*BOScreenW/750, 47*BOScreenH/1334)];
    image.image = [UIImage imageNamed:@"common_icon_back"];
    [view addSubview:image];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 64, 170*BOScreenW/750);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(225*BOScreenW/750, 61*BOScreenH/1334, 300*BOScreenW/750, 40*BOScreenH/1334)];
    label.text = self.name;
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:19]];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, BOScreenW, BOScreenH-64)];
    webView.delegate = self;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString]];
    [self.view addSubview: webView];
    [webView loadRequest:request];
}
-(void)webViewDidStartLoad:(UIWebView*)webView
{
    NSLog(@"加载中。。。");
}
-(void)webViewDidFinishLoad:(UIWebView*)webView
{
    NSLog(@"加载出错");
}
-(void)webView:(UIWebView*)webView DidFailLoadWithError:(NSError*)error
{
    NSLog(@"加载出错%@",error);
}
- (void)buttonClick
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
