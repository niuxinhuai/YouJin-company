//
//  RightDayDataTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IndustryDataModel;
@interface RightDayDataTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *interestLab;//综合利率
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;//资金净流入
@property (weak, nonatomic) IBOutlet UILabel *peopleLab;//投资人数
@property (weak, nonatomic) IBOutlet UILabel *borrowingLab;//借款人数
@property (weak, nonatomic) IBOutlet UILabel *clinchLab;//成交额
@property (weak, nonatomic) IBOutlet UILabel *totalLab;//累计总额
@property (nonatomic ,strong)IndustryDataModel *item;
@end
