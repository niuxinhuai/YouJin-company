//
//  UserPageHeaderView.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MinePageItem.h"

@interface UserPageHeaderView : UIView

@property (nonatomic, retain) UIImageView *backgroundImageView;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) UIVisualEffectView *blurView;


@property (nonatomic, retain) MinePageItem *userInfo;



+ (instancetype)create;


- (void)updateUserInfo:(MinePageItem *)model;

@end
