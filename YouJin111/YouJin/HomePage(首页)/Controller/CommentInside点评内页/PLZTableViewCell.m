//
//  PLZTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PLZTableViewCell.h"
#import "HuifuModel.h"

@implementation PLZTableViewCell

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
        //头像
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(20*BOScreenW/750, 30*BOScreenH/1334, 70*BOScreenW/750, 70*BOScreenW/750)];
//        _headImage.image = [UIImage imageNamed:@"LOGO"];
        _headImage.layer.cornerRadius = 17;
        if (iPhone6P)
        {
            _headImage.layer.cornerRadius = 25;
        }
        if (iPhone5)
        {
            _headImage.layer.cornerRadius = 19.5;
        }
        _headImage.layer.masksToBounds = YES;
        [self addSubview:_headImage];
        
        //昵称按钮
        _nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nameButton.frame = CGRectMake(110*BOScreenW/750, 30*BOScreenH/1334, 500*BOScreenW/750, 30*BOScreenH/1334);
//        [_nameButton setTitle:@"昵称ID昵称" forState:UIControlStateNormal];
        [_nameButton setTitleColor:[UIColor colorWithHexString:@"#4c8cc4" alpha:1] forState:UIControlStateNormal];
//        _nameButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _nameButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        [_nameButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self addSubview:_nameButton];
        
        //赞的图片
        _zanImage = [[UIImageView alloc]initWithFrame:CGRectMake(692*BOScreenW/750, 30*BOScreenH/1334, 28*BOScreenW/750, 28*BOScreenW/750)];
//        _zanImage.image = [UIImage imageNamed:@"nav_icon_zan_nor"];
        [self addSubview:_zanImage];
        //赞的个数
        _zannumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(535*BOScreenW/750, 30*BOScreenH/1334, 150*BOScreenW/750, 30*BOScreenH/1334)];
//        _zannumberLabel.text = @"361";
        _zannumberLabel.textColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1];
        _zannumberLabel.font = [UIFont systemFontOfSize:12];
        _zannumberLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_zannumberLabel];
        
        //赞的button
        _zanbuttonCk = [UIButton buttonWithType:UIButtonTypeCustom];
        _zanbuttonCk.frame = CGRectMake(620*BOScreenW/750, 30*BOScreenH/1334, 100*BOScreenW/750, 30*BOScreenH/1334);
        [_zanbuttonCk addTarget:self action:@selector(zanbuttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_zanbuttonCk];
     
        //详情
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(110*BOScreenW/750, 70*BOScreenH/1334, 600*BOScreenW/750, 70*BOScreenH/1334)];
//        _detailLabel.text = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈啊哈啊哈哈哈哈啊哈哈哈啊哈哈哈哈啊哈";
        _detailLabel.numberOfLines = 0;
        _detailLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _detailLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_detailLabel];
        
        //时间
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(110*BOScreenW/750, 160*BOScreenH/1334, 500*BOScreenW/750, 30*BOScreenH/1334)];
//        _timeLabel.text = @"10-26 09:35 · 回复";
        _timeLabel.textColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1];
        _timeLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:_timeLabel];
    }
    return self;
}
-(void)setItem:(HuifuModel *)item
{
    _item = item;
    [_headImage sd_setImageWithURL:[NSURL URLWithString:item.head_image] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
    [_nameButton setTitle:item.uname forState:UIControlStateNormal];
    _zannumberLabel.text = [NSString stringWithFormat:@"%@",item.star];
    if (item.replyed_uname.length == 0)
    {
        _detailLabel.text = item.content;
    }else
    {
//        _detailLabel.text = [NSString stringWithFormat:@"回复%@:%@",item.replyed_uname,item.content];
//        NSRange range = [_detailLabel.text rangeOfString:item.replyed_uname];
//        [self setTextColor:_detailLabel FontNumber:[UIFont systemFontOfSize:14] AndRange:range AndColor:[UIColor colorWithHexString:@"#4c8cc4" alpha:1]];
        _detailLabel.text = item.content;
        NSRange range = [_detailLabel.text rangeOfString:item.replyed_uname];
        [self setTextColor:_detailLabel FontNumber:[UIFont systemFontOfSize:14] AndRange:range AndColor:[UIColor colorWithHexString:@"#4c8cc4" alpha:1]];
    }
    
    
    _timeLabel.text = [NSString stringWithFormat:@"%@ · 回复",item.before];
    
    //判断是否已经点过赞
    if ([item.is_star integerValue] == 1)
    {
        _zanImage.image = [UIImage imageNamed:@"nav_icon_zan_pre"];
    }else
    {
        _zanImage.image = [UIImage imageNamed:@"nav_icon_zan_nor"];
    }

}
//设置不同字体颜色
-(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    label.attributedText = str;
}
//赞的点击事件
- (void)zanbuttonClick
{
    _zannumberLabel.text = [NSString stringWithFormat:@"%ld",[_item.star integerValue]+1];
    _zanImage.image = [UIImage imageNamed:@"nav_icon_zan_pre"];
    [self zanOfTheDatas];
}
//赞的接口
- (void)zanOfTheDatas
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"type_id"] = @"5";
    parameters[@"out_id"] = _item.pid;
    [manager POST:[NSString stringWithFormat:@"%@App/star",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"responsessssssssObject%@",responseObject);
        if ([responseObject[@"r"] integerValue] == 1)
        {
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
@end
