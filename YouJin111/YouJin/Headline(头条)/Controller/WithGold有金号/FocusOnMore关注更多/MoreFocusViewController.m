//
//  MoreFocusViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MoreFocusViewController.h"
#import "AttentionModel.h"
#import "SubscribeCell.h"
#import "MineHomePageViewController.h"

@interface MoreFocusViewController ()<SubscribeCellDelegate>

@end

@implementation MoreFocusViewController

+ (instancetype)create {
    MoreFocusViewController *vc = [[MoreFocusViewController alloc]initWithNibName:@"MoreFocusViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    [self requireForFocusListWithStartCount:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configureBars];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.block) self.block();
}

#pragma mark - request

- (void)requireForFocusListWithStartCount:(NSInteger)startCount {
    self.isRefreshing = YES;
    NSString *urlString = [BASEURL stringByAppendingString:@"Top/getMoreUserList"];
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
            [self handleNewDataArray:[AttentionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
        }
        self.isRefreshing = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.isRefreshing = NO;
        [self tableViewEndRefreshing];
    }];
}

- (void)subscribeUser:(BOOL)subscribe subscribeCell:(SubscribeCell *)cell {
    NSString *url = subscribe ? [NSString stringWithFormat:@"%@App/focusFriends",BASEURL] : [NSString stringWithFormat:@"%@App/cancelFocusFriend",BASEURL];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:USERSid forKey:@"sid"];
    [param setNewObject:cell.model.uid forKey:@"fuid"];
    [param setNewObject:USERUID forKey:@"uid"];
    
    [self.manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"r"] && [responseObject[@"r"] intValue] == 1) {
            [self updateSubscribeDataWithIndexPath:cell.indexPath];
        }
        [self toast:responseObject[@"msg"] complete:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - override

- (void)configureViews {
    [super configureViews];
    [self.lackView updateLackText:@"暂时没有更多推荐"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SubscribeCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([SubscribeCell class])];
    
}

- (void)messageBottomRefreshing {
    if (self.isRefreshing || self.isNoMoreData) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireForFocusListWithStartCount:self.dataArray.count];
}

- (void)messageTopRefreshing {
    if (self.isRefreshing) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireForFocusListWithStartCount:0];
}


- (void)configureBars {
    [super configureBars];
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"有金号"];
    self.navigationItem.titleView = titleView;
}

#pragma mark - helpMethod

- (void)updateSubscribeDataWithIndexPath:(NSIndexPath *)indexpath {
    if (indexpath.row < 0 || indexpath.row > self.dataArray.count) return;
    AttentionModel *model = self.dataArray[indexpath.row];
    model.is_each_other = @(![model.is_each_other boolValue]);
    [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - <UITableViewDatasource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SubscribeCell class]) forIndexPath:indexPath];
    cell.isFromGold = YES;
    [cell updateAttentionModel:self.dataArray[indexPath.row]];
    cell.indexPath = indexPath;
    cell.delegate = self;
    if (indexPath.row == self.dataArray.count - 4) [self messageBottomRefreshing];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SubscribeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self pushUserHomePageViewControllerWithUid:cell.model.uid];
}

#pragma mark - <SubscribeCellDelegate>

- (void)subscribeCell:(SubscribeCell *)cell didClickSubscibe:(BOOL)subscribe {
    [cell subscribeButtonEnable:NO];
    [self subscribeUser:subscribe subscribeCell:cell];
}


#pragma mark - helpMethod

- (void)pushUserHomePageViewControllerWithUid:(NSNumber *)uid {
    MineHomePageViewController *vc = [MineHomePageViewController create];
    vc.uid = [uid intValue];
    vc.hidesBottomBarWhenPushed = YES;
    vc.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
