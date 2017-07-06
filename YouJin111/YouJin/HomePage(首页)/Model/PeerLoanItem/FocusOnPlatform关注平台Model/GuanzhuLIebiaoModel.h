//
//  GuanzhuLIebiaoModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/6/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuanzhuLIebiaoModel : NSObject
@property (nonatomic ,copy)NSString *ptid;//平台编号
@property (nonatomic ,copy)NSString *logo;//Logo
@property (nonatomic ,copy)NSString *province;//省(编号)
@property (nonatomic ,copy)NSString *city;//市(编号)
@property (nonatomic ,copy)NSString *sheng;//省
@property (nonatomic ,copy)NSString *shi;//市
@property (nonatomic ,copy)NSString *name;//平台名称
@property (nonatomic ,copy)NSString *score;//评分
@property (nonatomic ,copy)NSString *apr_min;//最低利率
@property (nonatomic ,copy)NSString *apr_max;//最高利率
@property (nonatomic ,copy)NSString *bus_model;//业务模式
@property (nonatomic ,copy)NSString *background;//背景
@property (nonatomic ,copy)NSString *cgid;//cgid大于零说明有存管
@property (nonatomic ,copy)NSString *is_focus;//1/已关注 0/未关注
@property (nonatomic ,strong)NSNumber *fans;//多少人关注
@end
