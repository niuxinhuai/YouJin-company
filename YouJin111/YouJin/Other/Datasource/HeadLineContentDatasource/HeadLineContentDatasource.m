//
//  HeadLineContentDatasource.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineContentDatasource.h"



@implementation HeadLineContentDatasource




#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mixtureDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.mixtureDatas[indexPath.row] isKindOfClass:[AdvertisementModel class]]) {
        HeadLineMediaCell *cell = [tableView dequeueReusableCellWithIdentifier:HEAD_LINE_AD_CELL_ID];
        [cell updateAdvertisement:self.mixtureDatas[indexPath.row]];
        if (self.headLineMediaCellConfiguration) {
            self.headLineMediaCellConfiguration(cell, indexPath);
        }
        return cell;
    }
    TopContentModel *model = self.mixtureDatas[indexPath.row];
    BaseHeadLineCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifierWithCovers:model.cover]];
    [cell updateContent:model];
    if (self.baseHeadLineCellConfiguration) {
        self.baseHeadLineCellConfiguration(cell, indexPath);
    }
    return cell;
}




#pragma mark - helpMethod


- (NSInteger)cellCount {
    return self.adMaxCount + self.contents.count;
}


- (NSInteger)adMaxCount {
    NSInteger adMax = floorf(self.contents.count / 4);
    return self.advertisements.count > adMax ? adMax : self.advertisements.count;
}

- (NSString *)cellIdentifierWithCovers:(NSArray *)covers {
    if (!covers || covers.count == 0) return self.templates[0];
    if (covers.count < 3) return self.templates[1];
    return self.templates[2];
}


- (void)updateMixtureDatas {
    NSMutableArray *mixtures = [self.contents mutableCopy];
    for (NSInteger i = 0; i < self.adMaxCount; i ++) {
        [mixtures insertObject:self.advertisements[i] atIndex:((i + 1) * 5 - 1)];
    }
    self.mixtureDatas = mixtures;
}


#pragma mark - reget

- (NSMutableArray *)contents {
    if (!_contents) {
        _contents = [NSMutableArray array];
    }
    return _contents;
}



- (NSMutableArray *)advertisements {
    if (!_advertisements) {
        _advertisements = [NSMutableArray array];
    }
    return _advertisements;
}

- (NSMutableArray *)mixtureDatas {
    if (!_mixtureDatas) {
        _mixtureDatas = [NSMutableArray array];
    }
    return _mixtureDatas;
}


- (NSArray *)templates {
    return @[HEAD_LINE_TEXT_CELL_ID, HEAD_LINE_ONE_IMAGE_CELL_ID, HEAD_LINE_THREE_IMAGE_CELL_ID];
}





@end
