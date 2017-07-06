//
//  PlatformServiceDetailModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlatformServiceDetailModel : NSObject

@property (nonatomic ,strong) NSString *logo;
@property (nonatomic ,strong) NSString *com_name;
@property (nonatomic ,strong) NSArray *com_img;
@property (nonatomic ,strong) NSString *pro_name;
@property (nonatomic ,strong) NSString *desc;
@property (nonatomic ,strong) NSString *pname;
@property (nonatomic ,strong) NSString *url;
@property (nonatomic ,strong) NSString *other_pro;
@property (nonatomic ,strong) NSString *mobile;
@property (nonatomic ,strong) NSString *example;
@property (nonatomic ,strong) NSString *addr;
@property (nonatomic ,strong) NSString *begin_time;
@property (nonatomic ,strong) NSNumber *score;
@property (nonatomic ,strong) NSNumber *v1;
@property (nonatomic ,strong) NSNumber *v2;
@property (nonatomic ,strong) NSNumber *v3;
@property (nonatomic ,strong) NSNumber *v4;
@property (nonatomic ,strong) NSString *tab;
@property (nonatomic ,strong) NSString *province;
@property (nonatomic ,strong) NSString *city;
@property (nonatomic ,strong) NSString *sheng;
@property (nonatomic ,strong) NSString *shi;
@property (nonatomic ,strong) NSString *svid;

@property (nonatomic, strong) NSNumber *commentCount;

@property (nonatomic, assign) BOOL isNoNeedLoadMore;


- (CGFloat)platformSeviceDetailHeadViewHeightWithOpenCompanyInfo:(BOOL)isOpen;


@end
