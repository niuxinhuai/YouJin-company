//
//  EachGoldView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "EachGoldView.h"

@implementation EachGoldView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        //平台 当日年化 万份收益 提现速度
        UILabel * platformLable = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 120*BOScreenW/750, 30*BOScreenH/1334)];
        platformLable.text = @"平台";
        platformLable.font = [UIFont systemFontOfSize:13];
        platformLable.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        [self addSubview:platformLable];
        
        UIButton *typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        typeButton.frame = CGRectMake(232*BOScreenW/750, 25*BOScreenH/1334, 120*BOScreenW/750, 30*BOScreenH/1334);
        [typeButton setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
        typeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [typeButton setTitle:@"当日年化" forState:UIControlStateNormal];
        [typeButton setImage:[UIImage imageNamed:@"common_icon_paixu_nor"] forState:UIControlStateNormal];
        typeButton.imageEdgeInsets = UIEdgeInsetsMake(0, typeButton.frame.size.width - typeButton.imageView.frame.origin.x - typeButton.imageView.frame.size.width - 27*BOScreenW/750, 0, 0);
        typeButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(typeButton.frame.size.width - typeButton.imageView.frame.size.width ) + 30*BOScreenW/750, 0, 0);
        [self addSubview:typeButton];
        
        UIButton *tpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tpButton.frame = CGRectMake(422*BOScreenW/750, 25*BOScreenH/1334, 120*BOScreenW/750, 30*BOScreenH/1334);
        [tpButton setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
        tpButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [tpButton setTitle:@"万份收益" forState:UIControlStateNormal];
        [tpButton setImage:[UIImage imageNamed:@"common_icon_paixu_nor"] forState:UIControlStateNormal];
        tpButton.imageEdgeInsets = UIEdgeInsetsMake(0, tpButton.frame.size.width - tpButton.imageView.frame.origin.x - tpButton.imageView.frame.size.width- 27*BOScreenW/750, 0, 0);
        tpButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(tpButton.frame.size.width - tpButton.imageView.frame.size.width)+30*BOScreenW/750, 0, 0);
        [self addSubview:tpButton];

        UIButton *platfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        platfoButton.frame = CGRectMake(610*BOScreenW/750, 25*BOScreenH/1334, 120*BOScreenW/750, 30*BOScreenH/1334);
        [platfoButton setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
        platfoButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [platfoButton setTitle:@"提现速度" forState:UIControlStateNormal];
        [platfoButton setImage:[UIImage imageNamed:@"common_icon_paixu_nor"] forState:UIControlStateNormal];
        platfoButton.imageEdgeInsets = UIEdgeInsetsMake(0, platfoButton.frame.size.width - platfoButton.imageView.frame.origin.x - platfoButton.imageView.frame.size.width- 27*BOScreenW/750, 0, 0);
        platfoButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(platfoButton.frame.size.width - platfoButton.imageView.frame.size.width)+30*BOScreenW/750, 0, 0);
        [self addSubview:platfoButton];
        
        if (iPhone5)
        {
            typeButton.imageEdgeInsets = UIEdgeInsetsMake(0, typeButton.frame.size.width - typeButton.imageView.frame.origin.x - typeButton.imageView.frame.size.width + 58*BOScreenW/750, 0, 0);
            tpButton.imageEdgeInsets = UIEdgeInsetsMake(0, tpButton.frame.size.width - tpButton.imageView.frame.origin.x - tpButton.imageView.frame.size.width + 58*BOScreenW/750, 0, 0);
            platfoButton.imageEdgeInsets = UIEdgeInsetsMake(0, platfoButton.frame.size.width - platfoButton.imageView.frame.origin.x - platfoButton.imageView.frame.size.width + 58*BOScreenW/750, 0, 0);
        }
        
        //产品 发行平台 当日年化 万份收益
        UILabel * platformLables = [[UILabel alloc]initWithFrame:CGRectMake(BOScreenW+30*BOScreenW/750, 25*BOScreenH/1334, 120*BOScreenW/750, 30*BOScreenH/1334)];
        platformLables.text = @"产品";
        platformLables.font = [UIFont systemFontOfSize:13];
        platformLables.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        [self addSubview:platformLables];
        
        UILabel *releaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(BOScreenW + 232*BOScreenW/750, 25*BOScreenH/1334, 120*BOScreenW/750, 30*BOScreenH/1334)];
        releaseLabel.text = @"发行平台";
        releaseLabel.textAlignment = NSTextAlignmentCenter;
        releaseLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        releaseLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:releaseLabel];
        if (iPhone5)
        {
            releaseLabel.frame = CGRectMake(BOScreenW + 226*BOScreenW/750, 25*BOScreenH/1334, 130*BOScreenW/750, 30*BOScreenH/1334);
        }
        
        UIButton *tpButtons = [UIButton buttonWithType:UIButtonTypeCustom];
        tpButtons.frame = CGRectMake(BOScreenW + 436*BOScreenW/750, 25*BOScreenH/1334, 120*BOScreenW/750, 30*BOScreenH/1334);
        [tpButtons setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
        tpButtons.titleLabel.font = [UIFont systemFontOfSize:13];
        [tpButtons setTitle:@"当日年化" forState:UIControlStateNormal];
        [tpButtons setImage:[UIImage imageNamed:@"common_icon_paixu_nor"] forState:UIControlStateNormal];
        tpButtons.imageEdgeInsets = UIEdgeInsetsMake(0, tpButtons.frame.size.width - tpButtons.imageView.frame.origin.x - tpButtons.imageView.frame.size.width- 27*BOScreenW/750, 0, 0);
        tpButtons.titleEdgeInsets = UIEdgeInsetsMake(0, -(tpButtons.frame.size.width - tpButtons.imageView.frame.size.width)+30*BOScreenW/750, 0, 0);
        [self addSubview:tpButtons];
        
        UIButton *platfoButtons = [UIButton buttonWithType:UIButtonTypeCustom];
        platfoButtons.frame = CGRectMake(BOScreenW + 610*BOScreenW/750, 25*BOScreenH/1334, 120*BOScreenW/750, 30*BOScreenH/1334);
        [platfoButtons setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
        platfoButtons.titleLabel.font = [UIFont systemFontOfSize:13];
        [platfoButtons setTitle:@"万份收益" forState:UIControlStateNormal];
        [platfoButtons setImage:[UIImage imageNamed:@"common_icon_paixu_nor"] forState:UIControlStateNormal];
        platfoButtons.imageEdgeInsets = UIEdgeInsetsMake(0, platfoButtons.frame.size.width - platfoButtons.imageView.frame.origin.x - platfoButtons.imageView.frame.size.width- 27*BOScreenW/750, 0, 0);
        platfoButtons.titleEdgeInsets = UIEdgeInsetsMake(0, -(platfoButtons.frame.size.width - platfoButtons.imageView.frame.size.width)+30*BOScreenW/750, 0, 0);
        [self addSubview:platfoButtons];
        if (iPhone5)
        {
            tpButtons.imageEdgeInsets = UIEdgeInsetsMake(0, tpButtons.frame.size.width - tpButtons.imageView.frame.origin.x - tpButtons.imageView.frame.size.width + 58*BOScreenW/750, 0, 0);
            platfoButtons.imageEdgeInsets = UIEdgeInsetsMake(0, platfoButtons.frame.size.width - platfoButtons.imageView.frame.origin.x - platfoButtons.imageView.frame.size.width + 58*BOScreenW/750, 0, 0);
        }
        
        //分割线
        UIView *linViews = [[UIView alloc]initWithFrame:CGRectMake(0, 79*BOScreenH/1334, BOScreenW*2, 1*BOScreenH/1334)];
        linViews.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.1];
        [self addSubview:linViews];
        
    }
    return self;
}


@end
