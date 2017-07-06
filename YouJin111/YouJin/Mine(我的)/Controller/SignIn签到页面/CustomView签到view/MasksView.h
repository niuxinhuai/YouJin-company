//
//  MasksView.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SignInsModel;
@interface MasksView : UIView
@property (nonatomic ,strong)UIImageView *aFewDaysImage;//签到规则的图片
@property (nonatomic ,strong)UIButton *crossBtn;//叉号的按钮
@property (nonatomic ,strong)UIButton *theRulesBtn;//签到规则的按钮
@property (nonatomic ,strong)UILabel *tWoLabel;
//@property (nonatomic ,strong)UILabel *tWosLabel;//签到两天
@property (nonatomic ,strong)NSMutableArray *fourArr;//存放未来四天时间的数组
@property (nonatomic ,strong)NSMutableArray *timeArr;//存放昨天明天和未来四天的数组
@property (nonatomic ,copy)NSString *ubiNumberStr;//ubi第一天的数量
@property (nonatomic ,copy)NSString *threeStr;//第三天的ubi
@property (nonatomic ,copy)NSString *fourStr;//第四天的ubi
@property (nonatomic ,copy)NSString *fiveStr;//第五天的ubi
@property (nonatomic ,copy)NSString *sixStr;//第六天的ubi
@property (nonatomic ,strong)SignInsModel *item;
@end
