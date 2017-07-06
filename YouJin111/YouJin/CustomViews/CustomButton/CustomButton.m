//
//  CustomButton.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/26.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CustomButton.h"
#import "UIButton+Utilities.h"

@implementation CustomButton

- (void)layoutSubviews {
    [super layoutSubviews];
    switch (self.type) {
        case kCustomButtonNone:
            break;
        case kCustomButtonImageToText: [self makeImageToTitleInset];
            break;
        case kCustomButtonTextToImage: [self makeTitleToImageInset];
            break;
        default:
            break;
    }
}



@end
