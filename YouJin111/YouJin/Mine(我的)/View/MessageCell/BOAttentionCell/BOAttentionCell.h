//
//  BOAttentionCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/4.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AttentionModel.h"

@interface BOAttentionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (nonatomic, retain) AttentionModel *model;


- (void)updateModel:(AttentionModel *)model;

@end
