//
//  BOOnePictureView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/14.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOOnePictureView.h"
#import "BODynamicItem.h"
@interface BOOnePictureView ()

@end
@implementation BOOnePictureView

+ (instancetype)viewForXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}

- (void)setItem:(BODynamicItem *)item {
    
}
@end
