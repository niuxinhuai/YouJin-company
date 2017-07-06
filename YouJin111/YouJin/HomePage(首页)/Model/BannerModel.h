//
//  BannerModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/29.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject

/**图片的url*/
@property (nonatomic, copy) NSString *img_url;

/**图片的序列号*/
@property (nonatomic, copy) NSString *psid;

/**点击图片跳转对应得url*/
@property (nonatomic, copy) NSString *url;

/**跳转规则  1:不跳转 2:跳转网址 3:跳转平台*/
@property (nonatomic ,copy)NSString *go_type;

@property (nonatomic ,copy)NSNumber *ctid;
/**
 *  ID
 */
@property(nonatomic,copy) NSString *ID;

@end
