//
//  HotNetFundModel.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HotNetFundModel.h"
#import "BondModel.h"
@implementation HotNetFundModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"tz_data":@"BondModel"};
}
@end
