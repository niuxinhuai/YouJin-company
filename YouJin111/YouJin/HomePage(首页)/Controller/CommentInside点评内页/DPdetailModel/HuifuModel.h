//
//  HuifuModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HuifuModel : NSObject
@property (nonatomic ,copy)NSString *head_image;//用户头像
@property (nonatomic ,copy)NSString *uname;//用户昵称
@property (nonatomic ,copy)NSString *score;//评分
@property (nonatomic ,copy)NSString *replyed_uname;//谁回复的这条评论
@property (nonatomic ,copy)NSString *before;//比如：16分钟以前
@property (nonatomic ,retain)NSNumber *star;//点赞数
@property (nonatomic ,copy)NSString *person_vip;//1/已认证的个人有金号  0/未认证
@property (nonatomic ,copy)NSString *company_vip;//1/已认证的企业有金号   0/未认证
@property (nonatomic ,copy)NSString *content;//点评内容
@property (nonatomic ,copy)NSNumber *uid;
@property (nonatomic ,copy)NSNumber *is_star;
@property (nonatomic ,copy)NSNumber *pid;
@property (nonatomic, retain) NSNumber *reply_nums;
@property (nonatomic, retain) NSString *time_h;
@property (nonatomic, retain) NSString *from;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat replyMessageCellHeight;

- (CGFloat)topCommentCellHeight;

- (CGFloat)getReplyMessageCellHeight;

@end
