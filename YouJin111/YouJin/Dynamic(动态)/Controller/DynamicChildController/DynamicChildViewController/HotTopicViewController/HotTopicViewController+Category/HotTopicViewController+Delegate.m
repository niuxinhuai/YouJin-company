//
//  HotTopicViewController+Delegate.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HotTopicViewController+Delegate.h"
#import "HotTopicViewController+Configures.h"
#import "MineHomePageViewController.h"
#import "BannerWebViewViewController.h"
#import "HotdetailsViewController.h"
#import "CommentInsideViewController.h"
#import "PlatformServiceDetailViewController.h"

@implementation HotTopicViewController (Delegate)


#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 75;
        case 1:
            return [(HotCommentModle *)self.datasource.commentModles[indexPath.row] getCellHeight];
        case 2:
            return 0;
        default:
            return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"contentOffSetY = %f",scrollView.contentSize.height);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0 && [cell isKindOfClass:[HotTopicBannerCell class]]) {
        HotTopicBannerCell *bannerCell = (HotTopicBannerCell *)cell;
        BannerModel *model = bannerCell.models[0];
        switch ([model.go_type intValue]) {
            case 1:
                break;
            case 2:
                [self handleBannerClickedWhenToWebsiteWithBannerModel:model];
                break;
            case 3:
                [self handleBannerClickedWhenToPlatformWithPlatId:model.ctid];
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1 && [cell isKindOfClass:[HotCommentCell class]]) {
        HotCommentCell *commentCell = (HotCommentCell *)cell;
        [self pushCommentDetailViewController:commentCell.model];
    }
}


#pragma mark - <HotCommentCellDelegate>

- (void)hotCommentCellDidClickName:(HotCommentCell *)cell {
    [self pushUserHomePageViewControllerWithUid:cell.model.uid];
}
- (void)hotCommentCellDidClickHeadImageView:(HotCommentCell *)cell {
    [self pushUserHomePageViewControllerWithUid:cell.model.uid];
}

- (void)hotCommentCellDidClickPlatform:(HotCommentCell *)cell {
    if ([cell.model.out_type intValue] == 3) {
        [self handleBannerClickedWhenToPlatformWithPlatId:cell.model.zid];
    }else if ([cell.model.out_type intValue] == 9) {
        [self pushToPlatformServiceDetailViewControllerWithSvid:cell.model.zid];
    }
}

- (void)hotCommentCellAlertToPushLogin:(HotCommentCell *)cell {
    [self pushToLoginViewController];
}

- (void)pushUserHomePageViewControllerWithUid:(NSNumber *)uid {
    MineHomePageViewController *vc = [MineHomePageViewController create];
    vc.uid = [uid intValue];
    vc.hidesBottomBarWhenPushed = YES;
    vc.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushCommentDetailViewController:(HotCommentModle *)model {
    
    CommentInsideViewController *commVc = [[CommentInsideViewController alloc]init];
    commVc.hidesBottomBarWhenPushed = YES;
    commVc.pidString = [NSString stringWithFormat:@"%@",model.pid];
    commVc.outidString = [NSString stringWithFormat:@"%@",model.out_id];
    commVc.outtypeString = [NSString stringWithFormat:@"%@",model.out_type];;
    commVc.zidString = [NSString stringWithFormat:@"%@",model.zid];
    commVc.fidString = [NSString stringWithFormat:@"%@",model.fid];
    commVc.uidString = [NSString stringWithFormat:@"%@",model.uid];
    commVc.nameString = model.object;
    [self.navigationController pushViewController:commVc animated:YES];
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


- (void)handleBannerClickedWhenToPlatformWithPlatId:(NSNumber *)ptid {
    HotdetailsViewController *hotVc = [[HotdetailsViewController alloc]init];
    hotVc.hidesBottomBarWhenPushed = YES;
    hotVc.ptid = [ptid stringValue];
    [self.navigationController pushViewController:hotVc animated:YES];
}


- (void)pushToPlatformServiceDetailViewControllerWithSvid:(NSNumber *)svid {
    PlatformServiceDetailViewController *vc = [PlatformServiceDetailViewController createWithSvid:svid];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)pushToLoginViewController {
    BONoteVerifyLogiin *noteVerifyLoginVC = [[BONoteVerifyLogiin alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:noteVerifyLoginVC];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:nil];
}

@end
