//
//  ActivityView.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/2.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlatformDetailsModel;
@interface ActivityView : UIView
@property (nonatomic ,strong)UILabel *newsLabel;//新手活动
@property (nonatomic ,strong)UILabel *websiteAddressLabel;//官网网址
@property (nonatomic, strong)UIButton *informationButton;
@property (nonatomic ,strong)UIButton *newsButton;//新手活动的button
@property (nonatomic ,strong)UIButton *websiteButton;//官网的button
@property (nonatomic ,strong)UIButton *terraceAppButton;//一键下载的button
@property (nonatomic ,strong)UIView *financingSituationView;//融资情况的view
@property (nonatomic, strong)PlatformDetailsModel *item;
@end
