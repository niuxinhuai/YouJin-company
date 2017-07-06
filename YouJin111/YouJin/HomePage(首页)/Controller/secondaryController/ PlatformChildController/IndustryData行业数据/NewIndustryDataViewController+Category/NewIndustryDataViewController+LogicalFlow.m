//
//  NewIndustryDataViewController+LogicalFlow.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NewIndustryDataViewController+LogicalFlow.h"
#import "NewIndustryDataViewController+Configuration.h"
#import "NSMutableDictionary+Utilities.h"

@implementation NewIndustryDataViewController (LogicalFlow)


- (void)requireIndustryDataWithStart:(NSInteger)start timeKey:(NSString *)timeKey {
    self.isRefreshing = YES;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:@(start) forKey:@"start"];
    [param setNewObject:@(20) forKey:@"limit"];
    [param setNewObject:timeKey forKey:@"ty"];
    [self.manager POST:[NSString stringWithFormat:@"%@WdApi/wangdaiData",BASEURL] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            NSArray *array = [IndustryDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self handleRequestForIndustryDataSuccessWithData:array start:start];
            [self tableViewReloadData];
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
        [self endRefreshing];
        self.isRefreshing = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self endRefreshing];
        self.isRefreshing = NO;
    }];

}

#pragma mark - helpMethod

- (void)handleRequestForIndustryDataSuccessWithData:(NSArray *)data start:(NSInteger)start {
    if (start == 0) [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:data];
    MJRefreshBackStateFooter *foot = (MJRefreshBackStateFooter *)self.baseScrollView.mj_footer;
    foot.stateLabel.hidden = self.dataArray.count == 0;
    if (data.count < 20) {
        [self.baseScrollView.mj_footer endRefreshingWithNoMoreData];
        self.isNoMoreData = YES;
    }
}


@end
