//
//  UMoneyRecordItem.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMoneyRecordItem : NSObject
/**记录编号*/
@property (nonatomic, copy) NSString *qsid;

/**平台名称*/
@property (nonatomic, copy) NSString *name;

/**状态名称*/
@property (nonatomic, copy) NSNumber *status;

/**提交时间*/
@property (nonatomic, copy) NSString *time_h;

/**奖励U币金额*/
@property (nonatomic, copy) NSString *slice;

/**描述*/
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *ym;


- (NSString *)getIconImageUrlString;



@end
