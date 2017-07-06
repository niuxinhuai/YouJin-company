//
//  VersionModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionModel : NSObject
@property (nonatomic ,copy)NSString *version;//版本号
@property (nonatomic ,copy)NSString *message;//版本信息
@property (nonatomic ,copy)NSString *is_force;//是否强制更新
@property (nonatomic ,copy)NSString *url;//下载地址
@end
