//
//  DPdetailModel.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "DPdetailModel.h"
//#import "ThePictureModel.h"
//#import "FourTheLabelModel.h"

@implementation DPdetailModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"img_url":@"ThePictureModel",@"repaly_child":@"FourTheLabelModel"};
}
@end
