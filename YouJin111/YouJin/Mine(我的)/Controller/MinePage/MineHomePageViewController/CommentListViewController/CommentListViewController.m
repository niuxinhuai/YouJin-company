//
//  CommentListViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CommentListViewController.h"
#import "CommentCell.h"
#import "HeadLineDetailViewController.h"
#import "CommentInsideViewController.h"

@interface CommentListViewController ()<UITableViewDelegate>

@end

@implementation CommentListViewController

+ (instancetype)create {
    CommentListViewController *vc = [[CommentListViewController alloc]init];
    return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    [self requireForCommentListWithUserId:self.uid startCount:0 limitCount:20];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([CommentCell class])];
    self.tableView.delegate = self;
}


#pragma mark - Request

- (void)requireForCommentListWithUserId:(NSInteger)uid startCount:(NSInteger)start limitCount:(NSInteger)limitCount {
    self.isRefreshing = YES;
    NSString *url = [self isMe] ? [NSString stringWithFormat:@"%@Ucenter/getMyHomePagePinglun",BASEURL] : [NSString stringWithFormat:@"%@Common/getOtherHomePagePinglun",BASEURL];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"at"] = tokenString;
    if ([self isMe]) dictionary[@"sid"] = USERSid;
    dictionary[@"uid"] = @(uid);
    dictionary[@"start"] = @(start);
    dictionary[@"limit"] = @(limitCount);
    
    [self.manager POST:url parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            NSArray *array = [CommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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


#pragma mark - ovrride

- (void)bottomRefreshing {
    if (self.isRefreshing || self.isNoMoreData) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireForCommentListWithUserId:self.uid startCount:self.dataArray.count limitCount:20];
}

- (void)topRefreshing {
    if (self.isRefreshing) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireForCommentListWithUserId:self.uid startCount:0 limitCount:20];
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

- (void)pushToUserCommentDetailViewControllerWithCommentModel:(CommentModel *)model {
    CommentInsideViewController *vc = [[CommentInsideViewController alloc]init];
    vc.pidString = [model.out_id stringValue];
    vc.outidString = [model.out_id stringValue];
    vc.outtypeString = [model.out_type stringValue];
    vc.nameString = model.uname;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CommentCell class]) forIndexPath:indexPath];
    [cell updateCommentModel:self.dataArray[indexPath.row]];
    if (indexPath.row == self.dataArray.count - 5) {
        [self bottomRefreshing];
    }
    return cell;
}


#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentModel *model = self.dataArray[indexPath.row];
    return [model getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.model.type isEqualToString:@"点评"]) {
        [self pushToUserCommentDetailViewControllerWithCommentModel:cell.model];
    }else if ([cell.model.type isEqualToString:@"头条"]) {
        [self pushToTopDetailViewControllerWithTid:cell.model.zid];
    }
}



@end
