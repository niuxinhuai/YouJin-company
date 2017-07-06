//
//  LendRefundRateView.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LendMoneyDetailModel;
@interface LendRefundRateView : UIView
/**每月的还款数label*/
@property (nonatomic, weak) UILabel *refundNumLabel;
@property (nonatomic, strong) LendMoneyDetailModel *item;
@end
