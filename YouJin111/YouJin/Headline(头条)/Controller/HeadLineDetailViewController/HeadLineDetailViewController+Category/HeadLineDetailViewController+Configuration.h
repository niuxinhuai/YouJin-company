//
//  HeadLineDetailViewController+Configuration.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/19.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineDetailViewController.h"
#import "TopContentDetailCell.h"
#import "PublishCommentModel.h"
#import "HeadLineDetailViewController+LogicalFlow.h"
#import "ShareManager.h"

@interface HeadLineDetailViewController (Configuration)


- (void)configureViews;
- (void)tableViewEndRefreshing;
- (void)bottomRefreshing;
- (void)updateInputViewPlaceholder:(NSString *)placeholder;
- (void)updateInputViewPlaceholderWithName:(NSString *)name;
- (void)pushToLoginViewController;

@end
