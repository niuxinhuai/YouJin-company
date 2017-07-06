//
//  BOMessageTableVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOMessageTableVC.h"
#import "UIImage+UIColor.h"
#import "BOSystemInformTableVC.h"
#import "BOAttentionTableVC.h"
#import "BOOfficialMessageTableVC.h"
#import "BOReplyMessageTableVC.h"
#import "NSMutableDictionary+Utilities.h"
#import "MessageCenterModel.h"
#import "MessageCenterCellTableViewCell.h"
static NSString *const ID = @"cell";
@interface BOMessageTableVC ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) MessageCenterModel *model;

@end

@implementation BOMessageTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MessageCenterCellTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([MessageCenterCellTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self requireMessageList];
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
    
    // 设置navigationItem的左边按钮
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    //    self.navigationItem.leftBarButtonItem = btnItem;
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"我的消息"];
    self.navigationItem.titleView = titleView;
}


#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - require 


- (void)requireMessageList {
    NSString *loadString = [NSString stringWithFormat:@"%@Ucenter/userMessageHome", BASEURL];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:USERSid forKey:@"sid"];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:USERUID forKey:@"uid"];
    [self.manager POST:loadString parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1) {
            self.model = [MessageCenterModel mj_objectWithKeyValues:responseObject];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

#pragma mark - reget

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager bo_manager];
    }
    return _manager;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCenterCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageCenterCellTableViewCell class]) forIndexPath:indexPath];
    [cell updateMessageModel:self.model messageType:(int)(indexPath.row + 1)];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 79;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BOReplyMessageTableVC *replyMessageTableVC = [[BOReplyMessageTableVC alloc] init];
        replyMessageTableVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:replyMessageTableVC animated:YES];
    }else if (indexPath.row == 1) {
        BOSystemInformTableVC *systemInformVC = [[BOSystemInformTableVC alloc] init];
        systemInformVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:systemInformVC animated:YES];
    }else if (indexPath.row == 2) {
        BOAttentionTableVC *attentionTableVC = [[BOAttentionTableVC alloc] init];
        attentionTableVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:attentionTableVC animated:YES];
    }else if (indexPath.row == 3) {
        BOOfficialMessageTableVC *officialMessageTableVC = [[BOOfficialMessageTableVC alloc] init];
        officialMessageTableVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:officialMessageTableVC animated:YES];
    }
}
@end
