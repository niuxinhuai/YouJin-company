//
//  FinancingSituationView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "FinancingSituationView.h"
#import "RongZiModel.h"

@implementation FinancingSituationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];

        //时间
        _timesLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 20*BOScreenH/1334, 160*BOScreenW/750, 40*BOScreenH/1334)];
//        _timesLabel.text = @"2016-08-20";
        _timesLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _timesLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_timesLabel];
        
        //天使轮
        _anAngelroundLabel = [[UILabel alloc]initWithFrame:CGRectMake(230*BOScreenW/750, 20*BOScreenH/1334, 110*BOScreenW/750, 40*BOScreenH/1334)];
//        _anAngelroundLabel.text = @"天使轮";
        _anAngelroundLabel.textColor = [UIColor colorWithHexString:@"#5184c2" alpha:1];
        _anAngelroundLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_anAngelroundLabel];
        
        //数百万人民币
        _moreMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(380*BOScreenW/750, 20*BOScreenH/1334, 200*BOScreenW/750, 40*BOScreenH/1334)];
//        _moreMoneyLabel.text = @"数百万人民币";
        _moreMoneyLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _moreMoneyLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_moreMoneyLabel];
        
        //投资方
        _investorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _investorButton.frame = CGRectMake(BOScreenW-150*BOScreenW/750, 20*BOScreenH/1334, 120*BOScreenW/750, 40*BOScreenH/1334);
        [_investorButton setImage:[UIImage imageNamed:@"common_icon_xiala"] forState:UIControlStateNormal];
        _investorButton.imageEdgeInsets = UIEdgeInsetsMake(0, _investorButton.frame.size.width - _investorButton.imageView.frame.origin.x - _investorButton.imageView.frame.size.width + 30*BOScreenW/750, 0, 0);
        _investorButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(_investorButton.frame.size.width - _investorButton.imageView.frame.size.width ) + 30*BOScreenW/750, 0, 0);
        [_investorButton setTitle:@"投资方" forState:UIControlStateNormal];
        _investorButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_investorButton setTitleColor:[UIColor colorWithHexString:@"#333333" alpha:1] forState:UIControlStateNormal];
        [self addSubview:_investorButton];
    }
    return self;
}
-(void)setItem:(RongZiModel *)item
{
    _item = item;
    self.timesLabel.text = item.rongzi_date;
    self.anAngelroundLabel.text = item.level;
    self.moreMoneyLabel.text = item.money;
}
@end
