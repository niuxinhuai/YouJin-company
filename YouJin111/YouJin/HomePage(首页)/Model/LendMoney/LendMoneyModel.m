//
//  LendMoneyModel.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "LendMoneyModel.h"
#import "LendTypeModel.h"
@implementation LendMoneyModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"type":@"LendTypeModel"};
}
@end
