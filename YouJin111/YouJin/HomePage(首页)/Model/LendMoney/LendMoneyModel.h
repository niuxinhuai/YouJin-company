//
//  LendMoneyModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LendMoneyModel : NSObject
/**借钱产品编号*/
@property (nonatomic, copy) NSString *brid;
/**logo*/
@property (nonatomic, copy) NSString *logo;
/**产品名称*/
@property (nonatomic, copy) NSString *name;
/**评分*/
@property (nonatomic, copy) NSString *score;
/**申请人数*/
@property (nonatomic, copy) NSString *nums;
/**最小额度*/
@property (nonatomic, copy) NSString *min_limit;
/**最大额度*/
@property (nonatomic, copy) NSString *max_limit;
/**类型数组*/
@property (nonatomic, strong) NSArray *type;
/***/
//@property (nonatomic, copy) NSString *brid;
/**产品描述*/
@property (nonatomic, copy) NSString *desc;
/**链接地址*/
@property (nonatomic, copy) NSString *link_url;
@end
