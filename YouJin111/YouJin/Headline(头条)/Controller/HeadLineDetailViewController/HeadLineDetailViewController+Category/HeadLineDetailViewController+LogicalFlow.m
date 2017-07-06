//
//  HeadLineDetailViewController+LogicalFlow.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/19.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineDetailViewController+LogicalFlow.h"
#import "NSMutableDictionary+Utilities.h"
#import "HeadLineDetailViewController+Configuration.h"

@implementation HeadLineDetailViewController (LogicalFlow)


- (void)requireForUserInfo {
    NSString *urlString = [BASEURL stringByAppendingString:@"Ucenter/userHomeInfo"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:tokenString forKey:@"at"];
    [param setNewObject:USERSid forKey:@"sid"];
    [param setNewObject:USERUID forKey:@"uid"];
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            self.userInfo = [MineHomePageModel mj_objectWithKeyValues:responseObject[@"data"]];
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)requireForStarType {
    NSString *urlString = [BASEURL stringByAppendingString:@"Common/getStarTypeList"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:tokenString forKey:@"at"];
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)requireForOutType {
    NSString *urlString = [BASEURL stringByAppendingString:@"Common/outTypeList"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:tokenString forKey:@"at"];
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}


- (void)requestForFavourWithOutId:(NSNumber *)outId typeId:(NSNumber *)typeId{
    NSString *urlString = [BASEURL stringByAppendingString:@"App/star"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:USERSid forKey:@"sid"];
    [param setObject:tokenString forKey:@"at"];
    [param setNewObject:outId forKey:@"out_id"];
    [param setNewObject:typeId forKey:@"type_id"];
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"djakld");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


- (void)requestForPublsihCommentWithModel:(PublishCommentModel *)model {
    NSString *urlString = [BASEURL stringByAppendingString:@"App/reply"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:tokenString forKey:@"at"];
    [param setNewObject:USERSid forKey:@"sid"];
    [param setNewObject:USERUID forKey:@"uid"];
    [param setNewObject:@0 forKey:@"fid"];
    [param setNewObject:model.zid forKey:@"zid"];
    [param setNewObject:model.fuid forKey:@"fuid"];
    [param setNewObject:model.out_type forKey:@"out_type"];
    [param setNewObject:model.content forKey:@"content"];
    [param setNewObject:model.uided forKey:@"uided"];
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1) {
            [self handlePublishCommentSuccess];
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)requireForContentDetailWithTid:(NSNumber *)tid {
    NSString *urlString = [BASEURL stringByAppendingString:@"Top/getTopInfo"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:tokenString forKey:@"at"];
    [param setNewObject:tid forKey:@"tid"];
    [param setNewObject:USERSid forKey:@"sid"];
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            self.content = [TopContentModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self handleRequireContentDetailSuccessWithContent:self.content];
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)requireForCommentWithStartCount:(NSInteger)start {
    self.isRefreshing = YES;
    NSString *urlString = [BASEURL stringByAppendingString:@"Top/getTopReplyList"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:tokenString forKey:@"at"];
    [param setNewObject:self.tid forKey:@"tid"];
    [param setNewObject:USERSid forKey:@"sid"];
    [param setNewObject:@(start) forKey:@"start"];
    [param setNewObject:@20 forKey:@"limit"];
    [param setNewObject:@0 forKey:@"start_h"];
    [param setNewObject:@0 forKey:@"limit_h"];
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            NSArray *comments = [HuifuModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self handleRequireCommentsSuccessWithComments:comments start:start];
            [self.tableView reloadData];
            [self updateCommentCount:responseObject[@"count"]];
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

- (void)subscribeUser:(BOOL)subscribe {
    NSString *url = subscribe ? [NSString stringWithFormat:@"%@App/cancelFocusFriend",BASEURL] : [NSString stringWithFormat:@"%@App/focusFriends",BASEURL];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:USERSid forKey:@"sid"];
    [param setNewObject:self.content.uid forKey:@"fuid"];
    [param setNewObject:USERUID forKey:@"uid"];
    
    [self.manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"r"] && [responseObject[@"r"] intValue] == 1) {
            self.content.is_friend = @(!subscribe);
            [self.contentDetailView updateSubscribeStatus:!subscribe];
        }
        self.contentDetailView.subscribeButton.enabled = YES;
        [self toast:responseObject[@"msg"] complete:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.contentDetailView.subscribeButton.enabled = YES;
    }];
}

- (void)collectContent:(BOOL)isCollect {
    NSString *url = isCollect ? [NSString stringWithFormat:@"%@App/cancelCollect",BASEURL] : [NSString stringWithFormat:@"%@App/doCollect",BASEURL];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:USERSid forKey:@"sid"];
    [param setNewObject:self.tid forKey:@"tid"];
    [param setNewObject:USERUID forKey:@"uid"];
    
    [self.manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"r"] && [responseObject[@"r"] intValue] == 1) {
            self.content.is_collect = @(!isCollect);
            self.collectButton.selected = !isCollect;
            NSString *toastString = isCollect ? @"取消收藏成功" : @"收藏成功";
            [self toast:toastString complete:nil];
        }else {
           [self toast:responseObject[@"msg"] complete:nil];
        }
        self.collectButton.enabled = YES;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.collectButton.enabled = YES;
    }];
}

- (void)rewardContentWithCount:(NSInteger)rewardCount {
    NSString *urlString = [BASEURL stringByAppendingString:@"App/doGift"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:tokenString forKey:@"at"];
    [param setNewObject:USERSid forKey:@"sid"];
    [param setNewObject:self.content.uid forKey:@"guid"];
    [param setNewObject:self.content.tid forKey:@"tid"];
    [param setNewObject:@(rewardCount) forKey:@"slice"];
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] intValue] == 1) {
            [self toast:@"打赏成功" complete:nil];
            [self rewardContentSuccessWithCount:rewardCount];
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


#pragma mark - helpMethod

- (void)handleRequireContentDetailSuccessWithContent:(TopContentModel *)content {
    self.collectButton.selected = [content.is_collect boolValue];
    [self.contentDetailView updateContent:content];
}

- (void)handleRequireCommentsSuccessWithComments:(NSArray *)comments start:(NSInteger)start {
    if (start == 0) [self.datasource.comments removeAllObjects];
    [self.datasource.comments addObjectsFromArray:comments];
    MJRefreshBackStateFooter *foot = (MJRefreshBackStateFooter *)self.tableView.mj_footer;
    foot.stateLabel.hidden = self.datasource.comments.count == 0;
    if (comments.count < 20) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [self.tableView.mj_footer resetNoMoreData];
        self.isNoMoreData = YES;
    }
}


- (void)handlePublishCommentSuccess {
    [self toast:@"评论成功" complete:nil];
    self.commentTextField.text = @"";
    self.messageInputView.inputTextView.text = @"";
    [self requireForCommentWithStartCount:0];
}

- (void)rewardContentSuccessWithCount:(NSInteger)rewardCount {
    self.userInfo.balance = @([self.userInfo.balance integerValue] - rewardCount);
    [self.rewardView close];
    [self.contentDetailView updateRewarderCount:[self.content.gift_nums integerValue] + 1];
}


- (void)updateCommentCount:(NSNumber *)count {
    self.commentCountView.hidden = (!count || [count integerValue] == 0);
    self.commentCountLabel.text = [count stringValue];
    [self.commentCountLabel sizeToFit];
    [self.view layoutIfNeeded];
}

@end
