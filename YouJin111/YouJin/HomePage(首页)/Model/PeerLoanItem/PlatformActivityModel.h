//
//  PlatformActivityModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/30.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlatformActivityModel : NSObject

/**图片地址*/
@property (nonatomic, copy) NSString *img_url;

/**文字介绍*/
@property (nonatomic, copy) NSString *desc;

/**点击跳转地址*/
@property (nonatomic, copy) NSString *url;
@end
