//
//  MineHomePageViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseSwipeViewController.h"
#import "MinePageItem.h"

@interface MineHomePageViewController : BaseSwipeViewController

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *subscribeButton;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;


@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, retain) AFHTTPSessionManager *manager;
@property (nonatomic, retain) MinePageItem *userInfo;
@property (nonatomic, assign) BOOL isSubscribe;


+ (instancetype)create;


@end
