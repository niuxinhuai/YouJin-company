//
//  TerraceTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConsumptionFq;
@interface TerraceTableViewCell : UITableViewCell
@property (nonatomic ,strong)UIImageView *headImage;//logo图片
@property (nonatomic ,strong)UILabel *naemLabel;//平台名字
@property (nonatomic ,strong)UIImageView *pentagramimage;//五角星
@property (nonatomic ,strong)UILabel *pointZeroLabel;//星星级别
//@property (nonatomic ,strong)UILabel *earningsLabel;//年化收益
//@property (nonatomic ,strong)UILabel *percentageLabel;//年化收益
@property (nonatomic ,strong)UILabel *installmentLabel;//校园分期
@property (nonatomic ,strong)UILabel *addressLabel;//地址
@property (nonatomic ,strong)UILabel *introduceLabel;//介绍
@property (nonatomic ,strong)ConsumptionFq *item;
@property (nonatomic ,strong)NSMutableArray *xingxArr;//存放五角星的数组
@end
