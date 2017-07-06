//
//  TheDailyTaskTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "TheDailyTaskTableViewCell.h"
#import "UIView+Frame.h"
#import "DailyTaskModel.h"

@implementation TheDailyTaskTableViewCell

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
        self.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        //底部圆角与阴影view
        UIView *whiBGView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 0, 690*BOScreenW/750, 160*BOScreenH/1334)];
        whiBGView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiBGView];
        //设置阴影
        [whiBGView makeCornerWithCornerRadius:8];
        [whiBGView makeShadowWithShadowColor:[UIColor blackColor] shadowOffset:CGSizeMake(0,2) shadowRadius:2 shadowOpacity:.2 shadowPath:[UIBezierPath bezierPathWithRoundedRect:whiBGView.bounds cornerRadius:9].CGPath];
        //左边的两个色块圆角view
        _leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200*BOScreenW/750, 160*BOScreenH/1334)];
        _leftView.backgroundColor = [UIColor redColor];
        [whiBGView addSubview:_leftView];
        //设置两个圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_leftView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(8, 8)]; // UIRectCornerBottomRight通过这个设置
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = _leftView.bounds;
        maskLayer.path = maskPath.CGPath;
        _leftView.layer.mask = maskLayer;
        
        //左边的的imageloge
        _logeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(40*BOScreenW/750, 20*BOScreenH/1334, 120*BOScreenW/750, 120*BOScreenW/750)];
        [_leftView addSubview:_logeImageView];
        
        //每日签到  邀请好友
        CGFloat  leftViewX = CGRectGetMaxX(_leftView.frame)+30*BOScreenW/750;
        _sevenOnLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftViewX, 40*BOScreenH/1334, 270*BOScreenW/750, 40*BOScreenH/1334)];
        _sevenOnLabel.font = [UIFont systemFontOfSize:16];
        _sevenOnLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
        [whiBGView addSubview:_sevenOnLabel];
        
        //奖励9000u币
        _awardLabel = [[UILabel alloc]init];
        _awardLabel.text = @"奖励:  9000";
        _awardLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        _awardLabel.font = [UIFont systemFontOfSize:13];
        _awardLabel.frame = CGRectMake(leftViewX, 92*BOScreenH/1334, 270*BOScreenW/750,30*BOScreenH/1334);
        [whiBGView addSubview:_awardLabel];
        
        //去签到
        _goToBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goToBtn.frame = CGRectMake(540*BOScreenW/750, 82*BOScreenH/1334, 130*BOScreenW/750, 48*BOScreenH/1334);
        [_goToBtn setTitleColor:[UIColor colorWithHexString:@"#ff5a00" alpha:1] forState:UIControlStateNormal];
        _goToBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_goToBtn setBackgroundImage:[UIImage imageNamed:@"mission_btn_go_nor"] forState:UIControlStateNormal];
        [whiBGView addSubview:_goToBtn];
        //放在button上面的view（对整个cell可点击的处理）
        UIView *coverView = [[UIView alloc]initWithFrame:CGRectMake(540*BOScreenW/750, 82*BOScreenH/1334, 130*BOScreenW/750, 48*BOScreenH/1334)];
        [whiBGView addSubview:coverView];
        
        //0/5
        _fiveLabel = [[UILabel alloc]initWithFrame:CGRectMake(540*BOScreenW/750, 92*BOScreenH/1334, 130*BOScreenW/750, 30*BOScreenH/1334)];
        _fiveLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
        _fiveLabel.font = [UIFont systemFontOfSize:14];
        _fiveLabel.textAlignment = NSTextAlignmentRight;
        [whiBGView addSubview:_fiveLabel];
        
        //分享任务 3/5的Label
        _oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(540*BOScreenW/750, 92*BOScreenH/1334, 130*BOScreenW/750, 30*BOScreenH/1334)];
        _oneLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
        _oneLabel.font = [UIFont systemFontOfSize:14];
        _oneLabel.textAlignment = NSTextAlignmentRight;
        [whiBGView addSubview:_oneLabel];
        
//        //分享任务 3/5的button
//        _oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _oneButton.frame = CGRectMake(540*BOScreenW/750, 92*BOScreenH/1334, 130*BOScreenW/750, 30*BOScreenH/1334);
//        [whiBGView addSubview:_oneButton];
        
        //更多每日任务，请戳这里～
        _lastLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftViewX, 60*BOScreenH/1334, 440*BOScreenW/750, 40*BOScreenH/1334)];
        _lastLabel.text = @"更多每日任务，请戳这里～";
        _lastLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
        _lastLabel.font = [UIFont systemFontOfSize:16];
        [whiBGView addSubview:_lastLabel];

    }
    return self;
}
-(void)setItem:(DailyTaskModel *)item
{
    _item = item;
    
}
@end
