//
//  SearchHistoryTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/6/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "SearchHistoryTableViewCell.h"

@implementation SearchHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIImageView *timeImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 20*BOScreenH/1334, 40*BOScreenW/750, 40*BOScreenW/750)];
        timeImage.image = [UIImage imageNamed:@"icon_lishi"];
        [self.contentView addSubview:timeImage];
        
        _historyLabel = [[UILabel alloc]initWithFrame:CGRectMake(90*BOScreenW/750, 20*BOScreenH/1334, 630*BOScreenW/750, 40*BOScreenH/1334)];
//        _historyLabel.text = @"一两理财一两理财一两理财一两理财一两理财一两理财一两理财一两理财一两理财一两理财一两理财一两理财一两理财一两理财一两理财一两理财一两理财";
        _historyLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _historyLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_historyLabel];
    }
    return self;
}
@end
