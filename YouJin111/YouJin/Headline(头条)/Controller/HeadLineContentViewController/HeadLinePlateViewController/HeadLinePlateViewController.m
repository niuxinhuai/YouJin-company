//
//  HeadLinePlateViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLinePlateViewController.h"
#import "NSMutableDictionary+Utilities.h"

@interface HeadLinePlateViewController ()

@end

@implementation HeadLinePlateViewController

+ (instancetype)headLinePlateViewControllerWithPlateID:(NSNumber *)plateId {
    HeadLinePlateViewController *vc = [[HeadLinePlateViewController alloc]initWithNibName:@"HeadLinePlateViewController" bundle:nil];
    vc.plateID = plateId;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requireForPlateListWithStart:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - require

- (void)requireForPlateListWithStart:(NSInteger)start {
    self.isRefreshing = YES;
    NSString *urlString = [BASEURL stringByAppendingString:@"Top/getTopListByMid"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:tokenString forKey:@"at"];
    [param setNewObject:self.plateID forKey:@"mid"];
    [param setObject:@(start) forKey:@"start"];
    [param setObject:@20 forKey:@"limit"];
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            NSArray *array = [TopContentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self handleRequestForPlateListSuccessWithData:array startCount:start];
            [self.datasource updateMixtureDatas];
            [self.tableView reloadData];
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

- (void)handleRequestForPlateListSuccessWithData:(NSArray *)data startCount:(NSInteger)start {
    if (start == 0) [self.datasource.contents removeAllObjects];
    [self.datasource.contents addObjectsFromArray:data];
    MJRefreshBackStateFooter *foot = (MJRefreshBackStateFooter *)self.tableView.mj_footer;
    foot.stateLabel.hidden = self.datasource.contents.count == 0;
    if (data.count < 20) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        self.isNoMoreData = YES;
    }
}


#pragma mark - ovrride

- (void)bottomRefreshing {
    if (self.isRefreshing || self.isNoMoreData) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireForPlateListWithStart:self.datasource.contents.count];
}

- (void)topRefreshing {
    if (self.isRefreshing) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireForPlateListWithStart:0];
}
@end
