//
//  MonetaryFundModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/11.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MonetaryFundModel : NSObject
//货币基金
@property (nonatomic ,copy)NSString *name;//产品名称
@property (nonatomic ,copy)NSString *duijie_pt;//对接基金
@property (nonatomic ,copy)NSString *week_lixi;//七日年化
@property (nonatomic ,copy)NSString *wf_lixi;//万份收益
@property (nonatomic ,copy)NSString *company;//公司名称
@property (nonatomic ,copy)NSString *logo;//logo
@end
