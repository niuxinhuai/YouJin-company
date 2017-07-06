//
//  InstallmentModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/4.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstallmentModel : NSObject
@property (nonatomic ,copy)NSString *meiyue;//每月应还
@property (nonatomic ,copy)NSString *lixi;//支付利息
@property (nonatomic ,copy)NSString *sum;//总共支付
@end
