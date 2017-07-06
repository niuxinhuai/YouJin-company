//
//  HeadLineMainViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseSwipeViewController.h"

@interface HeadLineMainViewController : BaseSwipeViewController

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *topBackgroundView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchBarWidth;

@property (nonatomic, retain) NSArray *bannerDatas;
@property (nonatomic, retain, readonly) NSArray *barTitles;
@property (nonatomic, retain) AFHTTPSessionManager *manager;

@property (nonatomic, assign) BOOL isCanPublish;



@end
