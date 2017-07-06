//
//  GoldMainViewController+LogicalFlow.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "GoldMainViewController+LogicalFlow.h"
#import "GoldMainViewController+Configures.h"
#import "GoldAccountFoucsModel.h"

@implementation GoldMainViewController (LogicalFlow)


- (void)requireGoldAccountFoucsListWithStartCount:(NSInteger)start limitCount:(NSInteger)limitCount {
    NSString *urlString = [BASEURL stringByAppendingString:@"App/myFocusAuthUserList"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:tokenString forKey:@"at"];
    [param setObject:USERSid forKey:@"sid"];
    [param setObject:USERUID forKey:@"uid"];
    [param setObject:@(start) forKey:@"start"];
    [param setObject:@(limitCount) forKey:@"limit"];
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            if (start == 0) [self.dataArray removeAllObjects];
            [self handleGoldAccountFoucsListResponse:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        self.isRefreshing = NO;
    }];
}


- (void)requireCanApplyGoldStatus {
    NSString *urlString = [BASEURL stringByAppendingString:@"App/isCanSubmitAuthApply"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:tokenString forKey:@"at"];
    [param setObject:USERSid forKey:@"sid"];
    [param setObject:USERUID forKey:@"uid"];
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"status"] && ![responseObject[@"status"] isKindOfClass:[NSNull class]]) {
            self.hasApplyForVip = ![responseObject[@"status"] boolValue];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

#pragma mark - responseHandel

- (void)handleGoldAccountFoucsListResponse:(id)responseObject {
    NSArray *array = [GoldAccountFoucsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
    [self.dataArray addObjectsFromArray:array];
    MJRefreshBackStateFooter *foot = (MJRefreshBackStateFooter *)self.tableView.mj_footer;
    if (self.dataArray.count == 0) {
        [self lackViewHidden:NO];
        foot.stateLabel.hidden = self.dataArray.count == 0;
    }
    if (array.count < 20) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        self.isNoMoreData = YES;
    }
    [self.tableView reloadData];
    self.isRefreshing = NO;
}



@end
