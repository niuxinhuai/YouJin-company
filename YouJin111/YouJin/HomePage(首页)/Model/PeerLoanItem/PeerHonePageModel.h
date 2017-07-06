//
//  PeerHonePageModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/30.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeerHonePageModel : NSObject

/**平台编号*/
@property (nonatomic, copy) NSString *ptid;
/**logoUrl*/
@property (nonatomic, copy) NSString *logo;
/**省编号*/
@property (nonatomic, copy) NSString *province;
/**市编号*/
@property (nonatomic, copy) NSString *city;
/**省名称*/
@property (nonatomic, copy) NSString *sheng;
/**市名称*/
@property (nonatomic, copy) NSString *shi;
/**平台名称*/
@property (nonatomic, copy) NSString *name;
/**评分*/
@property (nonatomic, copy) NSString *score;
/**最低利率*/
@property (nonatomic, copy) NSString *apr_min;
/**最高利率*/
@property (nonatomic, copy) NSString *apr_max;
/**业务模式*/
@property (nonatomic, copy) NSString *bus_model;
/**背景*/
@property (nonatomic, strong) NSArray *bg_array;
/**是否有存管*/
@property (nonatomic, copy) NSString *cgid;
/**新手活动*/
@property (nonatomic, copy) NSString *reg_url;
/**活动*/
@property (nonatomic, strong) NSArray *huodong;

@end
