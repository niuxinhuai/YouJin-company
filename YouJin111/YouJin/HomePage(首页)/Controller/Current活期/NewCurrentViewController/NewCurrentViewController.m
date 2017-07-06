//
//  NewCurrentViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NewCurrentViewController.h"
#import "NewCurrentViewController+Configuration.h"
#import "MoneyFundViewController.h"
#import "CurrentGoldViewController.h"
#import "IncreasesZoneViewController.h"

@interface NewCurrentViewController ()

@end

@implementation NewCurrentViewController

+ (instancetype)create {
    NewCurrentViewController *vc = [[NewCurrentViewController alloc]initWithNibName:@"NewCurrentViewController" bundle:nil];
    return vc;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    self.subControllerCount = self.barTitles.count;
    [self requireBannerData];
 //   self.navigationController.navigationBar.translucent = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ovrride

- (BaseSwipeSubViewController *)generateViewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0: return [self createCurrentGoldController];
        case 1: return [self createMoneyFundViewController];
        default:
            break;
    }
    BaseSwipeSubViewController *vc = [[BaseSwipeSubViewController alloc]init];
    return vc;
}


#pragma mark - reget

- (NSArray *)barTitles {
    return @[@"互金活期", @"货币基金"];
}

- (NSArray *)bannerDatas {
    if (!_bannerDatas) {
        _bannerDatas = [NSArray array];
    }
    return _bannerDatas;
}


- (MoneyFundViewController *)createMoneyFundViewController {
    MoneyFundViewController *vc = [MoneyFundViewController createWithTableViewStyle:UITableViewStylePlain];
    return vc;
}

- (CurrentGoldViewController *)createCurrentGoldController {
    CurrentGoldViewController *vc = [CurrentGoldViewController createWithTableViewStyle:UITableViewStylePlain];
    return vc;
}

#pragma mark - actionMethod
- (IBAction)redPacketAcrion:(UIButton *)sender {
    IncreasesZoneViewController *increasesZoneVc= [[IncreasesZoneViewController alloc]init];
    [self.navigationController pushViewController:increasesZoneVc animated:YES];
}



@end
