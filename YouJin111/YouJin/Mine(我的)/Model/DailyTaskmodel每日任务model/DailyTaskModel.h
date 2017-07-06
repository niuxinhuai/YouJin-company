//
//  DailyTaskModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/8.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyTaskModel : NSObject
@property (nonatomic ,copy)NSString *is_signin;//是否已签到  1/已签到  0/未签到
@property (nonatomic ,copy)NSString *dianping_num;//发表点评次数
@property (nonatomic ,copy)NSString *pinglun_num;//发表评论次数
@property (nonatomic ,copy)NSString *share_num;//分享次数
@end
