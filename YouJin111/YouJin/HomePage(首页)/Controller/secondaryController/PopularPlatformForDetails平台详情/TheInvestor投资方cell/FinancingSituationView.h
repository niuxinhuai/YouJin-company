//
//  FinancingSituationView.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RongZiModel;
@interface FinancingSituationView : UIView
@property (nonatomic ,strong)UILabel *timesLabel;//时间
@property (nonatomic ,strong)UILabel *anAngelroundLabel;//天使轮
@property (nonatomic ,strong)UILabel *moreMoneyLabel;//数百万人民币
@property (nonatomic ,strong)UIButton *investorButton;//投资方
@property (nonatomic ,strong)RongZiModel *item;
@end
