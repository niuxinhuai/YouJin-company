//
//  CollectListViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/26.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CollectListViewController.h"
#import "CollectionCell.h"
#import "HeadLineDetailViewController.h"

@interface CollectListViewController ()

@end

@implementation CollectListViewController

+ (instancetype)create {
    CollectListViewController *vc = [[CollectListViewController alloc]init];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureViews];
    [self requireCollectListWithStartCount:0];
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

#pragma mark - configuration

- (void)configureViews {
    [super configureViews];
    [self.lackView updateLackText:@"您还没有收藏"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([CollectionCell class])];
    
}

- (void)configureBars {
    [super configureBars];
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"收藏"];
    self.navigationItem.titleView = titleView;
}

#pragma mark - require

- (void)requireCollectListWithStartCount:(NSInteger)start {
    self.isRefreshing = YES;
    NSString *urlString = [BASEURL stringByAppendingString:@"Ucenter/getMyCollectionList"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:USERSid forKey:@"sid"];
    [param setNewObject:USERUID forKey:@"uid"];
    [param setNewObject:@(start) forKey:@"start"];
    [param setNewObject:@(20) forKey:@"limit"];
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self tableViewEndRefreshing];
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            if (start == 0) [self.dataArray removeAllObjects];
            [self handleNewDataArray:[TopContentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
        self.isRefreshing = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.isRefreshing = NO;
    }];
}


- (void)cancelCollectContent:(TopContentModel *)content indexPath:(NSIndexPath *)indexPath {
    NSString *url = [NSString stringWithFormat:@"%@App/cancelCollect",BASEURL];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:USERSid forKey:@"sid"];
    [param setNewObject:content.tid forKey:@"tid"];
    [param setNewObject:USERUID forKey:@"uid"];
    [self.manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"r"] && [responseObject[@"r"] intValue] == 1) {
            [self handleCancelCollectionSuccessWithIndexPath:indexPath];
        }else {
            [self toast:@"取消收藏失败" complete:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

#pragma mark - overrideMethod

- (void)messageBottomRefreshing {
    if (self.isRefreshing || self.isNoMoreData) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireCollectListWithStartCount:self.dataArray.count];
}

- (void)messageTopRefreshing {
    if (self.isRefreshing) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireCollectListWithStartCount:0];
}

#pragma mark - <UITableViewDatasource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CollectionCell class]) forIndexPath:indexPath];
    [cell updateContent:self.dataArray[indexPath.row]];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CollectionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self cancelCollectContent:cell.content indexPath:indexPath];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TopContentModel *model = self.dataArray[indexPath.row];
    HeadLineDetailViewController *vc = [HeadLineDetailViewController headLineDetailViewControllerWithTid:model.tid];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - helpMethod

- (void)handleCancelCollectionSuccessWithIndexPath:(NSIndexPath *)indexPath {
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


@end
