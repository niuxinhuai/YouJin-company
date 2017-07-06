//
//  FoucsHeadView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "FoucsHeadView.h"

@implementation FoucsHeadView

+ (instancetype)create {
    FoucsHeadView *view = [[NSBundle mainBundle]loadNibNamed:@"FoucsHeadView" owner:nil options:nil].firstObject;
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}
@end
