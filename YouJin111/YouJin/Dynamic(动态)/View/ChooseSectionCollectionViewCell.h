//
//  ChooseSectionCollectionViewCell.h
//  CustomMessageView
//
//  Created by 李智权 on 17/3/23.
//  Copyright © 2017年 ZJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CollectionCellItem;
@interface ChooseSectionCollectionViewCell : UICollectionViewCell

/**
 *  @brief  数据
 */
@property (copy, nonatomic) CollectionCellItem *item;
/**
 *  @brief  图片显示
 */
@property (strong, nonatomic, readonly) UIImageView *headImageView;

/**
 *  @brief  文字显示
 */
@property (strong, nonatomic, readonly) UILabel *titleLabel;
@end
