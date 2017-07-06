//
//  BOUMoneyRankCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UMoneyUserRankItem;
@interface BOUMoneyRankCell : UITableViewCell
@property (nonatomic, retain) UILabel *rankNumLabel;
@property (nonatomic, retain) UIImageView *rankIcon;
@property (nonatomic, strong) UMoneyUserRankItem *item;
@property (nonatomic, retain) UIView *lineView;
@end
