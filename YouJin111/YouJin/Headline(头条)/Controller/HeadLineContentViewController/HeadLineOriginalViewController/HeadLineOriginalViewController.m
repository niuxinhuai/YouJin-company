//
//  HeadLineOriginalViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineOriginalViewController.h"

@interface HeadLineOriginalViewController ()

@end

@implementation HeadLineOriginalViewController

+ (instancetype)create {
    HeadLineOriginalViewController *vc = [[HeadLineOriginalViewController alloc]init];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requireForOriginalListWithStart:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - require

- (void)requireForOriginalListWithStart:(NSInteger)start {
    self.isRefreshing = YES;
    NSString *urlString = [BASEURL stringByAppendingString:@"Top/getIsMyselfTopList"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:tokenString forKey:@"at"];
    [param setObject:@(start) forKey:@"start"];
    [param setObject:@20 forKey:@"limit"];
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            NSArray *array = [TopContentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self handleRequestForOriginalListSuccessWithData:array startCount:start];
            [self.datasource updateMixtureDatas];
            [self.tableView reloadData];
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
        [self tableViewEndRefreshing];
        self.isRefreshing = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self tableViewEndRefreshing];
        self.isRefreshing = NO;
    }];
    
}

#pragma mark - ovrride

- (void)bottomRefreshing {
    if (self.isRefreshing || self.isNoMoreData) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireForOriginalListWithStart:self.datasource.contents.count];
}

- (void)topRefreshing {
    if (self.isRefreshing) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireForOriginalListWithStart:0];
}


#pragma mark - helpMethod

- (void)handleRequestForOriginalListSuccessWithData:(NSArray *)data startCount:(NSInteger)start {
    if (start == 0) [self.datasource.contents removeAllObjects];
    [self.datasource.contents addObjectsFromArray:data];
    MJRefreshBackStateFooter *foot = (MJRefreshBackStateFooter *)self.tableView.mj_footer;
    foot.stateLabel.hidden = self.datasource.contents.count == 0;
    if (data.count < 20) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        self.isNoMoreData = YES;
    }
}


@end
