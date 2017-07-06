//
//  PlatformServiceDetailViewController+LogicalFlow.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformServiceDetailViewController+LogicalFlow.h"
#import "NSMutableDictionary+Utilities.h"
#import "PlatformServiceDetailViewController+Configuration.h"

@implementation PlatformServiceDetailViewController (LogicalFlow)



- (void)requireForPlatSeviceDetailWithSvid:(NSNumber *)svid {
    NSString *urlString = [BASEURL stringByAppendingString:@"WdApi/serviceCompanyInfo"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:svid forKey:@"svid"];
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            [self handleRequestForPlatSeviceDetailSuccess:[PlatformServiceDetailModel mj_objectWithKeyValues:responseObject[@"data"]]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


- (void)requireForPlatSeviceDetailCommentList {
    NSString *urlString = [BASEURL stringByAppendingString:@"WdApi/svDpList"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:self.svid forKey:@"svid"];
    [param setNewObject:@0 forKey:@"start"];
    [param setNewObject:@10 forKey:@"limit"];
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            [self handleRequestForPlatSeviceDetailCommentListSuccess:[BiaoQianModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]] count:[responseObject[@"count"] integerValue]];
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (void)requestForStarCommentWithOutId:(NSInteger)outId
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:USERSid forKey:@"sid"];
    [param setNewObject:@11 forKey:@"type_id"];
    [param setNewObject:@(outId) forKey:@"out_id"];
    [self.manager POST:[NSString stringWithFormat:@"%@App/star",BASEURL] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"dahjdhaskjdha");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}



#pragma mark - helpMethod

- (void)handleRequestForPlatSeviceDetailSuccess:(PlatformServiceDetailModel *)model {
    self.topTitleLabel.text = model.pname;
    if (model.other_pro.length == 0) model.other_pro = @"暂无其他产品";
    self.seviceDetail = model;
    self.platformHeadView.frame = CGRectMake(0, 0, [UIScreen screenWidth], [model platformSeviceDetailHeadViewHeightWithOpenCompanyInfo:NO]);
    [self.platformHeadView updatePlatformServiceDetailModel:model];
    [self.platformHeadView layoutIfNeeded];
    self.tableView.tableHeaderView = self.platformHeadView;
    [self.tableView reloadData];
}


- (void)handleRequestForPlatSeviceDetailCommentListSuccess:(NSArray *)data count:(NSInteger)count {
    self.commentList = data;
    self.sectionHeadView.label.text = [NSString stringWithFormat:@"用户点评(%@)", @(count)];
    if (count == 0) self.sectionHeadView.label.text = @"用户点评";
    self.commentCount = @(count);
    [self.tableView reloadData];
    self.tableView.tableFooterView = count > 0 ? self.sectionFootView : self.noCommentFootView;
}





@end
