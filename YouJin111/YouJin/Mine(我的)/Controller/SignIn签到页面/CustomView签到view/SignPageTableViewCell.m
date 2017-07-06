//
//  SignPageTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "SignPageTableViewCell.h"

@implementation SignPageTableViewCell

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
       //下面白色的view
        UIView *whiView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 0*BOScreenH/1334, 690*BOScreenW/750, 280*BOScreenH/1334)];
        whiView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiView];
        //设置阴影
        whiView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
        whiView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        whiView.layer.shadowOpacity = 0.2;//阴影透明度，默认0
        whiView.layer.shadowRadius = 2;//阴影半径，默认3
        whiView.layer.cornerRadius = 8;//设置圆角

    
        //上面的大图片
        UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30*BOScreenW/750, 0, 690*BOScreenW/750, 220*BOScreenH/1334)];
        picImageView.image = [UIImage imageNamed:@"toutiaobanner"];
        [self addSubview:picImageView];
        //设置上面的两个圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:picImageView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)]; // UIRectCornerBottomRight通过这个设置
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = picImageView.bounds;
        maskLayer.path = maskPath.CGPath;
        picImageView.layer.mask = maskLayer;
    }
    return self;
}
@end
