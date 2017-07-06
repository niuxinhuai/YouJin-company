//
//  NewCarLoanViewController+Configuration.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NewCarLoanViewController+Configuration.h"

@implementation NewCarLoanViewController (Configuration)

- (void)configureViews {
    self.isNeedBaseInset = NO;
    self.type = kSwipeTableViewByHeadView;
    [self addHeadBannerView];
    [self addHeaderBar];
    [self configureNavBar];
    self.layout.itemSize = CGSizeMake([UIScreen screenWidth], [UIScreen screenHeight] - 64);
}


- (void)addHeadBannerView {
    self.headerView = ({
        SDCycleScrollView *headerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen screenWidth], 110)  delegate:self placeholderImage:[UIImage imageNamed:@"img_loadingb"]];
        headerView.autoScrollTimeInterval = 4;
        [self.view addSubview:headerView];
        headerView;
    });
}

- (void)addHeaderBar {
    self.headBarView = ({
        HomeLineHeadBarView *view = [[HomeLineHeadBarView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen screenWidth], 45)];
        [view updateLineViewWidth:90*BOScreenW/750];
        [view updateTitles:@[@"车贷排行榜", @"同城门店"]];
        view.delegate = self;
        [self.view addSubview:view];
        view;
    });
    [self.headBarView makeShadowWithShadowColor:[UIColor grayColor] shadowOffset:CGSizeMake(0, .5) shadowRadius:.5 shadowOpacity:.5 shadowPath:[UIBezierPath bezierPathWithRect:self.headBarView.bounds].CGPath];
}


- (void)configureNavBar {
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"车贷"];
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
}


#pragma mark - helpMethod

- (SDCycleScrollView *)getHeadView {
    return (SDCycleScrollView *)self.headerView;
}

- (HomeLineHeadBarView *)getHeadBarView {
    return (HomeLineHeadBarView *)self.headBarView;
}


- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
