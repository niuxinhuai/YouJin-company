//
//  PlatformServiceDetailModel.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformServiceDetailModel.h"
#import "NSString+Utilities.h"

@implementation PlatformServiceDetailModel



- (CGFloat)platformSeviceDetailHeadViewHeightWithOpenCompanyInfo:(BOOL)isOpen {
    CGFloat totoalHeight = 724;
    CGFloat productHeight = [self.other_pro getSizeWithFont:13 constrainedToSize:CGSizeMake([UIScreen screenWidth] - 30, MAXFLOAT) andlineSpacing:1].height;
    totoalHeight += productHeight;
    CGFloat maxInfoHeight = MAXFLOAT;
    CGFloat infoHeight = [self.desc getSizeWithFont:13 constrainedToSize:CGSizeMake([UIScreen screenWidth] - 30, maxInfoHeight) andlineSpacing:1].height;
    self.isNoNeedLoadMore = infoHeight < 55;
    if (self.isNoNeedLoadMore) {
        totoalHeight -= 45;
    }else {
        infoHeight = isOpen ? infoHeight : 55;
    }
    totoalHeight += infoHeight;
    return totoalHeight;
}



@end
