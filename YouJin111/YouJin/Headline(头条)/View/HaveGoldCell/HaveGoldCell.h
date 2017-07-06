//
//  HaveGoldCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/5.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"
#import "GoldAccountFoucsModel.h"

@protocol HaveGoldCellDelegaet;

@interface HaveGoldCell : UITableViewCell
@property (weak, nonatomic) IBOutlet HeadView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, retain) GoldAccountFoucsModel *model;
@property (nonatomic, assign) id<HaveGoldCellDelegaet> delegate;


- (void)updateFoucsModel:(GoldAccountFoucsModel *)model;

@end


@protocol HaveGoldCellDelegaet <NSObject>

@optional

- (void)haveGoldCellDidClickUserHead:(HaveGoldCell *)cell;

@end
