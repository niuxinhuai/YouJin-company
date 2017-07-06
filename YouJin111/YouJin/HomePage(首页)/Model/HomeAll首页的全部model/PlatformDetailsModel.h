//
//  PlatformDetailsModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 main_data
 */
@interface PlatformDetailsModel : NSObject
@property (nonatomic ,copy)NSString *ptid;//平台编号
@property (nonatomic ,copy)NSString *logo;//Logo
@property (nonatomic ,copy)NSString *province;//省(编号)
@property (nonatomic ,copy)NSString *city;//市(编号)
@property (nonatomic ,copy)NSString *sheng;//省
@property (nonatomic ,copy)NSString *shi;//市
@property (nonatomic ,copy)NSString *name;//平台名称
@property (nonatomic ,copy)NSString *score;//评分
@property (nonatomic ,copy)NSString *v1;//实力
@property (nonatomic ,copy)NSString *v2;//透明度
@property (nonatomic ,copy)NSString *v3;//运营
@property (nonatomic ,copy)NSString *v4;//服务
@property (nonatomic ,copy)NSString *tab;//标签
@property (nonatomic ,copy)NSString *apr_min;//最低利率
@property (nonatomic ,copy)NSString *apr_max;//最高利率
@property (nonatomic ,copy)NSString *pt_desc;//平台简介
@property (nonatomic ,copy)NSString *bz_model;//保障模式
@property (nonatomic ,copy)NSString *bus_model;//业务类型
@property (nonatomic ,copy)NSString *background;//背景
@property (nonatomic ,strong)NSMutableArray *bg_array;//背景数组
@property (nonatomic ,copy)NSString *cgid;//cgid大于零说明有存管
@property (nonatomic ,copy)NSString *cg_bank;//存管银行
@property (nonatomic ,copy)NSString *reg_url;//新手活动 |  跳转链接
@property (nonatomic ,copy)NSString *url;//官网
@property (nonatomic ,copy)NSString *down_url;//活动 |  跳转链接
@property (nonatomic ,copy)NSString *jianguan;//监管协会
//@property (nonatomic ,copy)NSString *bz_model;//保障模式
@property (nonatomic ,copy)NSString *icp_beian;//icp备案号
@property (nonatomic ,copy)NSString *icp_xuke;//icp许可证号
@property (nonatomic ,copy)NSString *police_beian;//公安网备案
@property (nonatomic ,copy)NSString *serve_mobile;//客服电话
@property (nonatomic ,copy)NSString *public_weixin;//微信公众号
@property (nonatomic ,copy)NSString *addr;//办公地址
@property (nonatomic ,copy)NSString *company_name;//公司名称
@property (nonatomic ,copy)NSString *com_reg_num;//营业执照注册号
@property (nonatomic ,copy)NSString *legal_person;//法人代表
@property (nonatomic ,copy)NSString *reg_money;//注册资本
@property (nonatomic ,copy)NSString *real_money;//实缴资本
@property (nonatomic ,copy)NSString *big_boss;//疑似实际控制人
//@property (nonatomic ,copy)NSString *icp_beian;//icp备案号
//@property (nonatomic ,copy)NSString *icp_xuke;//icp许可证号
//@property (nonatomic ,copy)NSString *police_beian;//公安网备案

@property (nonatomic ,copy)NSMutableArray *com_img;//公司图片数组

@property (nonatomic ,copy)NSString *begin_time;//上线时间
@property (nonatomic ,copy)NSString *is_focus;//传sid的时候会有，用户关注了这个平台就是1，没有关注就是0

@end
