//
//  BOLabelHeight.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOLabelHeight.h"

@implementation BOLabelHeight

+ (CGFloat)LabelWidth: (NSString *)string dict:(NSDictionary *)dict {
    return [string sizeWithAttributes:dict].width;
}

+ (CGFloat)LabelHeight: (NSString *)string dict:(NSDictionary *)dict {
    return [string sizeWithAttributes:dict].height;
}
/**返回整个label的高度*/
+ (CGFloat)LabelHeight: (NSString *)string lableWidth:(CGFloat)labelWidth dict:(NSDictionary *)dict {
    return [string boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
}
@end
