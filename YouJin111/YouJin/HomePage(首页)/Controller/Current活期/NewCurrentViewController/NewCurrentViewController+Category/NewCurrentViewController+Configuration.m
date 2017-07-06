//
//  NewCurrentViewController+Configuration.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NewCurrentViewController+Configuration.h"
#import "ShareManager.h"
#import "UIImage+UIColor.h"

@implementation NewCurrentViewController (Configuration)

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
        HomeLineHeadBarView *view = [[HomeLineHeadBarView alloc]initWithFrame:CGRectMake(0, 110, [UIScreen screenWidth], 45)];
        [view updateLineViewWidth:90*BOScreenW/750];
        view.delegate = self;
        [view updateTitles:@[@"互金活期", @"货币基金"]];
        [self.view addSubview:view];
        view;
    });
    [self.headBarView makeShadowWithShadowColor:[UIColor grayColor] shadowOffset:CGSizeMake(0, .5) shadowRadius:.5 shadowOpacity:.5 shadowPath:[UIBezierPath bezierPathWithRect:self.headBarView.bounds].CGPath];
}


- (void)configureNavBar {
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"活期排行榜"];
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"icon_fenxiang"] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 80, 44);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -30;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, rightItem, nil];
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

- (void)shareAction:(UIButton *)sender {
    CGPoint offset = self.currentVC.tableView.contentOffset;
    if (offset.y < -self.barInset) {
        self.currentVC.tableView.contentOffset = CGPointMake(offset.x, -self.barInset);
    }
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        UIImage *image = [UIImage shareImageWithView:self.navigationController.view];
        [[ShareManager shareManagerStandardWithDelegate:nil] shareInView:self.view text:@"活期排行榜" image:image url:nil title:@"活期排行榜" objid:@3];
    });
}


@end
