//
//  BuyMarketModel.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BuyMarketModel.h"
#import "BuyArrayModel.h"
@implementation BuyMarketModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"tz_data":@"BuyArrayModel"};
}
@end
