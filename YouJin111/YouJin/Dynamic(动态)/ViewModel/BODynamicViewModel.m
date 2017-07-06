//
//  BODynamicViewModel.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BODynamicViewModel.h"
#import "BODynamicItem.h"
@implementation BODynamicViewModel

- (void)setItem:(BODynamicItem *)item {
    _item = item;
    
    // 计算头部名称和发表内容的高度
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat margin = 15;
    CGFloat topW = BOScreenW - margin;
    CGFloat textY = 75;
    CGFloat pictureMargin = 5;
    CGFloat textW = BOScreenW - 2 * margin;
    NSInteger ranks = 3;
    UIFont *font = [UIFont systemFontOfSize:15];
    NSDictionary *attribute = @{NSFontAttributeName : font};
    CGFloat textH = [item.article_text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.height;
    _nameTextFrame = CGRectMake(topX, topY, topW, textH + textY);
    _cellH = CGRectGetMaxY(_nameTextFrame);
    // 判断对应的图片数，确定不同的布局
    if ([item.picture_number intValue] == 1) {
        CGFloat pictureX = 10;
        CGFloat pictureY = _cellH;
        CGFloat pictureW = 120;
        CGFloat pictureH = 120;
        _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
        _cellH = CGRectGetMaxY(_pictureViewFrame);
    }else if ([item.picture_number intValue] == 4) {
        CGFloat pictureX = 10;
        CGFloat pictureY = _cellH;
        CGFloat pictureW = 165;
        CGFloat pictureH = 165;
        _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
        _cellH = CGRectGetMaxY(_pictureViewFrame);
    }else if ([item.picture_number intValue] > 0) {
        // 得到有几行
        NSInteger entireNum = [item.picture_number intValue] / ranks;
        // 得到有几列
        CGFloat pictureX = 10;
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
    CGFloat praiseH = 40;
    _praiseNumberFrame = CGRectMake(praiseX, praiseY, praiseW, praiseH);
    _cellH = CGRectGetMaxY(_praiseNumberFrame) + 8 * BOHeightRate;
}
@end
