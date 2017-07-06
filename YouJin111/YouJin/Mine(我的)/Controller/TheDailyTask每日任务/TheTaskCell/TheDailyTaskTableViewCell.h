//
//  TheDailyTaskTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DailyTaskModel;
@interface TheDailyTaskTableViewCell : UITableViewCell
@property (nonatomic ,strong)UIView *leftView;//左边的两个色块圆角view
@property (nonatomic ,strong)UIImageView *logeImageView;//左边的的logo
@property (nonatomic ,strong)UILabel *sevenOnLabel;//邀请好友
@property (nonatomic,strong) UILabel *awardLabel;//奖励:  9000
@property (nonatomic ,strong)UIButton *goToBtn;//去签到
@property (nonatomic ,strong)UILabel *fiveLabel;//1/5
@property (nonatomic ,strong)UILabel *oneLabel;//分享任务Label 3/5
@property (nonatomic ,strong)UIButton *oneButton;//分享任务Button 3/5
@property (nonatomic ,strong)UILabel *lastLabel;//更多每日任务，请戳这里～
@property (nonatomic ,strong)DailyTaskModel *item;
@end
