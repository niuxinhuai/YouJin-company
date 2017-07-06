//
//  BaseSwipeViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseSwipeSubViewController.h"

typedef enum{
    kSwipeTableViewByContentOffset,
    kSwipeTableViewByHeadView,
}SwipeTableViewType;

@interface BaseSwipeViewController : BaseViewController


@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIView *headBarView;

@property (nonatomic, retain) UICollectionViewFlowLayout *layout;
@property (nonatomic, assign) NSInteger subControllerCount;
@property (nonatomic, retain) NSMutableDictionary<NSString *,BaseSwipeSubViewController *> *cachedViewControllers;
@property (nonatomic, assign) CGFloat headerInset;
@property (nonatomic, assign) CGFloat barInset;
@property (nonatomic, assign) CGFloat baseInset;
@property (nonatomic, assign) BOOL isNeedBaseInset;

@property (nonatomic, retain) NSIndexPath *lastIndexPath;
@property (nonatomic, retain) NSIndexPath *currentIndexPath;
@property (nonatomic, retain) BaseSwipeSubViewController *lastVC;
@property (nonatomic, retain) BaseSwipeSubViewController *currentVC;
@property (nonatomic, assign) SwipeTableViewType type;

- (BaseSwipeSubViewController *)viewControllerAtIndex:(NSInteger)index;
- (BaseSwipeSubViewController *)generateViewControllerAtIndex:(NSInteger)index;
- (void)handleBaseSwipeSubViewControllerContentOffset:(CGPoint)contentOffset;
- (void)superHandleWhenCollectionScroll:(UIScrollView *)scrollView;
- (void)handleBottomCollectionViewScrollToIndexPath:(NSIndexPath *)indexPath animation:(BOOL)animation;


@end
