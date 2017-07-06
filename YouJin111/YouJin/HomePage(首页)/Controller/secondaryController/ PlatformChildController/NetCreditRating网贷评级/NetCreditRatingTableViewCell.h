//
//  NetCreditRatingTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YjRatingModel;
@interface NetCreditRatingTableViewCell : UITableViewCell
//奖牌
@property (weak, nonatomic) IBOutlet UIImageView *medalImage;
//数字排序
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;//平台logo
@property (weak, nonatomic) IBOutlet UILabel *platformRatesLabel;//平台利率
@property (weak, nonatomic) IBOutlet UILabel *PlatformBackgroundLabel;//平台背景
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;//等级
@property (nonatomic ,strong)YjRatingModel *item;

@end
