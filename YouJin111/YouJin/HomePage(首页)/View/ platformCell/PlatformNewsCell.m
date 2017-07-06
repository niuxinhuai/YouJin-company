//
//  PlatformNewsCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/20.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformNewsCell.h"
#import "PlatNewsModel.h"
@interface PlatformNewsCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
@implementation PlatformNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _iconImageV.layer.cornerRadius = 3;
    _iconImageV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setItem:(PlatNewsModel *)item {
    _item = item;
}
@end
