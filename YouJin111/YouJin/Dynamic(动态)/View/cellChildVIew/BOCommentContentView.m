//
//  BOCommentContentView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/14.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOCommentContentView.h"
#import "BODynamicItem.h"
@implementation BOCommentContentView

+ (instancetype)viewForXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}
- (void)setItem:(BODynamicItem *)item {
    
}
@end
