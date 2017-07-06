//
//  HeadLineRecommendViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineRecommendViewController.h"
#import "HeadLineRecommendViewController+LogicalFlow.h"

@interface HeadLineRecommendViewController ()

@end

@implementation HeadLineRecommendViewController


+ (instancetype)create {
    HeadLineRecommendViewController *vc = [[HeadLineRecommendViewController alloc]initWithNibName:@"HeadLineRecommendViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requireForRecommendListWithStart:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ovrride

- (void)bottomRefreshing {
    if (self.isRefreshing || self.isNoMoreData) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireForRecommendListWithStart:self.datasource.contents.count];
}

- (void)topRefreshing {
    if (self.isRefreshing) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireForRecommendListWithStart:0];
}


@end
