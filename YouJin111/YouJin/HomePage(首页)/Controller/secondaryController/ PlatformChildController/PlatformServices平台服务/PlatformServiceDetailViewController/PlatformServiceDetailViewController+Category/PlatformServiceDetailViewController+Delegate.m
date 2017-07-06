//
//  PlatformServiceDetailViewController+Delegate.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformServiceDetailViewController+Delegate.h"
#import "PlatformServiceDetailViewController+Configuration.h"
#import "CommentInsideViewController.h"
#import "WebsiteWebViewController.h"

@implementation PlatformServiceDetailViewController (Delegate)


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserCommentCell class]) forIndexPath:indexPath];
    [cell updateBiaoQianModel:self.commentList[indexPath.row]];
    cell.delegate = self;
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.sectionHeadView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BiaoQianModel *model = self.commentList[indexPath.row];
    return [model topCommentCellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self pushCommentDetaiViewController:cell.model];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat dValue = 150;
    CGFloat rate = (contentOffsetY) / dValue;
    rate = rate > 1 ? 1 : rate;
    rate = rate < 0 ? 0 : rate;
    self.topBlueContainer.alpha = rate;
    self.topClearContainer.alpha = 1 - rate;
    if (contentOffsetY > 0 && contentOffsetY < scrollView.contentSize.height - scrollView.height) {
        [self updateWriteCommentContainerBottomToSuperBottom:(contentOffsetY - self.preContentOffsetY) < 0];
        self.preContentOffsetY = contentOffsetY;
    }
}

#pragma mark - <UserCommentCellDelegate>

- (void)userCommentCellDidCilckComment:(UserCommentCell *)cell {
    [self pushCommentDetaiViewController:cell.model];
}

- (void)userCommentCellDidCilckFavour:(UserCommentCell *)cell {
    [self requestForStarCommentWithOutId:[cell.model.pid integerValue]];
}

- (void)userCommentCellAlertToLogin:(UserCommentCell *)cell {
    [self pushToLoginViewController];
}

#pragma mark - <PlatformServiceDetailHeadViewDelegate>

- (void)platformServiceDetailHeadView:(PlatformServiceDetailHeadView *)view pushOfficialUrl:(NSString *)urlString {
    if (urlString && urlString.length > 0) {
        WebsiteWebViewController *websiVc = [[WebsiteWebViewController alloc]init];
        websiVc.urlString = urlString;
        [self.navigationController pushViewController:websiVc animated:YES];
    }else {
        [self toast:@"抱歉，暂无官网" complete:nil];
    }
}

- (void)platformServiceDetailHeadView:(PlatformServiceDetailHeadView *)view loadMoreCompanyInfo:(BOOL)isLoadMore {
    self.platformHeadView.height = [self.seviceDetail platformSeviceDetailHeadViewHeightWithOpenCompanyInfo:isLoadMore];
    self.tableView.tableHeaderView = self.platformHeadView;
}

# pragma mark - helpMethod

- (void)updateWriteCommentContainerBottomToSuperBottom:(BOOL)show {
    [UIView animateWithDuration:.3 animations:^{
        self.writeCommentContainer.top = show ? [UIScreen screenHeight] - 49 : [UIScreen screenHeight];
    } completion:nil];
}

- (void)pushCommentDetaiViewController:(BiaoQianModel *)model {
    CommentInsideViewController *commVc = [[CommentInsideViewController alloc]init];
    commVc.hidesBottomBarWhenPushed = YES;
    commVc.pidString = model.pid;
    commVc.outidString = model.pid;
    commVc.outtypeString = @"9";
    commVc.nameString = self.seviceDetail.pname;
    commVc.playKeyboard = @"noplayKeyboard";
    [self.navigationController pushViewController:commVc animated:YES];
}




@end
