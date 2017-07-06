//
//  SwipeSubControllerCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "SwipeSubControllerCell.h"

@implementation SwipeSubControllerCell


- (void)addView:(UIView *)view {
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [self layoutIfNeeded];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.viewController.view removeFromSuperview];
    [self.viewController removeFromParentViewController];
    [self.viewController didMoveToParentViewController:nil];
    self.viewController = nil;
}

@end
