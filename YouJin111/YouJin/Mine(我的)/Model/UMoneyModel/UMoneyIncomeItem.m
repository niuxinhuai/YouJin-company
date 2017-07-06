//
//  UMoneyIncomeItem.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "UMoneyIncomeItem.h"

@implementation UMoneyIncomeItem


- (NSString *)getIconImageUrlString {
    NSString *urlString = @"icon_qtty";
    switch ([self.trid integerValue]) {
        case 1:
            urlString = @"icon_qdjl";
            break;
        case 2:
            urlString = @"icon_zczh";
            break;
        case 3:
        case 4:
            urlString = @"icon_dashang";
            break;
        case 5:
            urlString = @"icon_yqhy";
            break;
        case 6:
            urlString = @"icon_tixian";
            break;
        case 7:
        case 8:
        case 9:
        case 11:
            urlString = @"icon_fbtt";
            break;
        case 15:
            urlString = @"icon_zczh";
            break;
        case 18:
        case 19:
        case 20:
        case 21:
        case 22:
            urlString = @"icon_fxtt";
            break;
        case 23:
            urlString = @"icon_qjhd";
            break;
        case 25:
        case 26:
            urlString = @"icon_choujiang";
            break;
        default:
            break;
    }
    return urlString;
}

@end
