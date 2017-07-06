//
//  NewIndustryDataViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NewIndustryDataViewController.h"
#import "NewIndustryDataViewController+Configuration.h"
#import "NewIndustryDataViewController+LogicalFlow.h"
#import "EnvelopeZoneViewController.h"

@interface NewIndustryDataViewController ()

@end

@implementation NewIndustryDataViewController

+ (instancetype)create {
    NewIndustryDataViewController *vc = [[NewIndustryDataViewController alloc]initWithNibName:@"NewIndustryDataViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    [self requireIndustryDataWithStart:0 timeKey:@"yesterday"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - reget

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - actionMethod

- (IBAction)redPacketAction:(UIButton *)sender {
    EnvelopeZoneViewController *envVc= [[EnvelopeZoneViewController alloc]init];
    [self.navigationController pushViewController:envVc animated:YES];
}


@end
