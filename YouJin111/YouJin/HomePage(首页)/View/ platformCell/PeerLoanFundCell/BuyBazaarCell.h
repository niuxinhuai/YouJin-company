//
//  BuyBazaarCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/24.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BuyBazaarCell, BuyModel;
@protocol BuyBazaarCellDelegate <NSObject>

@optional
// 展开事件的监听
- (void)buyBazaarCellSpreadBtnClick: (BuyBazaarCell *)buyBazaarCell;
// 收起事件的监听
- (void)buyBazaarCellSpreadBtnPackupClick : (BuyBazaarCell *)buyBazaarCell;
@end
@interface BuyBazaarCell : UITableViewCell
@property (nonatomic, strong) BuyModel *model;
/**代理属性*/
@property (nonatomic, weak) id<BuyBazaarCellDelegate> delagete;
@end
