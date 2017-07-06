//
//  CollectionCellItem.h
//  CustomMessageView
//
//  Created by 李智权 on 17/3/23.
//  Copyright © 2017年 ZJS. All rights reserved.
//

#import "ZallBaseItem.h"

@interface CollectionCellItem : ZallBaseItem

/**
 *  @brief  图片
 */
@property (copy, nonatomic) NSString *picName;

/**
 *  @brief  文字
 */
@property (copy, nonatomic) NSString *title;

/**
 *  @brief  高度
 */
@property (assign, nonatomic) float cellHeight;

/**
 *  @brief  宽度
 */
@property (assign, nonatomic) float cellWidth;

- (instancetype)initWithPic:(NSString *)picName title:(NSString *)title height:(float)height width:(float)width;

@end
