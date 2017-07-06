//
//  BOExceedPictureView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/14.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOExceedPictureView.h"
#import "BODynamicItem.h"
@implementation BOExceedPictureView

+ (instancetype)viewForXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}
- (void)setItem:(BODynamicItem *)item {
    _item = item;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 总列数
    NSInteger maxCols = 3;
    // 各个图片之间的间距为 5
    CGFloat margin = 5;
    // 一共多少张图片
    NSInteger sum = [_item.picture_number integerValue];
    // 每一个ImageView的宽高都是80
    CGFloat imageWH = 80;
    for (NSInteger i = 0; i < sum; i++) {
        // 当前处于第几列
        NSInteger col = i % maxCols;
        // 当前处于第几行
        NSInteger line = i / maxCols;
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(col * (margin + imageWH), line * (margin + imageWH), imageWH, imageWH)];
        [self addSubview:imageV];
        imageV.backgroundColor = [UIColor blackColor];
    }
}
@end
