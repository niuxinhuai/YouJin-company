//
//  MineInfomationViewController+Configures.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/8.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MineInfomationViewController.h"
#import "BOSelfDataCell.h"
#import "UIColor+Scale.h"
#import "MineInfomationViewController+LogicalFlow.h"

@interface MineInfomationViewController (Configures)


- (void)configureViews;
- (void)updateUserMessageItem:(SelfDataItem *)item;
- (void)updateFlagCountLabelText:(NSString *)text;
- (void)openImagePickerControllerWithType:(UIImagePickerControllerSourceType)type;
- (void)configureBar;

- (void)complishAction:(UIButton *)button;

@end
