//
//  CustomHeaderCollectionReusableView.h
//  CustomMessageView
//
//  Created by 李智权 on 17/3/23.
//  Copyright © 2017年 ZJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionCellItem.h"

@interface CustomHeaderCollectionReusableView : UICollectionReusableView

/**
 *  @brief  数据
 */
@property (copy, nonatomic) CollectionCellItem *item;

@end
