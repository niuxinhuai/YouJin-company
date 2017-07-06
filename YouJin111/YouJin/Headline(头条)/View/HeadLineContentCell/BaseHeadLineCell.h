//
//  BaseHeadLineCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TopContentModel.h"

@interface BaseHeadLineCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *browseLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (nonatomic, retain) TopContentModel *content;


- (void)updateContent:(TopContentModel *)content;

@end
