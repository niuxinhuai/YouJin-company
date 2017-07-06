//
//  MineHomePageViewController+Configuration.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MineHomePageViewController+Configuration.h"

@implementation MineHomePageViewController (Configuration)


- (void)configureViews {
    self.backgroundView.alpha = 0;
    self.titleLabel.alpha = 0;
    [self addHeaderView];
    [self addHeaderBar];
    [self.subscribeButton makeCornerBorderWithWidth:1 cornerRadius:self.subscribeButton.height / 2.0 borderColor:[UIColor whiteColor]];
}

- (void)addHeaderView {
    self.headerView = ({
        UserPageHeaderView *view = [[UserPageHeaderView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen screenWidth], 180)];
        [self.view insertSubview:view belowSubview:self.topView];
        view;
    });
}

- (void)addHeaderBar {
    self.headBarView = ({
        UserPageBar *view = [UserPageBar create];
        view.frame = CGRectMake(0, 180, [UIScreen screenWidth], 40);
        [view layoutIfNeeded];
        view.delegate = self;
        [self.view addSubview:view];
        view;
    });
}


#pragma mark - helpMethod

- (void)updateUserMessage {
    self.titleLabel.text = [self isMe] ? @"我的主页" : self.userInfo.uname;
    self.subscribeButton.hidden = [self isMe];
    UserPageHeaderView *headView = (UserPageHeaderView *)self.headerView;
    [headView updateUserInfo:self.userInfo];
    [self updateSubscribeStatus:[self.userInfo.is_friend boolValue]];
}


- (UserPageBar *)getHeadBar {
    return (UserPageBar *)self.headBarView;
}

- (UserPageHeaderView *)getHeadView {
    return (UserPageHeaderView *)self.headerView;
}

- (BOOL)isMe {
    return self.uid == [USERUID intValue];
}

- (void)updateSubscribeStatus:(BOOL)subscribe {
    self.isSubscribe = subscribe;
    if (subscribe) {
        [self.subscribeButton setTitle:@"已关注" forState:UIControlStateNormal];
    }else {
        [self.subscribeButton setTitle:@"+ 关注" forState:UIControlStateNormal];
    }
}


@end
