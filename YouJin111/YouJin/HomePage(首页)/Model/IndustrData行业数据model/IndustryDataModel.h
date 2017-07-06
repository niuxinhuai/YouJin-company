//
//  IndustryDataModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndustryDataModel : NSObject
@property (nonatomic ,copy)NSString *name;//平台名称
@property (nonatomic ,copy)NSString *apr;//综合利率
@property (nonatomic ,copy)NSString *input;//资金净流入
@property (nonatomic ,copy)NSString *tender;//投资人数
@property (nonatomic ,copy)NSString *borrower;//借款人数
@property (nonatomic ,copy)NSString *yesterday_done;//成交额
@property (nonatomic ,copy)NSString *sum_borrow;//总额
@end
