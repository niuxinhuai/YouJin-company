//
//  BORowItem.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BORowItem.h"

@implementation BORowItem
+ (instancetype)itemWithImage:(UIImage *)image  title:(NSString *)title subTitle: (NSString *)subTitle {
    
    BORowItem *rowItem =  [[self alloc] init];
    rowItem.image  = image;
    rowItem.title = title;
    rowItem.subTitle = subTitle;
    return rowItem;
}

@end
