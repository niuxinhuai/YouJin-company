//
//  MineHomePageViewController+Delegate.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MineHomePageViewController+Delegate.h"

@implementation MineHomePageViewController (Delegate)





#pragma mark - <BaseSwipeSubViewControllerDelegate>

- (void)baseSwipeSubViewController:(BaseSwipeSubViewController *)controller observeContentOffset:(CGPoint)contentOffset {
    [self handleBaseSwipeSubViewControllerContentOffset:contentOffset];
    CGFloat topMarginOffset = self.baseInset + self.barInset + 20;
    CGFloat topMaxOffset = self.barInset + self.headerInset - 20;
    CGFloat dValue = topMaxOffset - topMarginOffset;
    CGFloat distance = contentOffset.y + topMarginOffset;
    CGFloat rate = (-distance) / dValue;
    rate = rate > 1 ? 1 : rate;
    rate = rate < 0 ? 0 : rate;
    self.backgroundView.alpha = 1 - rate;
    self.titleLabel.alpha = 1 - rate;
    
}

#pragma mark - <UserPageBarDelegate>

- (void)userPageBar:(UserPageBar *)bar changeSelectedType:(UserPageBarSelectType)type {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:type inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}


#pragma - mark <UIScrollViewDelegate>

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        CGFloat currentItemIndex = scrollView.contentOffset.x/scrollView.width + 0.5;
        UserPageBar *bar = (UserPageBar *)self.headBarView;
        [bar updateSelectType:currentItemIndex callDelegate:NO];
    }
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat currentItemIndex = scrollView.contentOffset.x/scrollView.width + 0.5;
    UserPageBar *bar = (UserPageBar *)self.headBarView;
    [bar updateSelectType:currentItemIndex callDelegate:NO];
}



@end
