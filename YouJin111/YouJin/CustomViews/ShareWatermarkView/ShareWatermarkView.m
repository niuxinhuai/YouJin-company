//
//  ShareWatermarkView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "ShareWatermarkView.h"

@implementation ShareWatermarkView

+ (instancetype)create {
    ShareWatermarkView *share = [[NSBundle mainBundle]loadNibNamed:@"ShareWatermarkView" owner:nil options:nil].firstObject;
    return share;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat width = [UIScreen screenWidth];
    CGFloat height = [UIScreen screenHeight];
    self.frame = CGRectMake(0, 0, width, height);
}


- (void)updateShareImage:(UIImage *)image {
    self.shareImageView.image = image;
}


@end
