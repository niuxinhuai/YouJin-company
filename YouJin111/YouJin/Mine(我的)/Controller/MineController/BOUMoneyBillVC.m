//
//  BOUMoneyBillVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOUMoneyBillVC.h"
#import "BOUMoneyOperationVCViewController.h"
#import <MJRefresh/MJRefresh.h>
@interface BOUMoneyBillVC ()

@end

@implementation BOUMoneyBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 添加子部控件
    [self setupChildView];
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
    
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"U币账单"];
    self.navigationItem.titleView = titleView;
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupChildView {
    BOUMoneyOperationVCViewController *uMoneyOperationVC = [[BOUMoneyOperationVCViewController alloc] init];
    [self addChildViewController:uMoneyOperationVC];
    [self.view addSubview:uMoneyOperationVC.view];
    uMoneyOperationVC.view.frame = CGRectMake(0, 0, BOScreenW, self.view.height);
}
#pragma mark - 设置上拉加载和下拉刷新
- (void)setupRefreshVeiw
{
    // 添加下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 根据拖拽，自动显示下拉控件
    header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = header;
    
    // 上拉刷新
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 自动根据有无数据，判断上拉控件是否完全显示
    footer.automaticallyHidden = YES;
    
    self.tableView.mj_footer = footer;
    
}
#pragma mark - 加载最新数据
- (void)loadNewData {
    
}

#pragma mark - 加载更多数据
- (void)loadMoreData {
    
}
@end
