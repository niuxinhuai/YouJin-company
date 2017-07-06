//
//  BORowItem.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BORowItem : NSObject
@property (strong, nonatomic) UIImage *image;

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *subTitle;

+ (instancetype)itemWithImage:(UIImage *)image  title:(NSString *)title subTitle: (NSString *)subTitle;

@end
