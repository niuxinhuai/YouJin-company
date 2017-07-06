//
//  BankDepoTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/23.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BankDepoTableViewCell.h"
#import "YhcgTableV.h"

@implementation BankDepoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setItem:(YhcgTableV *)item
{
    _item = item;
    [self.Logeimages sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:[UIImage imageNamed:@"img_loadinga"]];
    self.lilvLabel.text = [NSString stringWithFormat:@"%@%@",item.apr_max,@"%"];
    
    int i = [item.bus_model intValue];
    switch (i)
    {
        case 1:
        {
            self.jrLabel.text = @"车贷";
            break;
        }
        case 2:
        {
            self.jrLabel.text = @"消费分期";
            break;
        }
        case 3:
        {
            self.jrLabel.text = @"供应链";
            break;
        }
        case 4:
        {
            self.jrLabel.text = @"房贷";
            break;
        }
        case 5:
        {
            self.jrLabel.text = @"企业贷";
            break;
        }
        case 6:
        {
            self.jrLabel.text = @"优选理财";
            break;
        }
        case 7:
        {
            self.jrLabel.text = @"票据抵押";
            break;
        }
        case 8:
        {
            self.jrLabel.text = @"融资租赁";
            break;
        }
        case 9:
        {
            self.jrLabel.text = @"藏品质押";
            break;
        }
        case 10:
        {
            self.jrLabel.text = @"个人信用贷";
            break;
        }
            
        default:
            break;
    }
    self.yhLabel.text = item.bank_name;
}
@end
