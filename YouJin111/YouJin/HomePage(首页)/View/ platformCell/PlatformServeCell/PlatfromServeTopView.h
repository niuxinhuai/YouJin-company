//
//  PlatfromServeTopView.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/3.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlatformServeDetailModel;
@interface PlatfromServeTopView : UIView
@property (nonatomic, strong)UIImageView *starImage;//评级的星星
@property (nonatomic ,strong)SDCycleScrollView *topScrollView;//顶部banner图
@property (nonatomic ,strong)NSMutableArray *bannersArr;//得到banner的数据结果数组
@property (nonatomic, strong) PlatformServeDetailModel *item;
@end
