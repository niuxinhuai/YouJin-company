//
//  HeadLineMainViewController+Delegate.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineMainViewController+Delegate.h"
#import "SearchArticleViewController.h"
#import "BannerWebViewViewController.h"
#import "HotdetailsViewController.h"
#import "HeadLineMainViewController+LogiclFlow.h"

@implementation HeadLineMainViewController (Delegate)


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
    self.topBackgroundView.alpha = 1 - rate;
}


#pragma mark - <HomeLineHeadBarViewDelegate>

- (void)homeLineHeadBarView:(HomeLineHeadBarView *)view didSelectedItemWithIndexPath:(NSIndexPath *)indexPath {
    [self handleBottomCollectionViewScrollToIndexPath:indexPath animation:NO];
}


#pragma - mark <UIScrollViewDelegate>

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        CGFloat currentItemIndex = scrollView.contentOffset.x/scrollView.width + 0.5;
        HomeLineHeadBarView *bar = [self getHeadBarView];
        [bar updateIndexPath:[NSIndexPath indexPathForRow:currentItemIndex inSection:0]];
    }
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat currentItemIndex = scrollView.contentOffset.x/scrollView.width + 0.5;
    HomeLineHeadBarView *bar = [self getHeadBarView];
    [bar updateIndexPath:[NSIndexPath indexPathForRow:currentItemIndex inSection:0]];
}


#pragma mark - <UISearchBarDelegate>

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    SearchArticleViewController *se = [[SearchArticleViewController alloc]init];
    se.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:se animated:YES];
    return NO;
}

#pragma mark - <HeadLineBaseViewControllerDelegate>




#pragma mark - <SDCycleScrollViewDelegate>

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    BannerModel *model = self.bannerDatas[index];
    switch ([model.go_type intValue]) {
        case 1:
            break;
        case 2:
            [self handleBannerClickedWhenToWebsiteWithBannerModel:model];
            break;
        case 3:
            [self handleBannerClickedWhenToPlatformWithBannerModel:model];
            break;
        default:
            break;
    }
}


- (void)handleBannerClickedWhenToWebsiteWithBannerModel:(BannerModel *)model {
    NSArray *newArray = [model.url componentsSeparatedByString:@"|"];
    BannerWebViewViewController *bannerWebVc = [[BannerWebViewViewController alloc]init];
    if (newArray.count == 2) {
        bannerWebVc.name = newArray[0];
        bannerWebVc.url = newArray[1];
    }else {
        bannerWebVc.url = model.url;
    }
    bannerWebVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bannerWebVc animated:YES];
}


- (void)handleBannerClickedWhenToPlatformWithBannerModel:(BannerModel *)model {
    HotdetailsViewController *hotVc = [[HotdetailsViewController alloc]init];
    hotVc.hidesBottomBarWhenPushed = YES;
    hotVc.ptid = model.ID;
    [self.navigationController pushViewController:hotVc animated:YES];
}

#pragma mark - <UIAlertViewDelegate>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    return;
}

#pragma mark - <BONoteVerifyLogiinDelegate>

- (void)BONoteVerifyLoginViewControllerDidLoginSucess:(BONoteVerifyLogiin *)loginVc {
    [self getAuthorityOfPublishCoentent];
}


@end
