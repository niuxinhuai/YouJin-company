//
//  NewCarLoanViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NewCarLoanViewController.h"
#import "NewCarLoanViewController+Configuration.h"
#import "NewCarLoanViewController+LogicalFlow.h"

@interface NewCarLoanViewController ()

@end

@implementation NewCarLoanViewController

+ (instancetype)create {
    NewCarLoanViewController *vc = [[NewCarLoanViewController alloc]initWithNibName:@"NewCarLoanViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    self.subControllerCount = self.barTitles.count;
    [self requireBannerData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ovrride

- (BaseSwipeSubViewController *)generateViewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0: return [self createCarLoanRankViewController];
        case 1: return [self createCityShopViewController];
        default:
            break;
    }
    BaseSwipeSubViewController *vc = [[BaseSwipeSubViewController alloc]init];
    return vc;
}

#pragma mark - reget

- (NSArray *)barTitles {
    if (!_barTitles) {
        _barTitles = @[@"车贷排行榜", @"同城门店"];
    }
    return _barTitles;
}

- (NSArray *)bannerDatas {
    if (!_bannerDatas) {
        _bannerDatas = [NSArray array];
    }
    return _bannerDatas;
}

#pragma mark - helpMethod

- (NewCarLoanRankViewController *)createCarLoanRankViewController {
    NewCarLoanRankViewController *vc = [NewCarLoanRankViewController create];
    return vc;
}

- (NewCityShopViewController *)createCityShopViewController {
    NewCityShopViewController *vc = [NewCityShopViewController create];
    return vc;
}

@end
