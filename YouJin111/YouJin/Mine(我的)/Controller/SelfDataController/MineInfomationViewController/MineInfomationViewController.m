//
//  MineInfomationViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/8.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MineInfomationViewController.h"
#import "MineInfomationViewController+Configures.h"
#import "MineInfomationViewController+LogicalFlow.h"

@interface MineInfomationViewController ()

@end

@implementation MineInfomationViewController


+ (instancetype)create {
    MineInfomationViewController *vc = [[MineInfomationViewController alloc]initWithNibName:@"MineInfomationViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAutoDismissKeyboardGesture];
    [self configureViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configureBar];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self requireUserData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - reget

- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}

- (QNUploadManager *)upManager {
    if (_upManager == nil) {
        _upManager = [[QNUploadManager alloc] init];
    }
    return _upManager;
}


@end
