//
//  PublishListViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PublishListViewController.h"
#import "MinePublishCell.h"
#import "HeadLineDetailViewController.h"

@interface PublishListViewController ()<UITableViewDelegate>

@end

@implementation PublishListViewController

+ (instancetype)create {
    PublishListViewController *vc = [[PublishListViewController alloc]init];
    return vc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    [self requireForPublishListWithUserId:self.uid startCount:0 limitCount:20];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - configureViews

- (void)configureViews {
    self.isCanRefresh = YES;
    self.isCanLoadMore = YES;
    [self configureTableView];
}

- (void)configureTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"MinePublishCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([MinePublishCell class])];
    self.tableView.delegate = self;
}


#pragma mark - Request

- (void)requireForPublishListWithUserId:(NSInteger)uid startCount:(NSInteger)start limitCount:(NSInteger)limitCount {
    self.isRefreshing = YES;
    NSString *url = [self isMe] ? [NSString stringWithFormat:@"%@Ucenter/getMyHomePageFabiao",BASEURL] : [NSString stringWithFormat:@"%@Common/getOtherHomePageFabiao",BASEURL];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"at"] = tokenString;
    if ([self isMe]) dictionary[@"sid"] = USERSid;
    dictionary[@"uid"] = @(uid);
    dictionary[@"start"] = @(start);
    dictionary[@"limit"] = @(limitCount);
    
    [self.manager POST:url parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
             NSArray *array = [PublishModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self handleRequestSuccessWithData:array startCount:start];
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
        [self tableViewEndRefreshing];
        self.isRefreshing = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self tableViewEndRefreshing];
        self.isRefreshing = NO;
    }];
}

- (void)handleRequestSuccessWithData:(NSArray *)data startCount:(NSInteger)start{
    if (start == 0) [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:data];
    MJRefreshBackStateFooter *foot = (MJRefreshBackStateFooter *)self.tableView.mj_footer;
    if (self.dataArray.count == 0) {
        foot.stateLabel.hidden = self.dataArray.count == 0;
    }
    if (data.count < 20) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        self.isNoMoreData = YES;
    }
    [self.tableView reloadData];
}


- (void)bottomRefreshing {
    if (self.isRefreshing || self.isNoMoreData) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireForPublishListWithUserId:self.uid startCount:self.dataArray.count limitCount:20];
}

- (void)topRefreshing {
    if (self.isRefreshing) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireForPublishListWithUserId:self.uid startCount:0 limitCount:20];
}

#pragma mark - reget


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - helpMethod

- (BOOL)isMe {
    return self.uid == [USERUID intValue];
}

- (void)pushToTopDetailViewControllerWithTid:(NSNumber *)tid {
    HeadLineDetailViewController *vc = [HeadLineDetailViewController headLineDetailViewControllerWithTid:tid];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MinePublishCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MinePublishCell class]) forIndexPath:indexPath];
    [cell updateModel:self.dataArray[indexPath.row]];
    if (indexPath.row == self.dataArray.count - 5) {
        [self bottomRefreshing];
    }
    return cell;
}


#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MinePublishCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.model.type isEqualToString:@"头条"]) {
        [self pushToTopDetailViewControllerWithTid:cell.model.id];
    }
}

@end
