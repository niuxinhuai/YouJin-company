//
//  MineHomePageViewController+LogicalFlow.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MineHomePageViewController+LogicalFlow.h"
#import "MineHomePageViewController+Configuration.h"
#import "NSMutableDictionary+Utilities.h"

@implementation MineHomePageViewController (LogicalFlow)

- (void)requstUserInfo {
    NSString *url = [self isMe] ? [NSString stringWithFormat:@"%@Ucenter/getMyHomePageBaseInfo",BASEURL] : [NSString stringWithFormat:@"%@Common/getOtherHomePageBaseInfo",BASEURL];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"at"] = tokenString;
    if ([self isMe]) {
        dictionary[@"sid"] = USERSid;
    }else {
        dictionary[@"uid_me"] = USERUID;
    }
    dictionary[@"uid"] = @(self.uid);
    
    [self.manager POST:url parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            self.userInfo = [MinePageItem mj_objectWithKeyValues:responseObject[@"data"]];
            [self updateUserMessage];
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)subscribeUser:(BOOL)subscribe {
    NSString *url = subscribe ? [NSString stringWithFormat:@"%@App/focusFriends",BASEURL] : [NSString stringWithFormat:@"%@App/cancelFocusFriend",BASEURL];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:USERSid forKey:@"sid"];
    [param setNewObject:@(self.uid) forKey:@"fuid"];
    [param setNewObject:USERUID forKey:@"uid"];
    
    [self.manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"r"] && [responseObject[@"r"] intValue] == 1) {
            [self updateSubscribeStatus:!self.isSubscribe];
        }
        [self toast:responseObject[@"msg"] complete:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


@end
