//
//  HotCommentModle.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HotCommentModle.h"
#import "NSString+Utilities.h"

@implementation ReplyChildModel


@end



@implementation HotCommentModle


+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"reply_child" : @"ReplyChildModel",
             };
}


+ (NSArray *)mj_ignoredPropertyNames {
    return @[@"height"];
}


- (CGFloat)getCellHeight {
    if (self.height == 0) {
        CGFloat contentHeight = [self.content getSizeWithFont:15 constrainedToSize:CGSizeMake([UIScreen screenWidth] - 20, 40) andlineSpacing:1].height;
        self.height = contentHeight + 145;
    }
    return self.height;
}


@end
