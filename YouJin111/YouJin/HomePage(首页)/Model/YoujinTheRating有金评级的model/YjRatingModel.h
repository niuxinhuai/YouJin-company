//
//  YjRatingModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/31.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YjRatingModel : NSObject

/**
 log
 */
@property (nonatomic ,copy)NSString *logo;//logo
@property (nonatomic ,copy)NSString *seq;//排名
@property (nonatomic ,copy)NSString *apr_max;//平均利率
@property (nonatomic ,copy)NSString *tab;//平台背景
@property (nonatomic ,copy)NSString *level;//等级
@property (nonatomic ,copy)NSString *time_end;//时间
@end
