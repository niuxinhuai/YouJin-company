//
//  ConsumptionFq.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsumptionFq : NSObject
//消费分期
@property (nonatomic ,copy)NSString *logo;//logo
@property (nonatomic ,copy)NSString *name;//平台名称
@property (nonatomic ,copy)NSString *score;//评分
@property (nonatomic ,copy)NSString *province;//省(编号)
@property (nonatomic ,copy)NSString *city;//市(编号)
@property (nonatomic ,copy)NSString *sheng;//省
@property (nonatomic ,copy)NSString *shi;//市
@property (nonatomic ,copy)NSString *apr_min;//最低利率
@property (nonatomic ,copy)NSString *apr_max;//最高利率
@property (nonatomic ,copy)NSString *type;//分期类型
@property (nonatomic ,copy)NSString *pt_desc;//介绍
@property (nonatomic ,copy)NSString *ptid;//介绍
@property (nonatomic ,copy)NSString *xf_desc;//介绍
//关注平台
@end
