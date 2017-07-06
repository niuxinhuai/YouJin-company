//
//  PeerHonePageModel.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/30.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PeerHonePageModel.h"
#import "BackgroundModel.h"
#import "PlatformHuodongItem.h"
@implementation PeerHonePageModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"bg_array":@"BackgroundModel", @"huodong":@"PlatformHuodongItem"};
}
@end
