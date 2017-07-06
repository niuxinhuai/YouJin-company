//
//  MiddleModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MiddleModel : NSObject

/**文字描述*/
@property (nonatomic, copy) NSString *desc;

/**跳转链接*/
@property (nonatomic, copy) NSString *url;
/**图片地址*/
@property (nonatomic, copy) NSString *img_url;
@end
