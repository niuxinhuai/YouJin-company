//
//  HomePageView.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/29.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseViewButtonDelegete <NSObject>

@optional
//创建五个button和五个label的代理方法
- (void)buttonBeTouched:(UIButton *)sender;

//理财工具 计算的代理方法
- (void)buttoncalculateBtnClick:(UIButton *)sender;

@end

@interface HomePageView : UIView
@property (nonatomic, strong)UIButton *bankButton;//创建五个button和五个label
@property (nonatomic ,strong)UIButton *commentsBtn;//点评有奖的button点击事件
@property (nonatomic ,strong)UIButton *cignInBtn;//签到的button点击事件
@property (nonatomic ,strong)UIButton *riskBtn;//风险评估的button点击事件
@property (nonatomic ,strong)UIButton *calculateBtn;//理财工具 计算

@property (nonatomic ,strong)UIView *goldView;//有金头条的view


//委托回调接口
@property (nonatomic, weak) id <BaseViewButtonDelegete> delegate;

@end
