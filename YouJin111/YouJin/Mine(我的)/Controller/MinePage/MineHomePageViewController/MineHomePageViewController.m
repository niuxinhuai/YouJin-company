//
//  MineHomePageViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MineHomePageViewController.h"
#import "MineHomePageViewController+Configuration.h"
#import "RemakrListViewController.h"
#import "PublishListViewController.h"
#import "CommentListViewController.h"

@interface MineHomePageViewController ()

@end

@implementation MineHomePageViewController

+ (instancetype)create {
    MineHomePageViewController *vc = [[MineHomePageViewController alloc]initWithNibName:@"MineHomePageViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    self.subControllerCount = 3;
    [self requstUserInfo];
    [[self getHeadBar] updateButtonTitleJudgeIsMe:self.uid == [USERUID intValue] ];
   // [self.view bringSubviewToFront:self.collectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ovrride

- (BaseSwipeSubViewController *)generateViewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0: return [self createRemakrListViewController];
        case 1: return [self createPublishListViewController];
        case 2: return [self createCommentListViewController];
        default:
            break;
    }
    BaseSwipeSubViewController *vc = [[BaseSwipeSubViewController alloc]init];
    return vc;
}

#pragma mark - actionMethod


- (IBAction)returnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)subscribeAction:(UIButton *)sender {
    [self subscribeUser:!self.isSubscribe];
}



#pragma mark - reget

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager bo_manager];
    }
    return _manager;
}

#pragma mark - helpMethod

- (RemakrListViewController *)createRemakrListViewController {
    RemakrListViewController *vc = [RemakrListViewController create];
    vc.uid = self.uid;
    return vc;
}

- (PublishListViewController *)createPublishListViewController {
    PublishListViewController *vc = [PublishListViewController create];
    vc.uid = self.uid;
    return vc;
}

- (CommentListViewController *)createCommentListViewController {
    CommentListViewController *vc = [CommentListViewController create];
    vc.uid = self.uid;
    return vc;
}


@end
