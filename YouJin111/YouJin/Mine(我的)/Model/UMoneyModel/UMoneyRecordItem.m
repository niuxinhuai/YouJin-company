//
//  UMoneyRecordItem.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "UMoneyRecordItem.h"

@implementation UMoneyRecordItem



- (NSString *)getIconImageUrlString {
    NSString *urlString = @"";
    switch ([self.status integerValue]) {
        case 0:
            
            break;
        case 1:
            urlString = @"icon_chenggong";
            break;
        case 2:
            urlString = @"icon_shibai";
            break;
        default:
            break;
    }
    return urlString;
}


@end
