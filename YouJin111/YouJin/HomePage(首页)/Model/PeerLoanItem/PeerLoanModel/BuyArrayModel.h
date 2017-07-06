//
//  BuyArrayModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuyArrayModel : NSObject
/**平台名称*/
@property (nonatomic, copy) NSString *name;

/**本月存量*/
@property (nonatomic, copy) NSString *tot;

/**上月存量*/
@property (nonatomic, copy) NSString *last_month_tot;
@end
