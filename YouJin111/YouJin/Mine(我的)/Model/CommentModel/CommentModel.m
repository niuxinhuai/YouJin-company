//
//  CommentModel.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/2.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CommentModel.h"
#import "NSString+Utilities.h"

@implementation CommentModel



+ (NSArray *)mj_ignoredPropertyNames {
    return @[@"height"];
}


- (CGFloat)getCellHeight {
    if (self.height == 0) {
        CGFloat contentHeight = [self.content getSizeWithFont:14 constrainedToSize:CGSizeMake([UIScreen screenWidth] - 30, MAXFLOAT) andlineSpacing:1].height;
        self.height = contentHeight + 140;
    }
    return self.height;
}






@end
