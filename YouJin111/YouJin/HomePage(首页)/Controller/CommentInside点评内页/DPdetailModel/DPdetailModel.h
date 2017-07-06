//
//  DPdetailModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPdetailModel : NSObject
//data
@property (nonatomic ,copy)NSString *pname;//被点评的平台名称
@property (nonatomic ,copy)NSString *head_image;//用户头像
@property (nonatomic ,copy)NSString *uname;//用户昵称
@property (nonatomic ,copy)NSString *score;//评分
@property (nonatomic ,copy)NSString *content;//点评内容
//@property (nonatomic ,copy)NSString *reply_child;//评分细则
@property (nonatomic ,copy)NSString *star;//点赞数
@property (nonatomic ,copy)NSString *is_good;//1/是精华   0/不是精华
@property (nonatomic ,copy)NSString *is_star;//1／点过赞  0/未点赞
@property (nonatomic ,copy)NSString *v1;//对应评分细则里第1个的值
@property (nonatomic ,copy)NSString *v2;//对应评分细则里第2个的值
@property (nonatomic ,copy)NSString *v3;//对应评分细则里第3个的值
@property (nonatomic ,copy)NSString *v4;//对应评分细则里第4个的值
@property (nonatomic ,copy)NSString *pid;//点评编号
@property (nonatomic ,copy)NSString *before;//比如：16分钟以前
@property (nonatomic ,copy)NSString *person_vip;//1/已认证的个人有金号  0/未认证
@property (nonatomic ,copy)NSString *company_vip;//1/已认证的企业有金号   0/未认证
@property (nonatomic ,strong)NSMutableArray *img_url;
@property (nonatomic ,strong)NSMutableArray *repaly_child;

@property (nonatomic ,copy)NSString *fid;
@property (nonatomic ,copy)NSString *fuid;
@property (nonatomic ,copy)NSString *uid;
@property (nonatomic ,copy)NSString *uided;
@property (nonatomic ,copy)NSString *zid;
@property (nonatomic ,copy)NSString *zpid;

@end
