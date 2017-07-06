//
//  MineInfomationViewController+Configures.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/8.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MineInfomationViewController+Configures.h"
#import "MineInfomationViewController+Delegate.h"

@implementation MineInfomationViewController (Configures)

- (void)configureViews {
    [self configureTableView];
    [self configureTextView];
}


- (void)configureTableView {
    self.tableView.scrollEnabled = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[BOSelfDataCell class] forCellReuseIdentifier:NSStringFromClass([BOSelfDataCell class])];
}

- (void)configureTextView {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:13],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    self.flagTextView.attributedText = [[NSAttributedString alloc] initWithString:@" " attributes:attributes];
    self.flagTextView.text = @"";
    self.flagTextView.delegate = self;
}

- (void)configureBar {
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];

   // [self.navigationController.navigationBar setBarTintColor:[UIColor navDefaultColor]];
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(returnAction:)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(complishAction:)];
    [right setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = right;
    
    
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"个人资料"];
    self.navigationItem.titleView = titleView;
}

#pragma mark - buttonAction

- (void)returnAction:(UIButton *)button {
    if (!self.item.headImage && ![self judgeMessageHaveUpdate]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"是否保存修改内容" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
    [alertView show];
}

- (void)complishAction:(UIButton *)button {
    __weak typeof(self) weakSelf = self;
    if (!self.item.headImage) {
        if ([self judgeMessageHaveUpdate]) {
            [self requireForUpdateUserInfoSuccessBlock:nil];
        }else {
            [self toast:@"请更新数据" complete:nil];
        }
        return;
    }
    [self requireQiNiuTokenSuccessBlock:^{
        if ([weakSelf judgeMessageHaveUpdate]) {
            [weakSelf requireForUpdateUserInfoSuccessBlock:nil];
        }else {
            [weakSelf toast:@"更新成功" complete:nil];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}


#pragma mark - helpMethod

- (void)updateUserMessageItem:(SelfDataItem *)item {
    if (!self.item) {
        self.item = item;
    }else {
        self.item.address = item.address;
        self.item.type = item.type;
    }
    self.flagTextView.text = item.flag;
    [self updateFlagCountLabelText:item.flag];
    [self.tableView reloadData];
}

- (void)updateFlagCountLabelText:(NSString *)text {
    self.countLabel.text = [NSString stringWithFormat:@"%lu/80",(unsigned long)text.length];
    self.placeholdLabel.hidden = text > 0;
}

- (void)openImagePickerControllerWithType:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) {
        [self toast:@"请设置访问权限" complete:nil];
        return;
    }
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.sourceType = type;
    imgPicker.delegate = self;
    imgPicker.allowsEditing = YES;
    [self presentViewController:imgPicker animated:YES completion:nil];
}

- (BOOL)judgeMessageHaveUpdate {
    if (![self.item.sex isEqualToString:self.oldItem.sex]) {
        return YES;
    }else if (![self.item.uname isEqualToString:self.oldItem.uname]) {
        return YES;
    }else if (![self.item.flag isEqualToString:self.oldItem.flag]) {
        return YES;
    }
    return NO;
}


@end
