//
//  HeadLineMainViewController+LogiclFlow.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineMainViewController+LogiclFlow.h"
#import "HeadLineMainViewController+Configuration.h"
#import "NSMutableDictionary+Utilities.h"

@implementation HeadLineMainViewController (LogiclFlow)


- (void)requireBannerData {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    [self.manager POST:[BASEURL stringByAppendingString:@"Top/topBannerList"] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]){
            self.bannerDatas = [BannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self reloadheadBannerWithData:self.bannerDatas];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (void)getAuthorityOfPublishCoentent {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:USERSid forKey:@"sid"];
    [param setNewObject:USERUID forKey:@"uid"];
    [self.manager POST:[BASEURL stringByAppendingString:@"App/userAuthStatus"] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"status"] && ![responseObject[@"status"] isKindOfClass:[NSNull class]]) {
            self.isCanPublish = [responseObject[@"status"] boolValue];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];

}


- (void)requirePlateList {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    [self.manager POST:[BASEURL stringByAppendingString:@"Top/modelList"] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]){
            NSLog(@"dakjhdahdkja");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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


@end
