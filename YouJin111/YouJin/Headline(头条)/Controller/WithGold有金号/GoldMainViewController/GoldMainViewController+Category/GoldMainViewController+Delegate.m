//
//  GoldMainViewController+Delegate.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "GoldMainViewController+Delegate.h"
#import "MediaCertificationViewController.h"
#import "EnterpriseCertificationViewController.h"
#import "MediaApplyViewController.h"
#import "CompanyApplyViewController.h"
#import "GoldMainViewController+Configures.h"
#import "FoucsHeadView.h"
#import "MoreFocusViewController.h"
#import "MineHomePageViewController+Delegate.h"

@implementation GoldMainViewController (Delegate)


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HaveGoldCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HaveGoldCell class])];
    cell.delegate = self;
    [cell updateFoucsModel:self.dataArray[indexPath.row]];
    if (indexPath.row == self.dataArray.count - 4) [self goldFoucsBottomRefreshing];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FoucsHeadView *view = [FoucsHeadView create];
    [view.moreFoucsButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    return view;

}


#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.dataArray.count == 0 ? 0 : 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HaveGoldCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self pushUserHomePageViewControllerWithUid:cell.model.fuid];
}


#pragma mark - <GoldAcountApplyViewDelegate>

- (void)goldAcountApplyView:(ToApplyForView *)view applyActionWithApplyType:(GoldAccountApplyType)type {
    switch (type) {
        case GoldAccountApplyByMedia:
            [self pushMediaApplyViewController];
            break;
        case GoldAccountApplyByCompany:
            [self pushCompanyApplyViewController];
            break;
        default:
            break;
    }
}
- (void)goldAcountApplyViewDidClicked:(ToApplyForView *)view {
    self.applyView.hidden = YES;
}


#pragma mark - <HaveGoldCellDelegaet>

- (void)haveGoldCellDidClickUserHead:(HaveGoldCell *)cell {
    [self pushUserHomePageViewControllerWithUid:cell.model.fuid];
}

#pragma mark - helpMethod

- (void)pushMediaApplyViewController {
    MediaApplyViewController *medcarVc = [MediaApplyViewController create];
    [self.navigationController pushViewController:medcarVc animated:YES];
}

- (void)pushCompanyApplyViewController {
    CompanyApplyViewController *encerVc = [CompanyApplyViewController create];
    [self.navigationController pushViewController:encerVc animated:YES];
}


- (void)moreAction:(UIButton *)button {
    MoreFocusViewController *focusVc = [MoreFocusViewController create];
    __weak typeof(self) weakSelf = self;
    focusVc.block = ^{
        [weakSelf goldFoucsTopRefreshing];
    };
    [self.navigationController pushViewController:focusVc animated:YES];
}


- (void)pushUserHomePageViewControllerWithUid:(NSNumber *)uid {
    MineHomePageViewController *vc = [MineHomePageViewController create];
    vc.uid = [uid intValue];
    vc.hidesBottomBarWhenPushed = YES;
    vc.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
