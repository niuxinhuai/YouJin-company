//
//  NomalCityCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"

@interface NomalCityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@property (nonatomic, strong) CityDetailModel *model;

- (void)updateCityDetailModel:(CityDetailModel *)model;

@end
