//
//  LendMoneyDeadlineLoanView.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/14.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LendMoneyDetailModel;
@class BOLcationButton;
@interface LendMoneyDeadlineLoanView : UIView
/**引用显示借款金额的button*/
@property (nonatomic, strong)BOLcationButton *loanMoneyBtn;

@property (nonatomic ,strong)UIButton *jiekuanButton;//借钱的button
@property (nonatomic ,strong)UIButton *yueButton;//分期期限的按钮

@property (nonatomic, strong) LendMoneyDetailModel *item;
@end
