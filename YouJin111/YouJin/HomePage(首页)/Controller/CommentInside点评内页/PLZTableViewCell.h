//
//  PLZTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HuifuModel;
@interface PLZTableViewCell : UITableViewCell
@property (nonatomic ,strong)UIImageView *headImage;//头像
@property (nonatomic ,strong)UIButton *nameButton;//昵称
@property (nonatomic ,strong)UIImageView *zanImage;//赞的图片
@property (nonatomic ,strong)UILabel *zannumberLabel;//点赞的个数
@property (nonatomic ,strong)UIButton *zanbuttonCk;//点赞的点击事件
@property (nonatomic ,strong)UILabel *detailLabel;//详情
@property (nonatomic ,strong)UILabel *timeLabel;//时间
@property (nonatomic ,strong)HuifuModel *item;
@end
