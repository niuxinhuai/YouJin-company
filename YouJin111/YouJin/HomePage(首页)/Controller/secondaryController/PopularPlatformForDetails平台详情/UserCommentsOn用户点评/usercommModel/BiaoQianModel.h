//
//  BiaoQianModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/20.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDpImaUrlModel.h"

@interface BiaoQianModel : NSObject
//各个标签的值
@property (nonatomic ,copy)NSString *good_sum;//好评数量
@property (nonatomic ,copy)NSString *bad_sum;//差评数量
@property (nonatomic ,copy)NSString *fast_tixian_sum;//提现快数量
@property (nonatomic ,copy)NSString *nice_service_sum;//服务好数量
@property (nonatomic ,copy)NSString *reliable_sum;//靠谱数量
@property (nonatomic ,copy)NSString *not_open_sum;//不透明数量
@property (nonatomic ,copy)NSString *terrible_sum;//坑爹数量
@property (nonatomic ,copy)NSString *not_indroduce_sum;//不推荐数量
//平台点评列表
@property (nonatomic ,copy)NSString *head_image;//用户头像
@property (nonatomic ,copy)NSString *uname;//用户昵称
@property (nonatomic ,copy)NSString *score;//评分
@property (nonatomic ,copy)NSString *content;//点评内容
@property (nonatomic ,copy)NSNumber *star;//点赞数
@property (nonatomic ,copy)NSString *reply_nums;//回复数
@property (nonatomic ,copy)NSString *time_h;//时间
@property (nonatomic ,strong)NSMutableArray *img_url;//点评图片数组
@property (nonatomic ,copy)NSNumber *person_vip;//1/已认证的个人有金号  0/未认证
@property (nonatomic ,copy)NSNumber *company_vip;//1/已认证的企业有金号   0/未认证
@property (nonatomic ,copy)NSString *is_star;//是否已经点赞
@property (nonatomic ,copy)NSString *v1;
@property (nonatomic ,copy)NSString *v2;
@property (nonatomic ,copy)NSString *v3;
@property (nonatomic ,copy)NSString *v4;
@property (nonatomic ,copy)NSString *is_good;//精华点评的判断
@property (nonatomic ,copy)NSString *pid;
@property (nonatomic ,copy)NSString *fid;
@property (nonatomic ,copy)NSString *fuid;
@property (nonatomic ,copy)NSString *uid;
@property (nonatomic ,copy)NSString *uided;
@property (nonatomic ,copy)NSString *zid;
@property (nonatomic ,copy)NSString *zpid;
@property (nonatomic ,copy)NSString *before;


@property (nonatomic, assign) CGFloat cellHeight;//得到字体的高度
- (CGFloat)topCommentCellHeight;


@end
