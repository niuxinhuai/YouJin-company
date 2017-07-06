//
//  BaseSwipeViewController+Delegate.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseSwipeViewController+Delegate.h"
#import "BaseSwipeViewController+Configuration.h"

@implementation BaseSwipeViewController (Delegate)

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.subControllerCount;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SwipeSubControllerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SwipeSubControllerCell class]) forIndexPath:indexPath];
    BaseSwipeSubViewController *viewController = [self viewControllerAtIndex:indexPath.row];
    [cell addView:viewController.view];
    cell.viewController = viewController;
    [self updateContentInsetWithScollView:viewController.tableView];
    self.lastIndexPath = self.currentIndexPath;
    self.currentIndexPath = indexPath;
    self.lastVC = self.currentVC == viewController ? self.lastVC : self.currentVC;
    self.currentVC = viewController;
    [self updateContentOffsetWithCurrentScrollView:self.lastVC.tableView prepareScrollView:viewController.tableView];
    viewController.ignoredScrollViewContentInsetBottom = self.headerInset - self.baseInset;
    
    return cell;
}


- (void)updateContentInsetWithScollView:(UIScrollView *)scrollView {
    UITableView *tableView = (UITableView *)scrollView;
    if (self.type == kSwipeTableViewByHeadView) {
        tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen screenWidth], self.headerInset)];
        scrollView.contentInset = UIEdgeInsetsMake(self.barInset, 0, 0, 0);
    }else {
        scrollView.contentInset = UIEdgeInsetsMake(self.headerInset + self.barInset, 0, 0, 0);
    }
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(self.headerInset + self.barInset, 0, 0, 0);
}

- (void)updateContentOffsetWithCurrentScrollView:(UIScrollView *)currenScrollView prepareScrollView:(UIScrollView *)prepareScrollView {
    if (!currenScrollView) {
        if (self.type == kSwipeTableViewByHeadView) {
            prepareScrollView.contentOffset = CGPointMake(0, - (self.barInset));
        }else {
            prepareScrollView.contentOffset = CGPointMake(0, - (self.headerInset + self.barInset));
        }
        return;
    }
    CGPoint currentContentOffset = currenScrollView.contentOffset;
    CGPoint prepareContentOffset  = prepareScrollView.contentOffset;
    CGFloat topMarginOffsetY = self.barInset + self.baseInset;
    if (self.type == kSwipeTableViewByHeadView) topMarginOffsetY -= self.headerInset;
    if (currentContentOffset.y  >= - topMarginOffsetY) {
        if (prepareContentOffset.y < - topMarginOffsetY) {
            prepareContentOffset.y = - topMarginOffsetY;
        }
    }else {
        prepareContentOffset.y = currentContentOffset.y;
    }
    prepareScrollView.contentOffset = prepareContentOffset;
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self superHandleWhenCollectionScroll:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
}

- (BaseSwipeSubViewController *)getSubControllerWithIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    SwipeSubControllerCell *cell = (SwipeSubControllerCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    return (BaseSwipeSubViewController *)cell.viewController;
}

#pragma mark - <BaseSwipeSubViewControllerDelegate>

- (void)baseSwipeSubViewController:(BaseSwipeSubViewController *)controller observeContentOffset:(CGPoint)contentOffset {
    [self handleBaseSwipeSubViewControllerContentOffset:contentOffset];
}


@end
