//
//  DetailButton.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "DetailButton.h"

@implementation DetailButton


- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(17 * BOScreenW / BOPictureW, 8 * BOScreenH / BOScreenH, 25 * BOScreenW / BOPictureH, 15 * BOScreenW / BOPictureW);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + 4 * BOScreenW / BOPictureW, 5 * BOScreenH / BOPictureH, 30 * BOScreenW / BOPictureW, 20 * BOScreenW / BOPictureW);
    
    self.layer.cornerRadius = 14;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = BOColor(163, 164, 165).CGColor;
    
    [self setTitleColor:BOColor(144, 145, 146) forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:13]];
}

@end
