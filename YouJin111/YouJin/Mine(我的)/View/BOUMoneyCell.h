//
//  BOUMoneyCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UMoneyIncomeItem;
@interface BOUMoneyCell : UITableViewCell
@property (nonatomic, weak) UIImageView *iconImageV;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *subTitleLabel;
@property (nonatomic, weak) UILabel *NumLabel;
@property (nonatomic, strong) UMoneyIncomeItem *item;


- (void)updateItems:(UMoneyIncomeItem *)item add:(BOOL)isAdd;

@end
