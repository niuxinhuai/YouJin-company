//
//  HotNetFundModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotNetFundModel : NSObject

/**logo*/
@property (nonatomic, copy) NSString *logo;
/**logo*/
@property (nonatomic, copy) NSString *name;
/**logo*/
@property (nonatomic, copy) NSString *today_apr;
/**logo*/
@property (nonatomic, copy) NSString *zaitou;
/**logo*/
@property (nonatomic, copy) NSString *zaitou_count;
/**logo*/
//@property (nonatomic, copy) NSString *new_bad;
/**logo*/
@property (nonatomic, copy) NSString *focus_scale;
/**logo*/
@property (nonatomic, strong) NSArray *tz_data;

@end
