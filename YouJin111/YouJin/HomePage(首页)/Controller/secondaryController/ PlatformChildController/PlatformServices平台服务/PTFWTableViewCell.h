//
//  PTFWTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/25.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PTfwTableviewModel;

@interface PTFWTableViewCell : UITableViewCell
@property (nonatomic ,strong)UIImageView *headImage;//平台logo
@property (nonatomic ,strong)UILabel *naemLabel;//平台名称
@property (nonatomic ,strong)UIImageView *pentagramimage;//五角星
@property (nonatomic ,strong)NSMutableArray *xingxArr;//存放星星的数组
@property (nonatomic ,strong)UILabel *pointZeroLabel;//星星的级别
@property (nonatomic ,strong)UILabel *earningsLabel;//主打产品
@property (nonatomic ,strong)UILabel *installmentLabel;//校园分期
@property (nonatomic ,strong)UILabel *addressLabel;//地址
@property (nonatomic ,strong)UILabel *introduceLabel;//介绍
@property (nonatomic ,strong)PTfwTableviewModel *item;
@end
