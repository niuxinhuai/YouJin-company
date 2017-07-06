//
//  OperationsTeamTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/24.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "OperationsTeamTableViewCell.h"
#import "OperationsTeamModel.h"

@implementation OperationsTeamTableViewCell

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
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 30*BOScreenH/1334, 120*BOScreenW/750, 120*BOScreenW/750)];
//        _headImage.image = [UIImage imageNamed:@"img_03"];
        _headImage.layer.cornerRadius = 3;
        _headImage.layer.masksToBounds = YES;
        [self addSubview:_headImage];
        
        _namesLabel = [[UILabel alloc]initWithFrame:CGRectMake(182*BOScreenW/750, 30*BOScreenH/1334, 518*BOScreenW/750, 30*BOScreenH/1334)];
//        _namesLabel.text = @"张三   CEO";
        _namesLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _namesLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_namesLabel];
        
        _detailsLabel = [[UILabel alloc]initWithFrame:CGRectMake(182*BOScreenW/750, 70*BOScreenH/1334, 518*BOScreenW/750, 80*BOScreenH/1334)];
//        _detailsLabel.text = @"张三网络创始人张三网络创始人张三网络创始人张三网络创始人张三网络创始人张三网络创始人张三网络创始人张三网络创始人张三网络创始人张三网络创始人张三网络创始人张三网络创始人张三网络创始人";
        _detailsLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        _detailsLabel.numberOfLines = 2;
        _detailsLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_detailsLabel];
        
//        //全文 按钮
        _anButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _anButton.frame = CGRectMake(182*BOScreenW/750, 150*BOScreenH/1334, 70*BOScreenW/750, 30*BOScreenH/1334);
        [_anButton setTitle:@"展开" forState:UIControlStateNormal];
        [_anButton setTitleColor:[UIColor colorWithHexString:@"#4c8cc4" alpha:1] forState:UIControlStateNormal];
        _anButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _anButton.selected = NO;
        _anButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_anButton addTarget:self action:@selector(changeSelectModelWithClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_anButton];
    }
    return self;
}
-(void)setItem:(OperationsTeamModel *)item
{
    _item = item;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
    self.namesLabel.text = [NSString stringWithFormat:@"%@   %@",item.name,item.job];
    self.detailsLabel.text = item.desc;
    NSLog(@"%@",_item.desc);
    if (_item.is_opend) {
        [self maxHeightWithShowAllDetailMessage];
    }else{
        [self minHeightWithShowMinLineDetailMessage];
    }
    
}
-(void)setSenderTag:(NSInteger)senderTag{
    _senderTag = senderTag;
    _anButton.tag = _senderTag;
}

-(void)changeSelectModelWithClick:(UIButton *)sender{
//    UIButton * button = [self.contentView viewWithTag:_senderTag];
//    button.selected =!button.selected;
    sender.selected =!sender.selected;
    if (sender.selected) {
      //  [button setTitle:@"闭合" forState:UIControlStateNormal];
        _item.is_opend = YES;
        
        
    }else{
       // [sender setTitle:@"展开" forState:UIControlStateNormal];
        _item.is_opend = NO;
        
    }
    if ([_delegate respondsToSelector:@selector(userDidSelectTableViewCell:)]) {
        [_delegate userDidSelectTableViewCell:self];
    }
    
}
-(CGFloat)sizeWithTitle:(NSString *)title withTitleFont:(UIFont *)font{
    
    CGFloat H = [title sizeWithAttributes:@{NSFontAttributeName:font}].height;
    
    return H;
}
-(void)maxHeightWithShowAllDetailMessage{
    CGRect rect = _detailsLabel.frame;
    rect.size.height = 120;
    _detailsLabel.frame = rect;
    _detailsLabel.numberOfLines = 0;
    [_anButton setTitle:@"闭合" forState:UIControlStateNormal];

}
-(void)minHeightWithShowMinLineDetailMessage{
    CGRect rect = _detailsLabel.frame;
    rect.size.height = 80*BOScreenH/1334;
    _detailsLabel.frame = rect;
    _detailsLabel.numberOfLines = 2;
    [_anButton setTitle:@"展开" forState:UIControlStateNormal];

}
@end
