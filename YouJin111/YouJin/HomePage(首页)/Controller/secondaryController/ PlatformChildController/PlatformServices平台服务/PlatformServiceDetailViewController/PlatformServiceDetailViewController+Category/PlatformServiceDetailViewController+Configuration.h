//
//  PlatformServiceDetailViewController+Configuration.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformServiceDetailViewController.h"
#import "PlatformServiceDetailViewController+LogicalFlow.h"
#import "PlatformServiceDetailViewController+Delegate.h"
#import "UserCommentCell.h"
#import "PlateformServiceDetailSectionHeadView.h"

@interface PlatformServiceDetailViewController (Configuration)

- (void)configureViews;
- (void)pushToLoginViewController;
- (void)pasteText:(NSString *)text;


@end
