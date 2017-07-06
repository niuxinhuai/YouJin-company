//
//  NewCurrentViewController+Delegate.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NewCurrentViewController+Delegate.h"
#import "NewCurrentViewController+Configuration.h"
#import "BannerWebViewViewController.h"
#import "HotdetailsViewController.h"

@implementation NewCurrentViewController (Delegate)

#pragma mark - <HomeLineHeadBarViewDelegate>

- (void)homeLineHeadBarView:(HomeLineHeadBarView *)view didSelectedItemWithIndexPath:(NSIndexPath *)indexPath {
    [self handleBottomCollectionViewScrollToIndexPath:indexPath animation:YES];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self superHandleWhenCollectionScroll:scrollView];
}

#pragma mark - <BaseSwipeSubViewControllerDelegate>

- (void)baseSwipeSubViewControllerBeginDragging:(BaseSwipeSubViewController *)controller {
    [UIView animateWithDuration:0.5 animations:^{
        self.redPacketCenterXToSuperRight.constant = 0;
        [self.view layoutIfNeeded];
        self.redPacketButton.alpha = 0.4;
    }];
    
}
- (void)baseSwipeSubViewControllerEndDragging:(BaseSwipeSubViewController *)controller {
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        self.redPacketCenterXToSuperRight.constant = 50;
        [self.view layoutIfNeeded];
        self.redPacketButton.alpha = 1;
    } completion:nil];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
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

#pragma mark - helpMethod

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

@end
