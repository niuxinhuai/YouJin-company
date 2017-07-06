//
//  LendMoneyDetailModel.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "LendMoneyDetailModel.h"
#import "LendTypeModel.h"
@implementation LendMoneyDetailModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"type":@"LendTypeModel"};
}
@end
