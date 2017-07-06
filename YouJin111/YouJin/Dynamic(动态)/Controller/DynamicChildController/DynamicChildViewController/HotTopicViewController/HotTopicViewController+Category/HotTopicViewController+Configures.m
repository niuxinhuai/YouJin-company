//
//  HotTopicViewController+Configures.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HotTopicViewController+Configures.h"

@implementation HotTopicViewController (Configures)


- (void)configureViews {
    [self tableViewConfigure];
}



- (void)tableViewConfigure {
    [self configureDatasouce];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self.datasource;
    self.tableView.delegate = self;
    NSArray *reuseIdentifiers = @[NSStringFromClass([HotTopicBannerCell class]),NSStringFromClass([HotCommentCell class])];
    [self tableView:self.tableView registerNibs:reuseIdentifiers forCellReuseIdentifiers:reuseIdentifiers];
}



- (void)configureDatasouce {
    self.datasource = [[HotTopicDatasource alloc]init];
    __weak typeof(self) weakSelf = self;
    self.datasource.configureHotCommentCell = ^(HotCommentCell *cell, NSIndexPath *indexPath) {
        cell.delegate = weakSelf;
    };
}


- (void)toolConfigures {
    self.mgr = [AFHTTPSessionManager bo_manager];
}


#pragma mark - helpMethod

- (void)tableView:(UITableView *)tableView registerNibs:(NSArray<NSString *> *)nibNames forCellReuseIdentifiers:(NSArray<NSString *> *)reuseIdentifiers {
    for (NSInteger i = 0; i < reuseIdentifiers.count; i ++) {
        [tableView registerNib:[UINib nibWithNibName:nibNames[i] bundle:nil] forCellReuseIdentifier:reuseIdentifiers[i]];
    }
}

@end
