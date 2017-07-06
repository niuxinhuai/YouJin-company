//
//  BOSystemInformTableVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOSystemInformTableVC.h"
#import "UIImage+UIColor.h"
#import "SystemNoticeCell.h"


@interface BOSystemInformTableVC ()

@end

@implementation BOSystemInformTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    [self requireSystemNotificationListWithStartCount:0];
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

#pragma mark - requireData 



#pragma mark - ovrride 

- (void)configureViews {
    [super configureViews];
    [self.lackView updateLackText:@"暂时没有系统通知"];
    [self hiddenLackView:YES];
    [self.tableView registerNib:[UINib nibWithNibName:@"SystemNoticeCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([SystemNoticeCell class])];
}

- (void)configureBars {
    [super configureBars];
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"我的消息"];
    self.navigationItem.titleView = titleView;
}


- (void)messageBottomRefreshing {
    if (self.isRefreshing || self.isNoMoreData) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireSystemNotificationListWithStartCount:self.dataArray.count];
}

- (void)messageTopRefreshing {
    if (self.isRefreshing) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireSystemNotificationListWithStartCount:0];
}

#pragma mark - request

- (void)requireSystemNotificationListWithStartCount:(NSInteger)startCount {
    self.isRefreshing = YES;
    NSString *urlString = [BASEURL stringByAppendingFormat:@"Ucenter/userMessageSysNotice"];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SystemNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SystemNoticeCell class]) forIndexPath:indexPath];
    [cell updateSystemNoticeModel:self.dataArray[indexPath.row]];
    if (indexPath.row == self.dataArray.count - 4) {
        [self messageBottomRefreshing];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}




@end
