//
//  PlatformServeDetailModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlatformServeDetailModel : NSObject

/**logo*/
@property (nonatomic, copy) NSString *logo;
/**详情头部对应的数组*/
@property (nonatomic, strong) NSArray *com_img;
/**公司名称*/
@property (nonatomic, copy) NSString *com_name;
/**产品名称*/
@property (nonatomic, copy) NSString *pro_name;
/**平台名称*/
@property (nonatomic, copy) NSString *pname;
/**官网地址*/
@property (nonatomic, copy) NSString *url;
/**其他产品名称*/
@property (nonatomic, copy) NSString *other_pro;
/**业务电话*/
@property (nonatomic, copy) NSString *mobile;
/**典型客户*/
@property (nonatomic, copy) NSString *example;
/**公司地址*/
@property (nonatomic, copy) NSString *addr;
/**成立日期*/
@property (nonatomic, copy) NSString *begin_time;
/**介绍*/
@property (nonatomic, copy) NSString *desc;
/**分数*/
@property (nonatomic, copy) NSString *score;
/**产品*/
@property (nonatomic, copy) NSString *v1;
/**功能*/
@property (nonatomic, copy) NSString *v2;
/**实力*/
@property (nonatomic, copy) NSString *v3;
/**服务*/
@property (nonatomic, copy) NSString *v4;
/**标签*/
@property (nonatomic, copy) NSString *tab;
/**省(编号)*/
@property (nonatomic, copy) NSString *province;
/**市(编号)*/
@property (nonatomic, copy) NSString *city;
/**省*/
@property (nonatomic, copy) NSString *sheng;
/**市*/
@property (nonatomic, copy) NSString *shi;
/**平台编号*/
@property (nonatomic, copy) NSString *svid;
@end
