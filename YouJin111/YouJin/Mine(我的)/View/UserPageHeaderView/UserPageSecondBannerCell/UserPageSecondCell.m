//
//  UserPageSecondCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "UserPageSecondCell.h"

@implementation UserPageSecondCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - publicMethod

- (void)updateUserInfo:(MinePageItem *)model {
    self.userInfo = model;
    self.detailLabel.text = model.flag.length > 0 ? model.flag : @"尚未设置个性签名";
}



@end
