//
//  CarLoanRankCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/23.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarLoanRankModel.h"
@class CarLoanRankModel;
@interface CarLoanRankCell : UITableViewCell
@property (nonatomic, weak) UILabel *ratelabel;
@property (nonatomic, weak) UIView *indicatorView;
@property (nonatomic, strong) CarLoanRankModel*item;
@end

