//
//  MonetaryFundTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MonetaryFundModel;
@interface MonetaryFundTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *colorsView;//前三个cell的小色块
@property (weak, nonatomic) IBOutlet UILabel *upFundLabel;//产品平台
@property (weak, nonatomic) IBOutlet UILabel *downFundLabel;//对接基金
@property (weak, nonatomic) IBOutlet UILabel *funsLabel;//基金名称
@property (weak, nonatomic) IBOutlet UILabel *anAnnualLabel;//当日年化
@property (weak, nonatomic) IBOutlet UILabel *ofIncomeLabel;//万份收益
@property (nonatomic ,strong)MonetaryFundModel *item;


@property (nonatomic, retain) NSIndexPath *indexPath;


- (void)updateIndexPath:(NSIndexPath *)indexPath;




@end
