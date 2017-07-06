//
//  SelfDataItem.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelfDataItem : NSObject

/**用户编号*/
@property (nonatomic, copy) NSString *uid;
/**用户头像*/
@property (nonatomic, copy) NSString *head_image;
/**用户昵称*/
@property (nonatomic, copy) NSString *uname;
/**0/男  1/女*/
@property (nonatomic, copy) NSString *sex;
/**投资者类型*/
@property (nonatomic, copy) NSString *type;
/**地址*/
@property (nonatomic, copy) NSString *address;
/**签名*/
@property (nonatomic, copy) NSString *flag;

@property (nonatomic, strong) UIImage *headImage;

@end
