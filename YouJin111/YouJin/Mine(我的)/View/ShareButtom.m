//
//  ShareButtom.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "ShareButtom.h"

@implementation ShareButtom

- (void)layoutSubviews {
    [super layoutSubviews];
    // 布局中间的imageView
    self.imageView.frame = CGRectMake((self.width - 50 * BOWidthRate) * 0.5, 27 * BOHeightRate, 50 * BOWidthRate, 50 * BOWidthRate);
    self.titleLabel.frame = CGRectMake(0, 87 * BOHeightRate, self.width, 15 * BOHeightRate);
    [self.titleLabel setFont:[UIFont systemFontOfSize:13]];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
@end
