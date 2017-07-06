//
//  CitySelectViewController+Configuration.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CitySelectViewController+Configuration.h"

@implementation CitySelectViewController (Configuration)


- (void)configureViews {
    [self configureTableView];
   // [self configureHeaderView];
}

- (void)configureTools {
    self.loactionCitys = [[self createLocationCityData]mutableCopy];
    self.locationManager = [LocationManager sharedLocationManagerWithDelegate:self];
}

- (void)configureTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"HotCityCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([HotCityCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:@"NomalCityCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([NomalCityCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)configureHeaderView {
    self.headerView = [CityHeaderView create];
    self.tableView.tableHeaderView = self.headerView;
}




#pragma mark - helpMethod

- (NSArray *)createLocationCityData {
    CityDetailModel *model = [CityDetailModel new];
    model.name = @"正在定位";
    return @[model];
}






@end
