//
//  GuanzhuTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/6/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "GuanzhuTableViewCell.h"
#import "GuanzhuLIebiaoModel.h"

@implementation GuanzhuTableViewCell

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
//        _headImage.image = [UIImage imageNamed:@"logo_youjin"];
        _headImage.layer.cornerRadius = 8;
        _headImage.layer.masksToBounds = YES;
//        _headImage.layer.borderWidth = 1;
//        _headImage.layer.borderColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1].CGColor;
        [self addSubview:_headImage];
        
        //平台名称
        _naemLabel = [[UILabel alloc]initWithFrame:CGRectMake(170*BOScreenW/750, 35*BOScreenH/1334, 430*BOScreenW/750, 40*BOScreenH/1334)];
//        _naemLabel.text = @"一两理财";
        _naemLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _naemLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:_naemLabel];
        
        //五角星
        for (int i = 0; i < 5; i ++)
        {
            _pentagramimage = [[UIImageView alloc]initWithFrame:CGRectMake(170*BOScreenW/750+i*(24*BOScreenW/750 + 6*BOScreenW/750), 100*BOScreenH/1334, 24*BOScreenW/750, 24*BOScreenW/750)];
            _pentagramimage.image = [UIImage imageNamed:@"evaluate_score_d"];
            _pentagramimage.tag = 100+i;
            [_xingxArr addObject:_pentagramimage];
            [self addSubview:_pentagramimage];
        }
        
        //星星级别
        _pointZeroLabel = [[UILabel alloc]initWithFrame:CGRectMake(324*BOScreenW/750, 100*BOScreenH/1334, 200*BOScreenW/750, 24*BOScreenH/1334)];
//        _pointZeroLabel.text = @"5.0";
        _pointZeroLabel.textColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1];
        _pointZeroLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_pointZeroLabel];
        
        //36人关注
        _installmentLabel = [[UILabel alloc]initWithFrame:CGRectMake(515*BOScreenW/750, 39*BOScreenH/1334, 180*BOScreenW/750, 30*BOScreenH/1334)];
//        _installmentLabel.text = @"36人关注";
        _installmentLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        _installmentLabel.font  = [UIFont systemFontOfSize:12];
        _installmentLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_installmentLabel];
        
        //绿心
        _heartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _heartButton.frame = CGRectMake(705*BOScreenW/750, 44*BOScreenH/1334, 25*BOScreenW/750, 20*BOScreenH/1334);
        [_heartButton setBackgroundImage:[UIImage imageNamed:@"icon_aixin"] forState:UIControlStateNormal];
        [_heartButton addTarget:self action:@selector(heartButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_heartButton];
    }
    return self;
}
-(void)setItem:(GuanzhuLIebiaoModel *)item
{
    _item = item;
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
    _naemLabel.text = item.name;
    _pointZeroLabel.text = [NSString stringWithFormat:@"%@分",item.score];
    
    //判断评分 判断评分是几评级星星显示的是那个图片
    int j = [item.score intValue]%6;
    [self setCount:j];
    
    _installmentLabel.text = [NSString stringWithFormat:@"%@人关注",item.fans];
    
    NSLog(@"item.is_focus...%@",item.is_focus);
    if ([item.is_focus isEqualToString:@"1"])
    {
        [_heartButton setBackgroundImage:[UIImage imageNamed:@"icon_aixin"] forState:UIControlStateNormal];
        _heartButton.userInteractionEnabled = YES;
    }
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
//绿心的点击事件
- (void)heartButtonClick
{
    _heartButton.userInteractionEnabled = NO;
    [_heartButton setBackgroundImage:[UIImage imageNamed:@"icon_aixin_d"] forState:UIControlStateNormal];
    
    _item.fans = @([self.item.fans intValue] - 1);
    _installmentLabel.text = [NSString stringWithFormat:@"%@人关注",_item.fans];
    [self cancellationNoticeData];
}
//取消关注网贷平台
- (void)cancellationNoticeData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"uid"] = USERUID;
    parameters[@"ptid"] = _item.ptid;
    [manager POST:[NSString stringWithFormat:@"%@App/cancelFocusPt",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            NSLog(@"返回信息描述666666%@",responseObject[@"msg"]);
        }
        else
        {
            NSLog(@"返回信息描述77777%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}

@end
