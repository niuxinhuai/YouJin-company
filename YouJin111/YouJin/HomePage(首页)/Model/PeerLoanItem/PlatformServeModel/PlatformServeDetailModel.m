//
//  PlatformServeDetailModel.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformServeDetailModel.h"
#import "PlatformTopPictureArrayModel.h"
@implementation PlatformServeDetailModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"com_img":@"PlatformTopPictureArrayModel"};
}
@end
