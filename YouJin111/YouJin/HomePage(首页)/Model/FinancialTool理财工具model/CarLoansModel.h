//
//  CarLoansModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/11.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarLoansModel : NSObject
@property (nonatomic ,copy)NSString *shoufu_sum;//首期付款总额
@property (nonatomic ,copy)NSString *lixi;//支付利息
@property (nonatomic ,copy)NSString *meiyue;//每月还款额
@property (nonatomic ,copy)NSString *huankuan_sum;//总还款额
@end
