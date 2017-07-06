//
//  TheInvestorTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/3.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RongZiModel;
@interface TheInvestorTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *bankLabel;//银行
@property (nonatomic ,strong)RongZiModel *item;
@end
