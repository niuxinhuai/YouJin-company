//
//  CitySelectViewController+LogicalFlow.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CitySelectViewController+LogicalFlow.h"
#import "CitySelectViewController+Configuration.h"

@implementation CitySelectViewController (LogicalFlow)



- (void)requireCityList {
    NSString *urlString = [BASEURL stringByAppendingString:@"Common/getAreaList"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:tokenString forKey:@"at"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager bo_manager];
    [manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"hot"] && ![responseObject[@"hot"] isKindOfClass:[NSNull class]]) {
            self.hotCitys = [CityDetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        }
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            self.totalCitys = [CityModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self updateSectionIndexArrayWithData:self.totalCitys];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark - helpMethod

- (void)updateSectionIndexArrayWithData:(NSArray<CityModel *> *)data {
    self.sectionIndexArray = nil;
    for (CityModel *model in data) {
        [self.sectionIndexArray addObject:model.alifName];
    }
}


@end
