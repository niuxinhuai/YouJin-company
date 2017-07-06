//
//  AttentionTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "AttentionTableViewCell.h"
#import "GuanzhuBangModel.h"

@implementation AttentionTableViewCell

- (void)awakeFromNib
{
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
        _yesORon = 1;
        _frontImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 20*BOScreenH/1334, 100*BOScreenW/750, 100*BOScreenW/750)];
//        _frontImage.image = [UIImage imageNamed:@"logo_youjin"];
        _frontImage.layer.cornerRadius = 8;
        _frontImage.layer.masksToBounds = YES;
        [self addSubview:_frontImage];
        
        CGFloat frontImageX = CGRectGetMaxX(_frontImage.frame) + 30*BOScreenW/750;
        _upLabel = [[UILabel alloc]initWithFrame:CGRectMake(frontImageX, 30*BOScreenH/1334, 200*BOScreenW/750, 30*BOScreenH/1334)];
//        _upLabel.text = @"一两理财";
        _upLabel.font = [UIFont systemFontOfSize:16];
        _upLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [self addSubview:_upLabel];
        
        CGFloat upLabelY = CGRectGetMaxY(_upLabel.frame) + 20*BOScreenH/1334;
        _downLabel = [[UILabel alloc]initWithFrame:CGRectMake(frontImageX, upLabelY, 200*BOScreenW/750, 30*BOScreenH/1334)];
//        _downLabel.text = @"关注人数  1186";
        _downLabel.font = [UIFont systemFontOfSize:12];
        _downLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        [self addSubview:_downLabel];
        
        _backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backbutton.frame = CGRectMake(BOScreenW-130*BOScreenW/750, 47*BOScreenH/1334, 50, 23);
//        [_backbutton setBackgroundImage:[UIImage imageNamed:@"common_btn_guanzhu_nor"] forState:UIControlStateNormal];
        [_backbutton addTarget:self action:@selector(backbuttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backbutton];
    }
    return self;
}
-(void)setItem:(GuanzhuBangModel *)item
{
    _item = item;
    [_frontImage sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
    _upLabel.text = item.name;
    _downLabel.text = [NSString stringWithFormat:@"关注人数  %@",item.fans];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_downLabel.text];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5a00" alpha:1] range:NSMakeRange(5,_downLabel.text.length - 5)];
    _downLabel.attributedText = str;
    
    if ([item.is_focus intValue] == 1)
    {
        [_backbutton setBackgroundImage:[UIImage imageNamed:@"common_btn_guanzhu_prer"] forState:UIControlStateNormal];//已关注
                _yesORon = 0;
    }else
    {
         [_backbutton setBackgroundImage:[UIImage imageNamed:@"common_btn_guanzhu_nor"] forState:UIControlStateNormal];//关注
                _yesORon = 1;
    }
}
- (void)backbuttonClick
{
//    NSString *stringInt = _item.fans;
//    int ivalue = [stringInt intValue];
//    _jishu = ivalue;
     if (_yesORon == 1)
    {
         [_backbutton setBackgroundImage:[UIImage imageNamed:@"common_btn_guanzhu_prer"] forState:UIControlStateNormal];//已关注
        _item.fans = @([self.item.fans intValue] + 1);
        _downLabel.text = [NSString stringWithFormat:@"关注人数  %@",_item.fans];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_downLabel.text];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5a00" alpha:1] range:NSMakeRange(5,_downLabel.text.length - 5)];
        _downLabel.attributedText = str;
        
        [self payAttentionToFriendsData];
        _yesORon = 0;
    }else
    {
         [_backbutton setBackgroundImage:[UIImage imageNamed:@"common_btn_guanzhu_nor"] forState:UIControlStateNormal];//关注
        _item.fans = @([self.item.fans intValue] - 1);
        _downLabel.text = [NSString stringWithFormat:@"关注人数  %@",_item.fans];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_downLabel.text];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5a00" alpha:1] range:NSMakeRange(5,_downLabel.text.length - 5)];
        _downLabel.attributedText = str;
        [self cancellationNoticeData];
        _yesORon = 1;
    }
}
//关注网贷平台
- (void)payAttentionToFriendsData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"uid"] = USERUID;
    parameters[@"ptid"] = _item.ptid;
    [manager POST:[NSString stringWithFormat:@"%@App/focusPingtai",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            NSLog(@"返回信息描述88888%@",responseObject[@"msg"]);
        }
        else
        {
            NSLog(@"返回信息描述999999%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
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
