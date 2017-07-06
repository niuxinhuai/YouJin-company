//
//  HotTopicDatasource.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HotTopicDatasource.h"

@implementation HotTopicDatasource



#pragma mark - UITableViewDataSource 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.bannerModels && self.bannerModels.count;
        case 1:
            return self.commentModles.count;
        case 2:
            return self.dynamicModels.count;
        default:
            return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return [self tableView:tableView cellWhenFirstSectionForIndexPath:indexPath];
        case 1:
            return [self tableView:tableView cellWhenSecondSectionForIndexPath:indexPath];
        case 2:
            return [self tableView:tableView cellWhenSecondSectionForIndexPath:indexPath];
        default:
            return nil;
    }
}




#pragma mark - helpMethod

- (UITableViewCell *)tableView:(UITableView *)tableView cellWhenFirstSectionForIndexPath:(NSIndexPath *)indexPath {
    HotTopicBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HotTopicBannerCell class])];
    [cell updateModels:self.bannerModels];
    if (self.configureHotTopicBannerCell) {
        self.configureHotTopicBannerCell(cell,indexPath);
    }
    return cell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellWhenSecondSectionForIndexPath:(NSIndexPath *)indexPath {
    HotCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HotCommentCell class])];
    [cell updateShowHeadImageView:YES];
    [cell updateCommentModel:self.commentModles[indexPath.row]];
    if (self.configureHotCommentCell) {
        self.configureHotCommentCell(cell, indexPath);
    }
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellWhenThirdSectionForIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


@end
