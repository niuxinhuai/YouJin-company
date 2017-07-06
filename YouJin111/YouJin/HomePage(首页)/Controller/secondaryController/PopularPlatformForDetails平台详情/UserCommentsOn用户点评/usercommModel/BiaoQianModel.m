//
//  BiaoQianModel.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/20.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BiaoQianModel.h"
#import "NSString+Utilities.h"


@implementation BiaoQianModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"img_url":@"UserDpImaUrlModel"};
}

- (CGFloat)topCommentCellHeight
{
    if (self.cellHeight == 0) {
        CGFloat contentHeight = [self.content getSizeFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake([UIScreen screenWidth] - 20, 80) andlineSpacing:1].height;
        if (self.img_url.count == 0) {
            self.cellHeight = contentHeight + 140;
        }else if (self.img_url.count == 1) {
            self.cellHeight = contentHeight + 270;
        }else {
            self.cellHeight = contentHeight + 240;
        }
    }
    return self.cellHeight;
}
@end
