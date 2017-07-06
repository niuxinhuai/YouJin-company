//
//  HeadLineRecommendViewController+LogicalFlow.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineRecommendViewController+LogicalFlow.h"

@implementation HeadLineRecommendViewController (LogicalFlow)



- (void)requireForRecommendListWithStart:(NSInteger)startCount {
    self.isRefreshing = YES;
    NSString *urlString = [BASEURL stringByAppendingString:@"Top/getTopList"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:tokenString forKey:@"at"];
    [param setObject:@(startCount) forKey:@"start"];
    [param setObject:@20 forKey:@"limit"];
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            NSArray *array = [TopContentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self handleRequestForRecommendListSuccessWithData:array startCount:startCount];
            if (responseObject[@"adList"] && ![responseObject[@"adList"] isKindOfClass:[NSNull class]]) {
                NSArray *adArray = [AdvertisementModel mj_objectArrayWithKeyValuesArray:responseObject[@"adList"]];
                if (startCount == 0) [self.datasource.advertisements removeAllObjects];
                [self.datasource.advertisements addObjectsFromArray:adArray];
            }
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



#pragma mark - helpMethod

- (void)handleRequestForRecommendListSuccessWithData:(NSArray *)data startCount:(NSInteger)start {
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
