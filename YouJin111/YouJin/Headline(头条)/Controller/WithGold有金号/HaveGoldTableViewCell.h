//
//  HaveGoldTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoldAccountFoucsModel.h"

@interface HaveGoldTableViewCell : UITableViewCell


@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UILabel *nicknameLabel;
@property (nonatomic, retain) UILabel *detailLabel;


@property (nonatomic, retain) GoldAccountFoucsModel *model;


- (void)updateFoucsModel:(GoldAccountFoucsModel *)model;


@end
