//
//  HeadLineDetailCommentDatasource.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/19.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineDetailCommentDatasource.h"

@implementation HeadLineDetailCommentDatasource



#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TopCommentCell class])];
    [cell updateCommentModel:self.comments[indexPath.row]];
    if (self.topCommentCellConfiguration) {
        self.topCommentCellConfiguration(cell, indexPath);
    }
    return cell;
}



#pragma mark - reget 

- (NSMutableArray<HuifuModel *> *)comments {
    if (!_comments) {
        _comments = [NSMutableArray array];
    }
    return _comments;
}





@end
