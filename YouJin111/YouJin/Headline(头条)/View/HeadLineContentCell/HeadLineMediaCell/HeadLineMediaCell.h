//
//  HeadLineMediaCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvertisementModel.h"

#define HEAD_LINE_AD_CELL_ID @"HeadLineMediaCell"

@interface HeadLineMediaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *sourceLable;
@property (weak, nonatomic) IBOutlet UILabel *extensionLable;


@property (nonatomic, retain) AdvertisementModel *model;

- (void)updateAdvertisement:(AdvertisementModel *)model;

@end
