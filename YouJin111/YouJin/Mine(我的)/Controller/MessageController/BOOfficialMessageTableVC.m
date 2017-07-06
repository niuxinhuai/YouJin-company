//
//  BOOfficialMessageTableVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOOfficialMessageTableVC.h"
#import "UIImage+UIColor.h"
#import "OfficialMessageCell.h"

@interface BOOfficialMessageTableVC ()

@end

@implementation BOOfficialMessageTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    [self requireOfficialMessageListWithStartCount:0];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configureBars];
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ovvride
- (void)configureBars {
    [super configureBars];
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"官方消息"];
    self.navigationItem.titleView = titleView;
}

- (void)configureViews {
    [super configureViews];
    [self.lackView updateLackText:@"暂时没有官方消息"];
    [self hiddenLackView:YES];
    [self.tableView registerNib:[UINib nibWithNibName:@"OfficialMessageCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([OfficialMessageCell class])];
    self.tableView.backgroundColor = [UIColor colorWithIntRed:245 green:245 blue:247 alpha:1];
}

#pragma mark - require 

- (void)requireOfficialMessageListWithStartCount:(NSInteger)startCount {
    self.isRefreshing = YES;
    NSString *urlString = [BASEURL stringByAppendingFormat:@"Ucenter/userMessageOfficialNotice"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:USERSid forKey:@"sid"];
    [param setNewObject:USERUID forKey:@"uid"];
    [param setNewObject:@(startCount) forKey:@"start"];
    [param setNewObject:@(20) forKey:@"limit"];
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self tableViewEndRefreshing];
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            if (startCount == 0) [self.dataArray removeAllObjects];
            [self handleNewDataArray:[SystemNoticeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
        self.isRefreshing = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self tableViewEndRefreshing];
        self.isRefreshing = NO;
    }];
}

#pragma mark - Override

- (void)messageBottomRefreshing {
    if (self.isRefreshing || self.isNoMoreData) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireOfficialMessageListWithStartCount:self.dataArray.count];
}

- (void)messageTopRefreshing {
    if (self.isRefreshing) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireOfficialMessageListWithStartCount:0];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OfficialMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OfficialMessageCell class]) forIndexPath:indexPath];
    [cell updateSystemNoticeModel:self.dataArray[indexPath.row]];
    if (indexPath.row == self.dataArray.count - 4) {
        [self messageBottomRefreshing];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 165;
}

@end
