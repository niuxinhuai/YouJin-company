//
//  ShareViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/19.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "ShareViewController.h"
#import <WebKit/WebKit.h>
#import "ShareManager.h"
@interface ShareViewController ()
@end

@implementation ShareViewController
#pragma mark - 懒加载shareView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BOColor(249, 250, 250);
    // 设置webView
    [self setupWkWebView];
    // 设置setupBottomBtn
    [self setupBottomBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:0.001] WithAlpha:1];
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
    
    
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"分享有金"];
    self.navigationItem.titleView = titleView;
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置wkWebView
- (void)setupWkWebView {
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, -64, BOScreenW, BOScreenH)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobile/page/invitationFriends.html?uid=%@",BASEWEBURl,USERUID]]]];
    webView.scrollView.scrollEnabled = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:webView];
}

#pragma mark - 设置底部的按钮
- (void)setupBottomBtn {
    CGFloat bottomX = (BOScreenW - 310 * BOWidthRate) * 0.5;
    CGFloat bottomY = BOScreenH - 60 * BOHeightRate;
    CGFloat bottomW = 310 * BOWidthRate;
    CGFloat bottomH = 40 * BOHeightRate;
    UIButton *bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(bottomX, bottomY, bottomW, bottomH)];
    [bottomBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#4697FB" alpha:1] WithAlpha:1] forState:UIControlStateNormal];
    bottomBtn.layer.cornerRadius = 20 * BOWidthRate;
    bottomBtn.layer.masksToBounds = YES;
    [bottomBtn setTitle:@"立即邀请" forState:UIControlStateNormal];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
}
#pragma mark - bottomBtnClick
- (void)bottomBtnClick {
    [[ShareManager shareManagerStandardWithDelegate:nil] shareInView:self.view
                                                                text:@"金融界的大众点评，每天上百万人在这里进行理财交流，你也一起来玩转理财吧"
                                                               image:[UIImage shareImageWithUrl:@""]
                                                                 url:[NSString stringWithFormat:@"%@mobile/page/invitationFriendsrRegister.html?uid=%@",BASEWEBURl,USERUID]
                                                               title:@"快来领现金奖励，人人有份"
                                                               objid:nil];
    
}

@end
