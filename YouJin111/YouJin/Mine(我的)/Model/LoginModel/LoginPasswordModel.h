//
//  LoginPasswordModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginPasswordModel : NSObject
/**用户用来登录的加密字*/
@property (nonatomic, copy) NSString *cd;
/**用户的密码加密字*/
@property (nonatomic, copy) NSString *salt;
/**用户会话ID*/
@property (nonatomic, copy) NSString *sid;

@end
