//
//  CityGroupModel.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/3.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CityGroupModel.h"
#import "CityModel.h"
@implementation CityGroupModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"cars":@"CityModel"};
}
@end
