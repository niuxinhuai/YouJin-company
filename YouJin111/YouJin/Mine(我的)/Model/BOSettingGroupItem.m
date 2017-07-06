//
//  BOSettingGroupItem.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOSettingGroupItem.h"

@implementation BOSettingGroupItem
+ (instancetype)ItemWithRowItemArray:(NSArray *)rowItemArray {
    
    BOSettingGroupItem *groupItem = [[self alloc] init];
    groupItem.rowItemArray = rowItemArray;
    return groupItem;
}

@end
