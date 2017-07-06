//
//  CitySelectViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseViewController.h"
#import "LocationManager.h"
#import "CityHeaderView.h"

typedef void(^CitySelectViewControllerBlock)(NSString *cityName);

@interface CitySelectViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) CityHeaderView *headerView;


@property (nonatomic, retain) NSMutableArray *totalCitys;
@property (nonatomic, retain) NSMutableArray *hotCitys;
@property (nonatomic, retain) NSMutableArray *loactionCitys;
@property (nonatomic, retain) NSMutableArray *sectionIndexArray;
@property (nonatomic, retain) LocationManager *locationManager;

@property (nonatomic, copy) CitySelectViewControllerBlock citySelectViewControllerBlock;


@end
