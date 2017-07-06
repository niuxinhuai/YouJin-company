//
//  DayDataTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IndustryDataModel;
@interface DayDataTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;//平台名称
@property (nonatomic ,strong)IndustryDataModel *items;


@end
