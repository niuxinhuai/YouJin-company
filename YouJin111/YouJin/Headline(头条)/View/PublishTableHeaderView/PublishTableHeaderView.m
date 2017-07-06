//
//  PublishTableHeaderView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PublishTableHeaderView.h"

@implementation PublishTableHeaderView

+ (instancetype)create{
    PublishTableHeaderView *view = [[NSBundle mainBundle]loadNibNamed:@"PublishTableHeaderView" owner:nil options:nil].firstObject;
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (IBAction)plateSelectAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(publishTableHeaderViewSelectPlate:)]) {
        [self.delegate publishTableHeaderViewSelectPlate:self];
    }
}

@end
