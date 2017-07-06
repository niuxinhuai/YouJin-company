//
//  NewCarLoanViewController+LogicalFlow.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NewCarLoanViewController+LogicalFlow.h"
#import "NewCarLoanViewController+Configuration.h"

@implementation NewCarLoanViewController (LogicalFlow)


- (void)requireBannerData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager bo_manager];
    [manager POST:[NSString stringWithFormat:@"%@WdApi/chedaiBannerList",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"month"] && ![responseObject[@"month"] isKindOfClass:[NSNull class]]) {
            [self updateSearchBarDataWithMonth:responseObject[@"month"]];
        }
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            self.bannerDatas = [BannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self reloadheadBannerWithData:self.bannerDatas];
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}


#pragma mark - helpMethod

- (void)reloadheadBannerWithData:(NSArray *)data {
    SDCycleScrollView *view = [self getHeadView];
    view.infiniteLoop = data.count > 1;
    view.imageURLStringsGroup = [self extractBannerUrlStringWithBannerData:data];
}


- (NSArray *)extractBannerUrlStringWithBannerData:(NSArray<BannerModel *> *)array {
    if (array.count == 0) return nil;
    NSMutableArray *urlStrings = [NSMutableArray array];
    for (BannerModel *model in array) {
        if (model.img_url) [urlStrings addObject:model.img_url];
    }
    return urlStrings;
}

- (void)updateSearchBarDataWithMonth:(NSString *)month {
    NSMutableArray *array = [self.barTitles mutableCopy];
    NSString *name = array[0];
    name = [name stringByAppendingString:[NSString stringWithFormat:@"(%@)",month]];
    [array removeObjectAtIndex:0];
    [array insertObject:name atIndex:0];
    self.barTitles = array;
    HomeLineHeadBarView *bar = [self getHeadBarView];
    [bar updateTitles:self.barTitles];
}

@end
