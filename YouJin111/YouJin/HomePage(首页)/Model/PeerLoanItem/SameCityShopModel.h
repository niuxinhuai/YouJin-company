//
//  SameCityShopModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/31.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SameCityShopModel : NSObject
/**公司logourl*/
@property (nonatomic, copy) NSString *logo;

/**平台名称*/
@property (nonatomic, copy) NSString *name;

/**最低利率*/
@property (nonatomic, copy) NSString *apr_min;

/**最高利率*/
@property (nonatomic, copy) NSString *apr_max;
/**门店地址*/
@property (nonatomic, copy) NSString *addr;
@end
