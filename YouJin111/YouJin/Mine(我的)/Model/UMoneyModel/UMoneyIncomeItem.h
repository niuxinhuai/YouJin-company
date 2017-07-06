//
//  UMoneyIncomeItem.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMoneyIncomeItem : NSObject

/**变动编号*/
@property (nonatomic, copy) NSNumber *id;

/**变动描述*/
@property (nonatomic, copy) NSString *desc;

/**变动时间*/
@property (nonatomic, copy) NSString *time_h;

/**变动金额*/
@property (nonatomic, copy) NSNumber *slice;

@property (nonatomic, copy) NSNumber *trid;

@property (nonatomic, copy) NSString *ym;

- (NSString *)getIconImageUrlString;


@end
