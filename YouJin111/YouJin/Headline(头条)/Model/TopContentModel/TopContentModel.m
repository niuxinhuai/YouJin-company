//
//  TopContentModel.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "TopContentModel.h"

@implementation TopContentModel


+ (NSArray *)mj_ignoredPropertyNames {
    return @[@"contentType"];
}



#pragma mark - reget

- (TopContentType)contentType {
    if (!self.cover || self.cover.count == 0) {
        return TopContentText;
    }else if (self.cover.count < 3) {
        return TopContentOneImage;
    }
    return TopContentThreeImage;
}


#pragma mark - publicMethod

- (CGFloat)cellHeight {
    switch (self.contentType) {
        case TopContentText: return 90;
        case TopContentOneImage: return 90;
        case TopContentThreeImage: return 150;
        default:
            break;
    }
    return 0;
}

@end
