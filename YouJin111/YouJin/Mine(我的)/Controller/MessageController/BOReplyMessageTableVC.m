//
//  BOReplyMessageTableVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOReplyMessageTableVC.h"
#import "UIImage+UIColor.h"
#import "ReplyMessageCell.h"
static NSString *const ID = @"cell";
@interface BOReplyMessageTableVC ()

@end

@implementation BOReplyMessageTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    [self requireForReplyListWithStartCount:0 limit:20];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configureBars];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ovrride

- (void)configureBars {
    [super configureBars];
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"回复"];
    self.navigationItem.titleView = titleView;
}

- (void)configureViews {
    [super configureViews];
    [self.lackView updateLackText:@"您还没有回复"];
    [self hiddenLackView:YES];
    [self.tableView registerNib:[UINib nibWithNibName:@"ReplyMessageCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([ReplyMessageCell class])];
}

#pragma mark - Override

- (void)messageBottomRefreshing {
    if (self.isRefreshing || self.isNoMoreData) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireForReplyListWithStartCount:self.dataArray.count limit:20];
}

- (void)messageTopRefreshing {
    if (self.isRefreshing) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireForReplyListWithStartCount:0 limit:20];
}

#pragma mark - requireData

- (void)requireForReplyListWithStartCount:(NSInteger)startCount limit:(NSInteger)limitCount {
    self.isRefreshing = YES;
    NSString *urlString = [BASEURL stringByAppendingFormat:@"Ucenter/userMessageHuifu"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:USERSid forKey:@"sid"];
    [param setNewObject:USERUID forKey:@"uid"];
    [param setNewObject:@(startCount) forKey:@"start"];
    [param setNewObject:@(limitCount) forKey:@"limit"];
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self tableViewEndRefreshing];
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            if (startCount == 0) [self.dataArray removeAllObjects];
            [self handleNewDataArray:[HuifuModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReplyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([ReplyMessageCell class]) forIndexPath:indexPath];
    [cell updateMessgaeModel:self.dataArray[indexPath.row]];
    if (indexPath.row == self.dataArray.count - 4) {
        [self messageBottomRefreshing];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HuifuModel *model = self.dataArray[indexPath.row];
    return [model getReplyMessageCellHeight];
}

@end
