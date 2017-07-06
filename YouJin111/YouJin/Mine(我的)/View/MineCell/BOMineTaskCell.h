//
//  BOMineTaskCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UMoneyRecordItem;
@interface BOMineTaskCell : UITableViewCell
@property (nonatomic, weak) UIImageView *iconImageV;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *subTitleLabel;
@property (nonatomic, weak) UILabel *rightLabel;
@property (nonatomic, weak) UILabel *NumLabel;
@property (nonatomic, strong) UMoneyRecordItem *item;


- (void)updateItems:(UMoneyRecordItem *)item;

@end
