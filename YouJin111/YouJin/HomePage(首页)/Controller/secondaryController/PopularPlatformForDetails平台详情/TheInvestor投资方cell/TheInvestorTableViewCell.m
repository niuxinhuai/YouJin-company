//
//  TheInvestorTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/3.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "TheInvestorTableViewCell.h"
#import "RongZiModel.h"

@implementation TheInvestorTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor colorWithHexString:@"#fafafa" alpha:1];
        
        //银行
        _bankLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 10*BOScreenH/1334, BOScreenW - 60*BOScreenW/750, 40*BOScreenH/1334)];
//        _bankLabel.text = @"渣打银行，中国互联网金融科技基金。";
        _bankLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _bankLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_bankLabel];
    }
    return self;
}
-(void)setItem:(RongZiModel *)item
{
    _item = item;
    self.bankLabel.text = item.tender;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
