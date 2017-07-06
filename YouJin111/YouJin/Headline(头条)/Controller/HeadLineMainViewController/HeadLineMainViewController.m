//
//  HeadLineMainViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineMainViewController.h"
#import "HeadLineMainViewController+Configuration.h"
#import "HeadLineMainViewController+LogiclFlow.h"
#import "PublishViewController.h"
#import "HeadLineRecommendViewController.h"
#import "HeadLineSubscribeViewController.h"
#import "HeadLinePlateViewController.h"
#import "GoldMainViewController.h"
#import "HeadLineMainViewController+Delegate.h"
#import "HeadLineOriginalViewController.h"

@interface HeadLineMainViewController ()

@end

@implementation HeadLineMainViewController

+ (instancetype)create {
    HeadLineMainViewController *vc = [[HeadLineMainViewController alloc]initWithNibName:@"HeadLineMainViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    [self configureLayoutConstraint];
    self.subControllerCount = self.barTitles.count;
    [self requireBannerData];
    [self requirePlateList];
    if (USERSid) [self getAuthorityOfPublishCoentent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    NSString *key = [NSString stringWithFormat:@"viewContrller%@", @(1)];
    if ([self.cachedViewControllers objectForKey:key] && [[self.cachedViewControllers objectForKey:key] isKindOfClass:[HeadLineSubscribeViewController class]]) {
        HeadLineSubscribeViewController *vc = (HeadLineSubscribeViewController *)[self.cachedViewControllers objectForKey:key];
        if (USERSid) {
            [vc topRefreshing];
        }
    }
}

#pragma mark - ovrride

- (BaseSwipeSubViewController *)generateViewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0: return [self createRecommendViewController];
        case 1: return [self createSubscribeViewController];
        case 2: return [self createPlateViewControllerWithPlateId:1];
        case 3: return [self createOriginalViewController];
        case 4: return [self createPlateViewControllerWithPlateId:3];
        case 5: return [self createPlateViewControllerWithPlateId:10];
        case 6: return [self createPlateViewControllerWithPlateId:4];
        case 7: return [self createPlateViewControllerWithPlateId:5];
        case 8: return [self createPlateViewControllerWithPlateId:6];
        case 9: return [self createPlateViewControllerWithPlateId:7];
        default:
            break;
    }
    BaseSwipeSubViewController *vc = [[BaseSwipeSubViewController alloc]init];
    return vc;
}

#pragma mark - reget


- (NSArray *)barTitles {
    return @[@"推荐",@"关注",@"网贷",@"原创",@"观点",@"八卦金融",@"银行",@"股市",@"基金",@"保险"];
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager bo_manager];
    }
    return _manager;
}

- (NSArray *)bannerDatas {
    if (!_bannerDatas) {
        _bannerDatas = [NSArray array];
    }
    return _bannerDatas;
}

#pragma mark - actionMethod

- (IBAction)goldSelectedAction:(UIButton *)sender {
    if (!USERUID) {
        [self pushToLoginViewController];
        return;
    }
    GoldMainViewController *vc = [GoldMainViewController createWithHasApplyForVip:self.isCanPublish];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)publishAction:(UIButton *)sender {
    if (!USERSid) {
        [self pushToLoginViewController];
        return;
    }
    if (!self.isCanPublish) {
        [self toast:@"您还未申请有金号，请前往申请" complete:nil];
    }else {
        [self alertUserWithAlertText:@"请通过网页端发表头条文章打开网址www.youjin360.com使用手机号、密码登录"];
    }
}

#pragma mark - helpMethod

- (HeadLineRecommendViewController *)createRecommendViewController {
    HeadLineRecommendViewController *vc = [HeadLineRecommendViewController create];
    vc.baseDelegate = self;
    return vc;
}

- (HeadLineSubscribeViewController *)createSubscribeViewController {
    HeadLineSubscribeViewController *vc = [HeadLineSubscribeViewController create];
    vc.baseDelegate = self;
    return vc;
}

- (HeadLinePlateViewController *)createPlateViewControllerWithPlateId:(NSInteger)plateId {
    HeadLinePlateViewController *vc = [HeadLinePlateViewController headLinePlateViewControllerWithPlateID:@(plateId)];
    vc.baseDelegate = self;
    return vc;
}

- (HeadLineOriginalViewController *)createOriginalViewController {
    HeadLineOriginalViewController *vc = [HeadLineOriginalViewController create];
    vc.baseDelegate = self;
    return vc;
}

- (void)pushToLoginViewController {
    BONoteVerifyLogiin *noteVerifyLoginVC = [[BONoteVerifyLogiin alloc] init];
    noteVerifyLoginVC.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:noteVerifyLoginVC];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:nil];
}


- (void)alertUserWithAlertText:(NSString *)text {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:text delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}


@end
