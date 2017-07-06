//
//  BOLcationButton.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/7.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOLcationButton.h"

@implementation BOLcationButton

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.imageView.x < self.titleLabel.x) {
        self.titleLabel.frame = CGRectMake(self.imageView.x, self.titleLabel.y, self.titleLabel.width, self.titleLabel.height);
        self.imageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 3 * BOScreenW / BOPictureW, self.imageView.y, self.imageView.width, self.imageView.height);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }

}

@end
