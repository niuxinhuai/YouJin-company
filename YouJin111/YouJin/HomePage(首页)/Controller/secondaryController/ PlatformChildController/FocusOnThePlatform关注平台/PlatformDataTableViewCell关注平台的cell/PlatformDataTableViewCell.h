//
//  PlatformDataTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConsumptionFq;
@interface PlatformDataTableViewCell : UITableViewCell
@property (nonatomic ,strong)UIImageView *headImage;//logo图片
@property (nonatomic ,strong)UILabel *naemLabel;//平台名字
@property (nonatomic ,strong)UIImageView *pentagramimage;//五角星
@property (nonatomic ,strong)UILabel *pointZeroLabel;//星星级别
@property (nonatomic ,strong)UILabel *installmentLabel;//36人关注
@property (nonatomic ,strong)NSMutableArray *xingxArr;//存放五角星的数组
@property (nonatomic ,strong)UILabel *changeLabel;//变额
@property (nonatomic ,strong)UILabel *dynamicLabel;//动态

@property (nonatomic ,strong)ConsumptionFq *item;
@end
