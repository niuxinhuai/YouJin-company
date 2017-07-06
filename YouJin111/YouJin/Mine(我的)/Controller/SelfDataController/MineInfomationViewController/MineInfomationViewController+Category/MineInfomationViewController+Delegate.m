//
//  MineInfomationViewController+Delegate.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/8.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MineInfomationViewController+Delegate.h"
#import "MineInfomationViewController+Configures.h"
#import "BOChangeNicknameVC.h"
#import "RiskAssessmentsViewController.h"
#import "IntegralShareViewController.h"

@implementation MineInfomationViewController (Delegate)


#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOSelfDataCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BOSelfDataCell class])];
    [cell updateMineItem:self.item indexPath:indexPath];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self headImageChangeClicked];
            break;
        case 1:
            [self unameChangeClicked];
            break;
        case 2:
            [self sexChangeClicked];
            break;
        case 3:
            [self investTypeChangeClick];
            break;
        case 4:
            [self addressChangeClick];
            break;
        default:
            break;
    }
}


#pragma mark - <UITextViewDelegate>

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self updateFlagCountLabelText:textView.text];
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self updateFlagCountLabelText:textView.text];
    self.item.flag = textView.text;
}

- (void)textViewDidChange:(UITextView *)textView {
    [self updateFlagCountLabelText:textView.text];
    self.item.flag = textView.text;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - <UIActionSheetDelegate>

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 2) return;
    if (actionSheet.tag == 255) {
        [self openImagePickerControllerWithType:buttonIndex == 0 ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary];
    }else if (actionSheet.tag == 256) {
        self.item.sex = buttonIndex == 0 ? @"0" : @"1";
        [self.tableView reloadData];
    }
}

#pragma mark - <UIAlertViewDelegate>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (buttonIndex == 1) {
        [self complishAction:nil];
    }
}

#pragma mark - <UIImagePickerControllerDelegate>

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.item.headImage = image;
    [self.tableView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - helpMethod

- (void)headImageChangeClicked
{
    UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    sheet.tag = 255;
    [sheet showInView:self.view];
}

- (void)unameChangeClicked {
    BOChangeNicknameVC *changeNicknameVC = [[BOChangeNicknameVC alloc] init];
    changeNicknameVC.nameString = self.item.uname;
    __weak typeof(self) weakSelf = self;
    changeNicknameVC.nameChangeBlock = ^(NSString *newName) {
        weakSelf.item.uname = newName;
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:changeNicknameVC animated:YES];
}

- (void)sexChangeClicked {
    UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女", nil];
    sheet.tag = 256;
    [sheet showInView:self.view];
}

- (void)investTypeChangeClick {
    RiskAssessmentsViewController *risVc = [[RiskAssessmentsViewController alloc] init];
    risVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:risVc animated:YES];
}

- (void)addressChangeClick {
    IntegralShareViewController *integralVC = [[IntegralShareViewController alloc] init];
    integralVC.hidesBottomBarWhenPushed = YES;
    integralVC.urlString = [NSString stringWithFormat:@"%@mobile/page/addAddress.html?uid=%@", BASEWEBURl,USERUID];
    integralVC.titleString = @"收货地址";
    [self.navigationController pushViewController:integralVC animated:YES];
}

@end
