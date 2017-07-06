//
//  PtDaohangTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/6/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PtDaohangTableViewCell.h"
#import "PtDaohangModel.h"

@implementation PtDaohangTableViewCell

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
        _logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 20*BOScreenH/1334, 100*BOScreenW/750, 100*BOScreenW/750)];
//        _logoImage.image = [UIImage imageNamed:@"LOGO"];
        _logoImage.layer.cornerRadius = 8;
        _logoImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_logoImage];
        
        _naemLabel = [[UILabel alloc]initWithFrame:CGRectMake(160*BOScreenW/750, 50*BOScreenH/1334, 560*BOScreenW/750, 40*BOScreenH/1334)];
//        _naemLabel.text = @"一两理财一两理财";
        _naemLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _naemLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_naemLabel];
    }
    return self;
}
-(void)setItem:(PtDaohangModel *)item
{
    _item = item;
    [_logoImage sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
    _naemLabel.text = item.name;
}
@end
