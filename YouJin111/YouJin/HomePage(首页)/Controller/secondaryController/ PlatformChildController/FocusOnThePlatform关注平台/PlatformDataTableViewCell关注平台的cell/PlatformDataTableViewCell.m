//
//  PlatformDataTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformDataTableViewCell.h"
#import "ConsumptionFq.h"

@implementation PlatformDataTableViewCell

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
        _xingxArr = [[NSMutableArray alloc]init];
        //平台logo
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(20*BOScreenW/750, 24*BOScreenH/1334, 120*BOScreenW/750, 120*BOScreenW/750)];
        _headImage.image = [UIImage imageNamed:@"logo_youjin"];
        _headImage.layer.cornerRadius = 10;
        _headImage.layer.masksToBounds = YES;
        _headImage.layer.borderWidth = 1;
        _headImage.layer.borderColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1].CGColor;
        [self addSubview:_headImage];
        
        //平台名称
        _naemLabel = [[UILabel alloc]initWithFrame:CGRectMake(170*BOScreenW/750, 30*BOScreenH/1334, 430*BOScreenW/750, 40*BOScreenH/1334)];
        _naemLabel.text = @"一两理财";
        _naemLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _naemLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:_naemLabel];
        
        //五角星
        for (int i = 0; i < 5; i ++)
        {
            _pentagramimage = [[UIImageView alloc]initWithFrame:CGRectMake(170*BOScreenW/750+i*(24*BOScreenW/750 + 6*BOScreenW/750), 86*BOScreenH/1334, 24*BOScreenW/750, 24*BOScreenW/750)];
            _pentagramimage.image = [UIImage imageNamed:@"evaluate_score_d"];
            _pentagramimage.tag = 100+i;
            [_xingxArr addObject:_pentagramimage];
            [self addSubview:_pentagramimage];
        }
        
        //星星级别
        _pointZeroLabel = [[UILabel alloc]initWithFrame:CGRectMake(324*BOScreenW/750, 86*BOScreenH/1334, 200*BOScreenW/750, 24*BOScreenH/1334)];
        _pointZeroLabel.text = @"5.0";
        _pointZeroLabel.textColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1];
        _pointZeroLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_pointZeroLabel];
        
        //最新活动-新手专属高收益年化18%投资项目
        UILabel *earningsLabel = [[UILabel alloc]initWithFrame:CGRectMake(170*BOScreenW/750, 135*BOScreenH/1334, 530*BOScreenW/750,30*BOScreenH/1334)];
        earningsLabel.text = @"最新活动-新手专属高收益年化18%投资项目";
        earningsLabel.textColor = [UIColor colorWithHexString:@"#fa9a3a" alpha:1];
        earningsLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:earningsLabel];
        
        //36人关注
        _installmentLabel = [[UILabel alloc]initWithFrame:CGRectMake(515*BOScreenW/750, 39*BOScreenH/1334, 180*BOScreenW/750, 30*BOScreenH/1334)];
        _installmentLabel.text = @"36人关注";
        _installmentLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        _installmentLabel.font  = [UIFont systemFontOfSize:12];
        _installmentLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_installmentLabel];
        
        //36人关注 后面的绿心
        UIImageView *heartImage = [[UIImageView alloc]initWithFrame:CGRectMake(705*BOScreenW/750, 44*BOScreenH/1334, 25*BOScreenW/750, 20*BOScreenH/1334)];
        heartImage.image = [UIImage imageNamed:@"icon_aixin"];
        [self addSubview:heartImage];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 189*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
        [self addSubview:lineView];
        
        //变额
        CGFloat lineViewY = CGRectGetMaxY(lineView.frame)+24*BOScreenH/1334;
        _changeLabel = [[UILabel alloc]initWithFrame:CGRectMake(170*BOScreenW/750, lineViewY, 530*BOScreenW/750, 25*BOScreenH/1334)];
        _changeLabel.text = @"变额人寿保险与传统人寿保险主要区别于联系";
        _changeLabel.font = [UIFont systemFontOfSize:12];
        _changeLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
        [self addSubview:_changeLabel];
        
        //动态消息
        _dynamicLabel = [[UILabel alloc]initWithFrame:CGRectMake(170*BOScreenW/750, lineViewY+47*BOScreenH/1334, 530*BOScreenW/750, 25*BOScreenH/1334)];
        _dynamicLabel.text = @"动态消息动态消息动态消息";
        _dynamicLabel.font = [UIFont systemFontOfSize:12];
        _dynamicLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
        [self addSubview:_dynamicLabel];
        
        //小圆点
        UIView *roundView = [[UIView alloc]initWithFrame:CGRectMake(150*BOScreenW/750, lineViewY+7*BOScreenH/1334, 10*BOScreenW/750, 10*BOScreenW/750)];
        roundView.backgroundColor = [UIColor colorWithHexString:@"#51b4ff" alpha:1];
        roundView.layer.cornerRadius = 2.9;
        roundView.layer.masksToBounds = YES;
        [self addSubview:roundView];
        
        UIView *roundsView = [[UIView alloc]initWithFrame:CGRectMake(150*BOScreenW/750, lineViewY+54*BOScreenH/1334, 10*BOScreenW/750, 10*BOScreenW/750)];
        roundsView.backgroundColor = [UIColor colorWithHexString:@"#fa9531" alpha:1];
        roundsView.layer.cornerRadius = 2.9;
        roundsView.layer.masksToBounds = YES;
        [self addSubview:roundsView];
        
        if (iPhone5)
        {
             roundView.layer.cornerRadius = 2.7;
             roundsView.layer.cornerRadius = 2.7;
        }
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(712*BOScreenW/750, lineViewY+22*BOScreenH/1334, 18*BOScreenW/750, 28*BOScreenH/1334)];
        arrowImage.image = [UIImage imageNamed:@"common_goto"];
        [self addSubview:arrowImage];
    }
    return self;
}
-(void)setItem:(ConsumptionFq *)item
{
    _item = item;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
    self.naemLabel.text = item.name;
    self.pointZeroLabel.text = item.score;
    //判断评分 判断评分是几评级星星显示的是那个图片
    int j = [item.score intValue]%6+2;
    [self setCount:j];
//    self.percentageLabel.text = [NSString stringWithFormat:@"%@~%@%@",item.apr_min,item.apr_max,@"%"];
//    self.installmentLabel.text = item.type;
//    self.addressLabel.text = [NSString stringWithFormat:@"%@,%@",item.province,item.city];
//    self.introduceLabel.text = item.pt_desc;
//    if (item.pt_desc.length == 0)
//    {
//        self.introduceLabel.text = @"啊哦😯没有数据呀";
//    }
}
#pragma mark---设置星星显示与隐藏---
- (void)setCount:(int)count
{
    int xingxCount = (int)_xingxArr.count;
    
    for (int i = 0; i < xingxCount; i++)
    {
        UIImageView *round = _xingxArr[i];
        if (i < count)
        {
            round.image = [UIImage imageNamed:@"evaluate_score_h"];
        } else
        {
            round.image = [UIImage imageNamed:@"evaluate_score_d"];
        }
    }
}

@end
