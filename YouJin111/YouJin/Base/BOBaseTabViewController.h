//
//  XMGBaseTabViewController.h
//  BuDeJie19
//
//  Created by xmg5 on 16/10/23.
//  Copyright © 2016年 Seemygo. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 1.扩展性 2.易用性
 */
@interface BOBaseTabViewController : UIViewController
@property (nonatomic, assign) CGFloat scrollViewY;

/**
 子类设置titleView的高度
 */
@property (nonatomic, assign) CGFloat titleViewH;

/**
 titleView的背景色
 */
@property (nonatomic, strong) UIColor *titleBackColor;

@property (nonatomic, strong) UIScrollView *topScrollView;

@property (nonatomic, weak) UICollectionView *bottomCollectionView;
@end
