//
//  SecuritySystemView.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlatformDetailsModel;
@interface SecuritySystemView : UIView
@property (nonatomic ,strong)UIButton *familyTreeButton;//查看股权结构的按钮
@property (nonatomic ,strong)UILabel *capitalMeasuresLabel;//资金措施
@property (nonatomic ,strong)UILabel *securityModelLabel;//保障模式
@property (nonatomic ,strong)UILabel *businessControlLabel;//业务风控
@property (nonatomic ,strong)NSMutableArray *typeArr;//业务风控Arr
@property (nonatomic ,strong)UILabel *companyNameLabel;//公司名称
@property (nonatomic ,strong)UILabel *businessLicenseLabel;//营业执照
@property (nonatomic ,strong)UILabel *registeredCapitalLabel;//注册资本
@property (nonatomic ,strong)UILabel *contributedCapitalLabel;//实交资本
@property (nonatomic ,strong)UILabel *legalRepresentativeLabel;//法人代表
@property (nonatomic ,strong)UILabel *actualLabel;//疑似实际股权控制人
@property (nonatomic ,strong)UILabel *icprecordLabel;//ICP备案
@property (nonatomic ,strong)UILabel *icpCertificateLabel;//ICP证书
@property (nonatomic ,strong)UILabel *therecordLabel;//公安备案
@property (nonatomic ,strong)PlatformDetailsModel *item;
@end
