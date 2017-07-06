//
//  IntroductionPlatformView.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlatformDetailsModel;
@interface IntroductionPlatformView : UIView
@property (nonatomic ,assign)BOOL onAndoff;//全文和收回
@property (nonatomic ,assign)CGFloat lineViewY;//线的Y
@property (nonatomic ,assign)CGFloat detailIntLabelY;//全文按钮的Y
@property (nonatomic ,strong)UILabel *onlineLabel;//2016-08-30上线
@property (nonatomic ,strong)UILabel *detailIntLabel;//平台简介详情
//@property (nonatomic ,assign)CGFloat heights;//平台简介详情文字高度
@property (nonatomic ,strong)UIButton *allButton;//全文按钮
@property (nonatomic ,strong)PlatformDetailsModel *item;
@end
