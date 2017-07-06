//
//  nameView.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlatformDetailsModel;
@interface nameView : UIView
@property (nonatomic ,strong)UILabel *earningsNameLabel;//年化收益
@property (nonatomic ,assign)CGFloat bigImageY;//大图片的Y
@property (nonatomic ,strong)UIImageView *bigImage;//大的图片log
@property (nonatomic ,strong)UIImageView *logoImage;//中间的图片logo
@property (nonatomic ,strong)UILabel *shopNameLabel;//店名
@property (nonatomic ,strong)UILabel *gradeLabel;//评分
@property (nonatomic, strong)UIImageView *starImage;//评级的星星
@property (nonatomic ,strong)NSMutableArray *xingxingArr;//存放星星的Arr
@property (nonatomic ,strong)UILabel *addressLabel;//地址
//@property (nonatomic, strong)NSMutableArray *operationArray;//运营透明
@property (nonatomic, strong)UILabel *operationLabel;//运营 风控 服务 透明
@property (nonatomic ,strong)UILabel *percentageLabel;//年化收益
@property (nonatomic ,strong)UILabel *financialLabel;//供应链金融
@property (nonatomic ,strong)NSMutableArray *typeArr;//业务类型
@property (nonatomic ,strong)UISegmentedControl *segmentedControl;//上市国资
//@property (nonatomic ,strong)NSMutableArray *segmentedArray;//业务类型Arr
@property (nonatomic ,strong)NSMutableArray *backgroundArr;//背景arr
@property (nonatomic ,strong)UILabel *tabLabel;//标签
@property (nonatomic ,strong)UILabel *depositLabel;//农业银行存管
@property (nonatomic ,strong)UILabel *integralLabel;//积分隆重上线
@property (nonatomic ,strong)PlatformDetailsModel *item;

@property (nonatomic ,assign)CGFloat earningsNameLabelY;//segmentedControl的Y坐标
@property (nonatomic ,strong)UIBlurEffect *blurEffect;//毛玻璃
@property (nonatomic ,strong)UIVisualEffectView *effectView;//毛玻璃
@property (nonatomic ,strong)SDCycleScrollView *topScrollView;//顶部banner图
@property (nonatomic ,strong)NSMutableArray *bannersArr;//得到banner的数据结果数组

@property (nonatomic ,strong)UILabel *businessLabel;//业务类型

@property (nonatomic ,copy)NSString *xffqStr;
@property (nonatomic ,copy)NSString *xffqTypeString;
@property (nonatomic ,assign)CGFloat operationLabelY;
@property (nonatomic ,assign)CGSize sizessss;
@end
