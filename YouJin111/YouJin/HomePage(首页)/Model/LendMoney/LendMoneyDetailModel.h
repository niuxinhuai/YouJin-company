//
//  LendMoneyDetailModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LendMoneyDetailModel : NSObject
/**借钱产品编号*/
@property (nonatomic, copy) NSString *brid;
/**logo*/
@property (nonatomic, copy) NSString *logo;
/**产品名称*/
@property (nonatomic, copy) NSString *name;
/**评分*/
@property (nonatomic, copy) NSString *score;
/**产品描述*/
@property (nonatomic, copy) NSString *desc;
/**月利率*/
@property (nonatomic, copy) NSString *month_apr;
/**最快放款时间*/
@property (nonatomic, copy) NSString *give_money_time;
/**申请条件*/
@property (nonatomic, copy) NSString *tiaojian;
/**所需材料*/
@property (nonatomic, copy) NSString *need;
/**申请人数*/
@property (nonatomic, copy) NSString *nums;
/**最小额度*/
@property (nonatomic, copy) NSString *min_limit;
/**最大额度*/
@property (nonatomic, copy) NSString *max_limit;
/**链接地址*/
@property (nonatomic, copy) NSString *link_url;
/**类型数组*/
@property (nonatomic, strong) NSArray *type;
//分期期限
@property (nonatomic ,strong)NSString *fenqi_limit;
@end
