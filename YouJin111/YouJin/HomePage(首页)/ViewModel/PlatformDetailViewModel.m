//
//  PlatformDetailViewModel.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/8.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformDetailViewModel.h"
#import "BODynamicItem.h"
@implementation PlatformDetailViewModel
- (void)setItem:(BODynamicItem *)item {
    _item = item;
    // 记录一行有多少个图片
    NSInteger ranks = 3;
    // 计算头部名称和发表内容的高度
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topW = BOScreenW;
    CGFloat topH = 125 * BOScreenH / BOPictureH;
    CGFloat pictureMargin = 5;
    _topFrame = CGRectMake(topX, topY, topW, topH);
    _cellH = CGRectGetMaxY(_topFrame);
    // 判断对应的图片数，确定不同的布局
    if ([item.picture_number intValue] == 1) {
        CGFloat pictureX = 15 * BOScreenW / BOPictureW;
        CGFloat pictureY = _cellH;
        CGFloat pictureW = 120;
        CGFloat pictureH = 120;
        _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
        _cellH = CGRectGetMaxY(_pictureViewFrame);
    }else if ([item.picture_number intValue] > 0) {
        // 得到有几行
        NSInteger entireNum = [item.picture_number intValue] / ranks;
        // 得到有几列
        CGFloat pictureX = 15 * BOScreenW / BOPictureW;
        CGFloat pictureY = _cellH;
        CGFloat pictureW = 250;
        CGFloat pictureH = entireNum * pictureMargin + (entireNum + 1) * 80;
        _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
        _cellH = CGRectGetMaxY(_pictureViewFrame);
    }
    
    // 点赞，评论的View
    CGFloat praiseX = 0;
    CGFloat praiseY = _cellH;
    CGFloat praiseW = BOScreenW;
    CGFloat praiseH = 60 * BOScreenH / BOPictureH;
    _bottomFrame = CGRectMake(praiseX, praiseY, praiseW, praiseH);
    _cellH = CGRectGetMaxY(_bottomFrame);
}

@end
