//
//  LendMoneyApplyForConditionView.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/14.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LendMoneyDetailModel;
@interface LendMoneyApplyForConditionView : UIView
@property (nonatomic, strong) LendMoneyDetailModel *item;

/**记录当前的y*/
@property (nonatomic, assign) CGFloat currentY;
@end
