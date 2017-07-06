//
//  HeadLineDetailViewController+LogicalFlow.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/19.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineDetailViewController.h"
#import "HeadLineDetailViewController+Configuration.h"

@interface HeadLineDetailViewController (LogicalFlow)
- (void)requireForUserInfo;
- (void)requireForStarType;
- (void)requireForOutType;
- (void)requestForPublsihCommentWithModel:(PublishCommentModel *)model;
- (void)requireForContentDetailWithTid:(NSNumber *)tid;
- (void)requireForCommentWithStartCount:(NSInteger)start;
- (void)requestForFavourWithOutId:(NSNumber *)outId typeId:(NSNumber *)typeId;
- (void)subscribeUser:(BOOL)subscribe;
- (void)collectContent:(BOOL)isCollect;
- (void)rewardContentWithCount:(NSInteger)rewardCount;

@end
