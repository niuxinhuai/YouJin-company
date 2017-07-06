//
//  PTFWTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/25.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PTFWTableViewCell.h"
#import "PTfwTableviewModel.h"

@implementation PTFWTableViewCell

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
        _xingxArr = [NSMutableArray array];
        //平台logo
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(20*BOScreenW/750, 24*BOScreenH/1334, 120*BOScreenW/750, 120*BOScreenW/750)];
        //        _headImage.image = [UIImage imageNamed:@"logo_youjin"];
        _headImage.layer.cornerRadius = 10;
        _headImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_headImage];
        
        //平台名称
        _naemLabel = [[UILabel alloc]initWithFrame:CGRectMake(170*BOScreenW/750, 30*BOScreenH/1334, 430*BOScreenW/750, 40*BOScreenH/1334)];
        //        _naemLabel.text = @"一两理财";
        _naemLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _naemLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_naemLabel];
        
        //五角星
        for (int i = 0; i < 5; i ++)
        {
            _pentagramimage = [[UIImageView alloc]initWithFrame:CGRectMake(170*BOScreenW/750+i*(24*BOScreenW/750 + 6*BOScreenW/750), 86*BOScreenH/1334, 24*BOScreenW/750, 24*BOScreenW/750)];
            _pentagramimage.image = [UIImage imageNamed:@"evaluate_score_d"];
            _pentagramimage.tag = 100+i;
            [self.contentView addSubview:_pentagramimage];
            [_xingxArr addObject:_pentagramimage];
        }
        
        //星星级别
        _pointZeroLabel = [[UILabel alloc]initWithFrame:CGRectMake(324*BOScreenW/750, 86*BOScreenH/1334, 200*BOScreenW/750, 24*BOScreenH/1334)];
        //        _pointZeroLabel.text = @"5.0";
        _pointZeroLabel.textColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1];
        _pointZeroLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_pointZeroLabel];
        
        //主打产品
        _earningsLabel = [[UILabel alloc]initWithFrame:CGRectMake(170*BOScreenW/750, 126*BOScreenH/1334, 560*BOScreenW/750, 30*BOScreenH/1334)];
        //        _earningsLabel.text = @"主打产品:平台系统";
        _earningsLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
        _earningsLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:_earningsLabel];
        
        //校园分期
        _installmentLabel = [[UILabel alloc]initWithFrame:CGRectMake(626*BOScreenW/750, 38*BOScreenH/1334, 104*BOScreenW/750, 35*BOScreenH/1334)];
        //        _installmentLabel.text = @"校园分期";
        _installmentLabel.textColor = [UIColor colorWithHexString:@"#3bb5f4" alpha:1];
        _installmentLabel.font  = [UIFont systemFontOfSize:10];
        _installmentLabel.textAlignment = NSTextAlignmentCenter;
        _installmentLabel.layer.cornerRadius = 2;
        _installmentLabel.layer.masksToBounds = YES;
        _installmentLabel.layer.borderWidth = 1;
        _installmentLabel.layer.borderColor = [UIColor colorWithHexString:@"#3bb5f4" alpha:1].CGColor;
        [self.contentView addSubview:_installmentLabel];
        if (iPhone5)
        {
            _installmentLabel.frame = CGRectMake(622*BOScreenW/750, 38*BOScreenH/1334, 108*BOScreenW/750, 33*BOScreenH/1334);
        }
        
        //地址
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(500*BOScreenW/750, 86*BOScreenH/1334, 230*BOScreenW/750, 30*BOScreenH/1334)];
        //        _addressLabel.text = @"浙江，杭州";
        _addressLabel.textColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1];
        _addressLabel.font = [UIFont systemFontOfSize:11];
        _addressLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_addressLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(170*BOScreenW/750, 172*BOScreenH/1334, 560*BOScreenW/750, 1*BOScreenH/1334)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
        [self.contentView addSubview:lineView];
        
        //介绍
        _introduceLabel = [[UILabel alloc]initWithFrame:CGRectMake(170*BOScreenW/750, 188*BOScreenH/1334, 560*BOScreenW/750, 30*BOScreenH/1334)];
        //        _introduceLabel.text = @"典型客户：金顶控股";
        _introduceLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
        _introduceLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:_introduceLabel];
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 234*BOScreenH/1334, BOScreenW, 16*BOScreenH/1334)];
        bottomView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        [self.contentView addSubview:bottomView];
    }
    return self;
}
- (void)setItem:(PTfwTableviewModel *)item
{
    _item = item;
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
    _naemLabel.text = item.pname;
    _pointZeroLabel.text = [NSString stringWithFormat:@"%@分",item.score];
    //判断评分 判断评分是几评级星星显示的是那个图片
    int j = [item.score intValue]%6;
    [self setCount:j];
    
    _installmentLabel.text = item.desc;
    _addressLabel.text = [NSString stringWithFormat:@"%@,%@",item.sheng,item.shi];
    _earningsLabel.text = [NSString stringWithFormat:@"主打产品:%@",item.pro_name];
    _introduceLabel.text = [NSString stringWithFormat:@"典型客户:%@",item.example];
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
