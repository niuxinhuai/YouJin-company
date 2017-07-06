//
//  CollectionCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/26.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopContentModel.h"

@interface CollectionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;



@property (nonatomic, retain) TopContentModel *content;

- (void)updateContent:(TopContentModel *)content;

@end
