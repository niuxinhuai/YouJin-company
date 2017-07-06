//
//  IncreasesZoneTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/7.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InterestRatesModel;
@interface IncreasesZoneTableViewCell : UITableViewCell
//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
//惠普理财
@property (weak, nonatomic) IBOutlet UILabel *financialsLabel;
//%5
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;
//新手加息
@property (weak, nonatomic) IBOutlet UILabel *aNoviceLabel;
//注册送300
@property (weak, nonatomic) IBOutlet UILabel *registeredsLabel;
@property (nonatomic ,strong)InterestRatesModel *item;
@end
