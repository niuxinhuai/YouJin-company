//
//  LoginMessageModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginMessageModel : NSObject
/**用户uid*/
@property (nonatomic, copy) NSString *uid;
/**用户昵称*/
@property (nonatomic, copy) NSString *un;
/**用户手机号*/
@property (nonatomic, copy) NSString *mobile;
/**用户sid*/
@property (nonatomic, copy) NSString *sid;
/**用户注册时间*/
@property (nonatomic, copy) NSString *regtime;
@end
