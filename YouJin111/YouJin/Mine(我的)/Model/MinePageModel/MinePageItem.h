//
//  MinePageItem.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/24.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MinePageItem : NSObject

/**头像*/
@property (nonatomic, copy) NSString *head_image;
/**用户昵称*/
@property (nonatomic, copy) NSString *uname;
/**个人标签*/
@property (nonatomic, copy) NSString *tab;
/**个人签名*/
@property (nonatomic, copy) NSString *flag;
/**关注数*/
@property (nonatomic, copy) NSString *counts;
/**粉丝数*/
@property (nonatomic, copy) NSString *fans;

@property (nonatomic, strong) NSNumber *is_friend;
@property (nonatomic, retain) NSNumber *company_vip;
@property (nonatomic, retain) NSNumber *person_vip;

@end
