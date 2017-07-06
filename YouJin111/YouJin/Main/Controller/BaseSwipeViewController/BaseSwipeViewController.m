//
//  BaseSwipeViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseSwipeViewController.h"
#import "BaseSwipeViewController+Configuration.h"
#import "BaseSwipeViewController+Delegate.h"


@interface BaseSwipeViewController ()

@end

@implementation BaseSwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isNeedBaseInset = YES;
    [self configureSuperViews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BaseSwipeSubViewController *)viewControllerAtIndex:(NSInteger)index {
    NSString *key = [NSString stringWithFormat:@"viewContrller%@", @(index)];
    BaseSwipeSubViewController *viewController = nil;
    if (![self.cachedViewControllers objectForKey:key]) {
        viewController = [self generateViewControllerAtIndex:index];
        viewController.delegate = self;
        [self.cachedViewControllers setObject:viewController forKey:key];
    } else {
        viewController = [self.cachedViewControllers objectForKey:key];
    }
    if (![self.childViewControllers containsObject:viewController])
        [self addChildViewController:viewController];
    return viewController;
}


- (BaseSwipeSubViewController *)generateViewControllerAtIndex:(NSInteger)index {
    return nil;
}


#pragma mark - reget && reset

- (NSMutableDictionary *)cachedViewControllers {
    if (!_cachedViewControllers) {
        _cachedViewControllers = [NSMutableDictionary dictionary];
    }
    return _cachedViewControllers;
}

- (CGFloat)baseInset {
    return self.isNeedBaseInset ? 64 : 0;;
}

- (CGFloat)headerInset {
    return self.headerView.height;
}

- (CGFloat)barInset {
    return self.headBarView.height;
}


#pragma mark - publicMethod

- (void)handleBaseSwipeSubViewControllerContentOffset:(CGPoint)contentOffset {
    CGFloat newOffsetY      = contentOffset.y;
    if (self.type == kSwipeTableViewByHeadView) newOffsetY -= self.headerInset;
    CGFloat topMarginOffset = self.barInset + self.baseInset;
    CGFloat topMaxOffset = self.barInset + self.headerInset;
    if (newOffsetY < - topMarginOffset) {
        self.headBarView.bottom = (newOffsetY > -topMaxOffset) ? -newOffsetY : topMaxOffset;
        self.headerView.bottom = self.headBarView.top;
    }else {
        self.headBarView.bottom  = topMarginOffset;
        self.headerView.bottom = fmax(- (newOffsetY + self.barInset), 0);
    }
}

- (void)superHandleWhenCollectionScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat currentItemIndex = offsetX/scrollView.width + 0.5;
    if (currentItemIndex != self.currentIndexPath.row) {
        [self transitionCurrentViewControllerWithIndexPath:[NSIndexPath indexPathForItem:currentItemIndex inSection:0]];
    }
}

- (void)handleBottomCollectionViewScrollToIndexPath:(NSIndexPath *)indexPath animation:(BOOL)animation {
//    if (!animation) {
//        [self transitionCurrentViewControllerWithIndexPath:indexPath];
//    }
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animation];
}


- (void)transitionCurrentViewControllerWithIndexPath:(NSIndexPath *)indexPath {
    self.lastIndexPath = self.currentIndexPath;
    self.currentIndexPath = indexPath;
    self.lastVC = self.currentVC;
    self.currentVC = [self viewControllerAtIndex:indexPath.row];
    [self.currentVC.view layoutIfNeeded];
    [self updateContentOffsetWithCurrentScrollView:self.lastVC.tableView prepareScrollView:self.currentVC.tableView];
}

@end
