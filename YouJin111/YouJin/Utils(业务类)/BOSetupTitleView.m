//
//  BOSetupTitleView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/3.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOSetupTitleView.h"

@implementation BOSetupTitleView

+(BOSetupTitleView *)setupTitleViewTitle:(NSString *)title{
    // 创建包裹View
    BOSetupTitleView *contentView = [[BOSetupTitleView alloc] initWithFrame:CGRectMake(0, 0, 150 * BOScreenW / BOPictureW, 44)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 150 * BOScreenW / BOPictureW, 24)];
    [label setText:title];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:19]];
    [label setTextColor:[UIColor whiteColor]];
    label.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:label];
    return contentView;
}
@end
