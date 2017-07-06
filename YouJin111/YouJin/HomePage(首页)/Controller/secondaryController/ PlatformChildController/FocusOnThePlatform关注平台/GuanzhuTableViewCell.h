//
//  GuanzhuTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/6/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GuanzhuLIebiaoModel;
@interface GuanzhuTableViewCell : UITableViewCell
@property (nonatomic ,strong)UIImageView *headImage;//logo图片
@property (nonatomic ,strong)UILabel *naemLabel;//平台名字
@property (nonatomic ,strong)UIImageView *pentagramimage;//五角星
@property (nonatomic ,strong)UILabel *pointZeroLabel;//星星级别
@property (nonatomic ,strong)UILabel *installmentLabel;//36人关注
@property (nonatomic ,strong)NSMutableArray *xingxArr;//存放五角星的数组
@property (nonatomic ,strong)UIButton *heartButton;//绿心
@property (nonatomic ,strong)GuanzhuLIebiaoModel *item;
@end
