//
//  SmilingFaceView.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SmilingFaceView : UIView
@property (nonatomic ,assign)CGSize size;
@property (nonatomic ,strong)NSMutableArray *operatingArr;//运营arr
@property (nonatomic ,strong)NSMutableArray *riskControlArr;//风控arr
@property (nonatomic ,strong)NSMutableArray *serviceArr;//服务arr
@property (nonatomic ,strong)NSMutableArray *transparentArr;//透明arr
@property (nonatomic ,strong)NSMutableArray *chooseArr;//圆角button的arr
@property (nonatomic ,assign)BOOL buttonone;
@property (nonatomic ,assign)BOOL buttontwo;
@property (nonatomic ,assign)BOOL buttonthree;
@property (nonatomic ,assign)int xiaolianone;
@property (nonatomic ,assign)int xiaoliantwo;
@property (nonatomic ,assign)int xiaolianthree;
@property (nonatomic ,assign)int xiaolianfour;


- (void)updateTitles:(NSArray *)titles;


@end
