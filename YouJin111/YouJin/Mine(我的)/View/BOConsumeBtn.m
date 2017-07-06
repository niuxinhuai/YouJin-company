//
//  BOConsumeBtn.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOConsumeBtn.h"

@implementation BOConsumeBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置文字对齐
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 设置文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        // 告诉系统在Disabled状态下要不要调整显示的图片
        self.adjustsImageWhenDisabled = NO;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0.5 * self.width - 0.5 * 25 * BOScreenW / BOPictureW, 15 * BOScreenH / BOPictureH, 25 * BOScreenW / BOPictureW, 25 * BOScreenW / BOPictureW);
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + 10 * BOScreenH / BOPictureH, self.width, 15 * BOScreenH / BOPictureH);
}

@end
