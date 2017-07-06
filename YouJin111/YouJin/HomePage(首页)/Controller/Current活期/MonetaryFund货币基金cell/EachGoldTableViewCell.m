//
//  EachGoldTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/8.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "EachGoldTableViewCell.h"
#import "CurrentModel.h"

@implementation EachGoldTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setItem:(CurrentModel *)item
{
    _item = item;
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:[UIImage imageNamed:@"img_loadinga"]];
    self.oneDayLabel.text = [NSString stringWithFormat:@"%@%@",item.today_apr,@"%"];
    self.copiesLabel.text = [NSString stringWithFormat:@"%@元",item.wf_lixi];
    self.withdrawalLabel.text = item.speed;
}

- (void)updateIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    switch (indexPath.row) {
        case 0: self.colorPieceView.backgroundColor = [UIColor colorWithIntRed:225 green:220 blue:98 alpha:1];
            break;
        case 1: self.colorPieceView.backgroundColor = [UIColor colorWithIntRed:208 green:208 blue:217 alpha:1];
            break;
        case 2: self.colorPieceView.backgroundColor = [UIColor colorWithIntRed:255 green:176 blue:109 alpha:1];
            break;
        default:
            break;
    }
    self.colorPieceView.hidden = indexPath.row > 2;
}
@end
