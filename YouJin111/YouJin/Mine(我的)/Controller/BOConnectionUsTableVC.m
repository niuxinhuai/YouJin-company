//
//  BOConnectionUsTableVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOConnectionUsTableVC.h"
#import "BOSetupTitleView.h"
#import <SVProgressHUD.h>

@interface BOConnectionUsTableVC ()

@end

@implementation BOConnectionUsTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = BOColor(244, 245, 247);
    // 添加第一组
    [self setUpGroup0];
    // 添加第二组
    [self setUpGroup1];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // 隐藏底部的tabbar
    //    self.tabBarController.tabBar.hidden = YES;
    
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    //    self.navigationItem.leftBarButtonItem = btnItem;
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];

    
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"联系我们"];
    self.navigationItem.titleView = titleView;
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}
//描述一组
- (void)setUpGroup0 {
    
    //描述一行
    BOSettingArrowItem *rowItem = [BOSettingArrowItem itemWithImage:nil title:@"官方QQ群" subTitle:@"565893114"];
    rowItem.desTask = ^(NSIndexPath *indexPath) {
        [self cellClickWithTitle:@"565893114" WithString:@"官方QQ群"];
    };
    
    BOSettingArrowItem *rowItem1 = [BOSettingArrowItem itemWithImage:nil title:@"官方微信" subTitle:@"柚今科技"];
    rowItem1.desTask = ^(NSIndexPath *indexPath) {
        [self cellClickWithTitle:@"柚今科技" WithString:@"官方微信"];
    };
    BOSettingArrowItem *rowItem2 = [BOSettingArrowItem itemWithImage:nil title:@"公司电话" subTitle:@"0571-86839575"];
    rowItem2.desTask = ^(NSIndexPath *indexPath) {
        [self pushDeilPhoneNumber:@"0571-86839575"];
    };
    //一组当中有多少行
    NSArray *rowArray = @[rowItem,rowItem1,rowItem2];
    
    //创建组模型
    BOSettingGroupItem *groupItem = [BOSettingGroupItem ItemWithRowItemArray:rowArray];
    //    groupItem.HeaderT = @"第0组头部";
    
    //添加一组
    [self.groupArray addObject:groupItem];
}
- (void)setUpGroup1 {
    
    //描述一行
    BOSettingArrowItem *rowItem = [BOSettingArrowItem itemWithImage:nil title:@"商务QQ" subTitle:@"1612114603"];
    rowItem.desTask = ^(NSIndexPath *indexPath) {
        [self cellClickWithTitle:@"1612114603" WithString:@"商务QQ"];
    };
    BOSettingArrowItem *rowItem1 = [BOSettingArrowItem itemWithImage:nil title:@"合作电话" subTitle:@"13362176411"];
    rowItem1.desTask = ^(NSIndexPath *indexPath) {
        [self pushDeilPhoneNumber:@"13362176411"];
    };
    BOSettingArrowItem *rowItem2 = [BOSettingArrowItem itemWithImage:nil title:@"合作邮箱" subTitle:@"wb@youjin360.com"];
    rowItem2.desTask = ^(NSIndexPath *indexPath) {
        [self cellClickWithTitle:@"wb@youjin360.com" WithString:@"合作邮箱"];
    };
    //一组当中有多少行
    NSArray *rowArray = @[rowItem,rowItem1,rowItem2];
    
    //创建组模型
    BOSettingGroupItem *groupItem = [BOSettingGroupItem ItemWithRowItemArray:rowArray];
    //    groupItem.HeaderT = @"第1组头部";
    //    groupItem.footerT = @"第1组尾部";
    //添加一组
    [self.groupArray addObject:groupItem];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45 * BOHeightRate;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45 * BOHeightRate;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 45 * BOHeightRate)];
    headView.backgroundColor = BOColor(244, 245, 247);
    // 添加头像Icon
    UIImageView *iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(15 * BOWidthRate, 13 * BOHeightRate, 19 * BOWidthRate, 19 * BOWidthRate)];
    [headView addSubview:iconImageV];
    // 添加label
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImageV.frame) + 10 * BOWidthRate, 13 * BOHeightRate, 70 * BOWidthRate, 19 * BOHeightRate)];
    [contentLabel setFont:[UIFont systemFontOfSize:15]];
    [headView addSubview:contentLabel];
    // 设置第一组的头部数据
    if (section == 0) {
        iconImageV.image = [UIImage imageNamed:@"icon_yhzx-"];
        contentLabel.text = @"用户咨询";
    }else if (section == 1) {
        iconImageV.image = [UIImage imageNamed:@"icon_swhz"];
        contentLabel.text = @"商务合作";
    }
    return headView;
}

#pragma mark - 点击cell的处理事件
- (void)cellClickWithTitle:(NSString *)titleString WithString:(NSString *)pushString{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = titleString;
    [self toast:[NSString stringWithFormat:@"%@复制成功",pushString] complete:nil];
}

#pragma mark - 弹出拨打电话的界面
- (void)pushDeilPhoneNumber:(NSString *)phoneNumber {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

#pragma mark - helpMethod
- (void)toast:(NSString *)message complete:(dispatch_block_t)complete {
    [SVProgressHUD setFont:[UIFont systemFontOfSize:14]];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setCornerRadius:4.0];
    [SVProgressHUD showImage:nil status:message];
    [SVProgressHUD dismissWithDelay:1];
}

@end
