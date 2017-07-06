//
//  HotTopicViewController+FlowLogical.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HotTopicViewController+FlowLogical.h"
#import "HotTopicViewController+Configures.h"

@implementation HotTopicViewController (FlowLogical)



- (void)requireBanner {
    NSString *url = [NSString stringWithFormat:@"%@News/newsBannerList",BASEURL];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"at"] = tokenString;
    [self.mgr GET:url parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1 && responseObject[@"data"]) {
            self.datasource.bannerModels = [BannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)requireForHotListWithStartCount:(NSNumber *)startCount {
    NSString *url = [NSString stringWithFormat:@"%@News/getNewsList",BASEURL];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"at"] = tokenString;
    dictionary[@"start"] = startCount;
    dictionary[@"limit"] = @10;
    [self.mgr GET:url parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1 && responseObject[@"dianping"]) {
            NSArray *array = [HotCommentModle mj_objectArrayWithKeyValuesArray:responseObject[@"dianping"]];
            self.datasource.commentModles = array;
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



@end
