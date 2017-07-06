//
//  EnvelopezoneTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EnvelopeModel;
@interface EnvelopezoneTableViewCell : UITableViewCell
@property (nonatomic ,strong)UILabel *nameLabel;//平台名称
@property (nonatomic ,strong)UILabel *moneyLabel;//红包金额
@property (nonatomic ,strong)UILabel *downLabel;//详情
@property (nonatomic ,strong)EnvelopeModel *item;
@end
