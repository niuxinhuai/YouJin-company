//
//  BOLabelHeight.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BOLabelHeight : NSObject

/**返回单行文字的宽度*/
+ (CGFloat)LabelWidth: (NSString *)string dict:(NSDictionary *)dict;
/**返回单行文字的高度*/
+ (CGFloat)LabelHeight: (NSString *)string dict:(NSDictionary *)dict;
/**返回整个label的高度*/
+ (CGFloat)LabelHeight: (NSString *)string lableWidth:(CGFloat)labelWidth dict:(NSDictionary *)dict;
@end
