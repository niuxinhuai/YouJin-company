//
//  NewIndustryDataViewController+Delegate.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NewIndustryDataViewController+Delegate.h"
#import "NewIndustryDataViewController+Configuration.h"

@implementation NewIndustryDataViewController (Delegate)

#pragma mark - <HomeLineHeadBarViewDelegate>

- (void)homeLineHeadBarView:(HomeLineHeadBarView *)view didSelectedItemWithIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: self.timeKey = @"yesterday";
            break;
        case 1: self.timeKey = @"week";
            break;
        case 2: self.timeKey = @"month";
            break;
        default:
            break;
    }
    [self.baseScrollView.mj_header beginRefreshing];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        DayDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DayDataTableViewCell class]) forIndexPath:indexPath];
        cell.items = self.dataArray[indexPath.row];
        return cell;
    }
    RightDayDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RightDayDataTableViewCell class]) forIndexPath:indexPath];
    cell.item = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.rightScrollView) {
        self.rightSectionLeadingToLeftSectionRight.constant = - scrollView.contentOffset.x;
        [self.sectionContainer layoutIfNeeded];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.5 animations:^{
        self.redPacketCenterXToSuperRight.constant = 0;
        [self.view layoutIfNeeded];
        self.redPacket.alpha = 0.4;
    }];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        self.redPacketCenterXToSuperRight.constant = 50;
        [self.view layoutIfNeeded];
        self.redPacket.alpha = 1;
    } completion:nil];
}

@end
