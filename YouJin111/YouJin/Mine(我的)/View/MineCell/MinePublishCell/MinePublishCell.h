//
//  MinePublishCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/31.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublishModel.h"

@interface MinePublishCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *starCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;


@property (nonatomic, retain) PublishModel *model;

- (void)updateModel:(PublishModel *)model;


@end
