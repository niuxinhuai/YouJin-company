//
//  ScreeScrModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScreeScrModel : NSObject
@property (nonatomic ,copy)NSString *img_url;//图片地址
@property (nonatomic ,copy)NSString *url;//跳转地址
@property (nonatomic ,copy)NSString *psid;//位置编号
@property (nonatomic ,copy)NSString *go_type;//跳转规则  1:不跳转 2:跳转网址 3:跳转平台
@end
