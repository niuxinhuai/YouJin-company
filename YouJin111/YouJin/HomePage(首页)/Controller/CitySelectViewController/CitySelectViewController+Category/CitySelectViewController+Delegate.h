//
//  CitySelectViewController+Delegate.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CitySelectViewController.h"
#import "HotCityCell.h"
#import "NomalCityCell.h"

@interface CitySelectViewController (Delegate)<UITableViewDelegate, UITableViewDataSource,LocationManagerDelegate,HotCityCellDelegate>

@end
