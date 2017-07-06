//
//  MoreTaskTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreTaskTableViewCell : UITableViewCell
//圆角白色view
@property (nonatomic,strong)UIView *whiteView;
//图片icon
@property (nonatomic,strong) UIImageView *imgeView;
//互惠理财
@property (nonatomic,strong) UILabel *manageMMLabel;
//分割线view
@property (nonatomic,strong) UIView *lineView;
//理财详情介绍
@property (nonatomic,strong) UILabel *detailsLabel;
//奖励
@property (nonatomic,strong) UILabel *awardLabel;
//u盾计划图片
@property (nonatomic,strong) UIImageView *shieldImage;
//审核中图片
@property (nonatomic,strong) UIImageView *auditImage;
//对号图片
@property (nonatomic,strong) UIImageView *checkImage;
@end
