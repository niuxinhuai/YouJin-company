//
//  MoresbankTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/31.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MoresbankTableViewCell.h"

@implementation MoresbankTableViewCell

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
        _logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 15*BOScreenH/1334, 90*BOScreenW/750, 90*BOScreenW/750)];
        [self addSubview:_logoImage];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(150*BOScreenW/750, 40*BOScreenH/1334, 500*BOScreenW/750, 40*BOScreenH/1334)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [self addSubview:_nameLabel];
    }
    return self;
}
@end
