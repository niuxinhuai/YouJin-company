//
//  MineHomePageModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineHomePageModel : NSObject

/**用户编号*/
@property (nonatomic, copy) NSString *uid;
/**用户头像*/
@property (nonatomic, copy) NSString *head_image;
/**用户昵称*/
@property (nonatomic, copy) NSString *uname;
/**投资者类型*/
@property (nonatomic, copy) NSString *type;
/**U币余额*/
@property (nonatomic, copy) NSNumber *balance;
/**收藏*/
@property (nonatomic, copy) NSString *collection;
/**关注*/
@property (nonatomic, copy) NSString *focus_num;
/**粉丝*/
@property (nonatomic, copy) NSString *fans;
@property (nonatomic, retain) NSNumber *company_vip;
@property (nonatomic, retain) NSNumber *person_vip;

@end
