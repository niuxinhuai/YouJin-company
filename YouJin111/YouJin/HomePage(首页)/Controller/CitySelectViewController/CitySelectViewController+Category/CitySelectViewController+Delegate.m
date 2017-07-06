//
//  CitySelectViewController+Delegate.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CitySelectViewController+Delegate.h"
#import "CitySelectViewController+Configuration.h"

@implementation CitySelectViewController (Delegate)

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.totalCitys.count + 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    }
    CityModel *model = self.totalCitys[section - 2];
    return model.addressList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 2) {
        HotCityCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HotCityCell class]) forIndexPath:indexPath];
        if (indexPath.section == 1) {
            [cell updateNames:self.hotCitys];
        }else if (indexPath.section == 0) {
            [cell updateNames:self.loactionCitys];
        }
        cell.delegate = self;
        return cell;
    }
    NomalCityCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NomalCityCell class]) forIndexPath:indexPath];
    CityModel *model = self.totalCitys[indexPath.section - 2];
    CityDetailModel *detailModel = model.addressList[indexPath.row];
    [cell updateCityDetailModel:detailModel];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexArray;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 41;
    }else if (indexPath.section == 1) {
        NSInteger rows = ceil(self.hotCitys.count / 3.0);
        CGFloat height = rows * 50 - 10 + 2;
        return height > 0 ? height : 0;
    }
    return 40;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"定位城市";
    }else if (section == 1) {
        return @"热门城市";
    }
    CityModel *model = self.totalCitys[section - 2];
    return model.alifName;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 2) return;
    CityModel *model = self.totalCitys[indexPath.section - 2];
    CityDetailModel *detaiModel = model.addressList[indexPath.row];
    if (self.citySelectViewControllerBlock) {
        self.citySelectViewControllerBlock(detaiModel.name);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - <HotCityCellDelegate>

- (void)hotCityCell:(HotCityCell *)cell didSelectedWithIndexPath:(NSIndexPath *)indexPath cityName:(NSString *)name {
    if ([name isEqualToString:@"正在定位"]) {
        [self toast:@"抱歉，还在定位中" complete:nil];
    }else if ([name isEqualToString:@"未开启定位"]) {
        [self toast:@"请前往设置位置服务" complete:nil];
    }else if ([name isEqualToString:@"无法获取位置信息"]) {
        [self toast:@"暂无明确位置" complete:nil];
    }else {
        if (self.citySelectViewControllerBlock) {
            self.citySelectViewControllerBlock(name);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - <LocationManagerDelegate> 

- (void)locationManagerUpdateLocation:(LocationManager *)manager {
    [self updateLocationMessage:manager.city];
}
- (void)locationManager:(LocationManager *)manager refuseToUsePositioningSystem:(NSString *)message {
    [self updateLocationMessage:message];
}
- (void)locationManager:(LocationManager *)manager locateFailure:(NSString *)message {
    [self updateLocationMessage:message];
}


#pragma mark - helpMethod

- (void)updateLocationMessage:(NSString *)message {
    CityDetailModel *model = self.loactionCitys[0];
    model.name = message;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

@end
