//
//  BOAttentionTableVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOAttentionTableVC.h"
#import "UIImage+UIColor.h"
#import "NSMutableDictionary+Utilities.h"
#import "BOAttentionCell.h"
static NSString *const ID = @"cell";
@interface BOAttentionTableVC ()

@end

@implementation BOAttentionTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    [self requireForAttentionListWithStartCount:0 limit:20];
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

- (void)requireForAttentionListWithStartCount:(NSInteger)startCount limit:(NSInteger)limitCount {
    self.isRefreshing = YES;
    NSString *urlString = [BASEURL stringByAppendingFormat:@"Ucenter/userMessageFocus"];
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
            [self handleNewDataArray:[AttentionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
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
    BOAttentionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BOAttentionCell class]) forIndexPath:indexPath];
    [cell updateModel:self.dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

#pragma mark - Override

- (void)configureViews {
    [super configureViews];
    [self.lackView updateLackText:@"您还没有关注"];
    [self hiddenLackView:YES];
    [self.tableView registerNib:[UINib nibWithNibName:@"BOAttentionCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([BOAttentionCell class])];
    
}

- (void)messageBottomRefreshing {
    if (self.isRefreshing || self.isNoMoreData) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireForAttentionListWithStartCount:self.dataArray.count limit:20];
}

- (void)messageTopRefreshing {
    if (self.isRefreshing) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireForAttentionListWithStartCount:0 limit:20];
}


- (void)configureBars {
    [super configureBars];
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"关注我的"];
    self.navigationItem.titleView = titleView;
}


#pragma mark - helpMethod





@end
