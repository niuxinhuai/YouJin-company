//
//  HeadLineDetailViewController+Delegate.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/19.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineDetailViewController+Delegate.h"
#import "HeadLineDetailViewController+Configuration.h"
#import "MineHomePageViewController.h"
#import "HeadLineWrongViewController.h"



@implementation HeadLineDetailViewController (Delegate)

#pragma mark - <UITableViewDelegate>

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.footLabel;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.sectionHeadView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HuifuModel *model = self.datasource.comments[indexPath.row];
    return [model topCommentCellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.datasource.comments.count > 0 ? 0 : 108;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!USERSid) {
        [self pushToLoginViewController];
        return;
    }
    TopCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self topCommentCellDidClickReplyButton:cell];
}

#pragma mark - <TopContentDetailCellDelegate>

- (void)topContentDetailCell:(TopContentDetailCell *)cell heightChange:(CGFloat)height {
    self.tableView.tableHeaderView = self.contentDetailView;
    [self.view layoutIfNeeded];
    [self.tableView reloadData];
    self.preImageView.hidden = YES;
}

- (void)topContentDetailCell:(TopContentDetailCell *)cell didClickSubscribe:(BOOL)isSubscribe {
    [self subscribeUser:isSubscribe];
}

- (void)topDetailCellDidClickStarButton:(TopContentDetailCell *)cell {
    [self requestForFavourWithOutId:cell.content.tid typeId:@1];
}

- (void)topDetailCellRewardAction:(TopContentDetailCell *)cell {
    self.messageInputView.isRespondToKeyBoardChange = NO;
    self.rewardView = [RewardView create];
    self.rewardView.delegate = self;
    [self.rewardView updateUserInfo:self.userInfo];
    [self.rewardView show];
}

- (void)topDetailCellAlertToLogin:(TopContentDetailCell *)cell {
    [self pushToLoginViewController];
}

- (void)topDetailCellDidClickHeadImageView:(TopContentDetailCell *)cell {
    [self pushUserHomePageViewControllerWithUid:cell.content.uid];
}

- (void)topDetailCellDidClickWrongButton:(TopContentDetailCell *)cell {
    HeadLineWrongViewController *vc = [HeadLineWrongViewController create];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - <RewardViewDelegate>
- (void)rewardView:(RewardView *)view rewardCount:(NSInteger)count {
    [self rewardContentWithCount:count];
}


#pragma mark - <MessageInputViewDelegate>
- (void)messageInputView:(MessageInputView *)inputView sendText:(NSString *)text {
    if (text.length == 0) {
        [self toast:@"请输入内容" complete:nil];
        return;
    }
    PublishCommentModel *model = [self createPublsihCommentModelWithText:text];
    [self requestForPublsihCommentWithModel:model];
}
- (void)messageInputView:(MessageInputView *)inputView cancelEditWithText:(NSString *)text {
    if (self.isCommentToContent) {
        self.commentTextField.text = text;
    }
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (!USERSid) {
        [self pushToLoginViewController];
        return NO;
    }
    if (!self.isCommentToContent) self.messageInputView.inputTextView.text = @"";
    self.isCommentToContent = YES;
    [self.messageInputView updatePlaceholder:@"写评论..."];
    self.messageInputView.isRespondToKeyBoardChange = YES;
    [self.messageInputView show];
    return NO;
}

#pragma mark - <TopCommentCellDelegate>

- (void)topCommentCellDidClickReplyButton:(TopCommentCell *)cell {
    self.selectedModel = cell.commentModel;
    if (self.isCommentToContent) {
        self.messageInputView.inputTextView.text = @"";
        self.commentTextField.text = @"";
    }
    self.isCommentToContent = NO;
    [self updateInputViewPlaceholderWithName:cell.commentModel.uname];
    self.messageInputView.isRespondToKeyBoardChange = YES;
    [self.messageInputView show];
}

- (void)topCommentCellDidClickStarButton:(TopCommentCell *)cell {
    [self requestForFavourWithOutId:cell.commentModel.pid typeId:@3];
}

- (void)topCommentCellDidClickName:(TopCommentCell *)cell {
    [self pushUserHomePageViewControllerWithUid:cell.commentModel.uid];
}

- (void)topCommentCellDidClickHeadImageView:(TopCommentCell *)cell {
    [self pushUserHomePageViewControllerWithUid:cell.commentModel.uid];
}
- (void)topCommentCellAlertToLogin:(TopCommentCell *)cell {
    [self pushToLoginViewController];
}

#pragma mark - <BONoteVerifyLogiinDelegate>
- (void)BONoteVerifyLoginViewControllerDidLoginSucess:(BONoteVerifyLogiin *)loginVc {
    [self requireForUserInfo];
    [self requireForContentDetailWithTid:self.tid];
    [self requireForCommentWithStartCount:0];
}

#pragma mark - helpMethod

- (PublishCommentModel *)createPublsihCommentModelWithText:(NSString *)text {
    PublishCommentModel *model = [[PublishCommentModel alloc]init];
    model.zid = self.content.tid;
    if (!self.isCommentToContent && self.selectedModel) {
        model.fuid = self.selectedModel.uid;
    }
    model.out_type = @1;
    model.content = text;
    model.uided = self.content.uid;
    return model;
}

- (void)pushUserHomePageViewControllerWithUid:(NSNumber *)uid {
    MineHomePageViewController *vc = [MineHomePageViewController create];
    vc.uid = [uid intValue];
    vc.hidesBottomBarWhenPushed = YES;
    vc.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
