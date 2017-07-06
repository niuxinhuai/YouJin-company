//
//  HuifuModel.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HuifuModel.h"
#import "NSString+Utilities.h"

@implementation HuifuModel


- (CGFloat)topCommentCellHeight {
    if (self.cellHeight == 0) {
        CGFloat contentHeight = [self.content getSizeFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake([UIScreen screenWidth] - 75, MAXFLOAT) andlineSpacing:1].height;
        self.cellHeight = contentHeight + 82;
    }
    return self.cellHeight;
}

- (CGFloat)getReplyMessageCellHeight {
    if (self.replyMessageCellHeight == 0) {
        CGFloat contentHeight = [self.content getSizeFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake([UIScreen screenWidth] - 30, MAXFLOAT) andlineSpacing:1].height;
        self.replyMessageCellHeight = contentHeight + 130;
    }
    return self.replyMessageCellHeight;
}

- (NSString *)content {
    if (self.replyed_uname.length > 0) {
        return [NSString stringWithFormat:@"回复%@: %@", self.replyed_uname, _content];
    }
    return _content;
}

@end
