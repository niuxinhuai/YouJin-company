//
//  SystemNoticeCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemNoticeModel.h"

@interface SystemNoticeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@property (nonatomic, retain) SystemNoticeModel *model;


- (void)updateSystemNoticeModel:(SystemNoticeModel *)model;


@end
