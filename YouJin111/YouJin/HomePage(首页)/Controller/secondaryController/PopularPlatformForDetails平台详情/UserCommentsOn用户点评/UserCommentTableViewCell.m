//
//  UserCommentTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/20.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "UserCommentTableViewCell.h"
#import "BiaoQianModel.h"
#import "CommentInsideViewController.h"
#import "UserDpImaUrlModel.h"

@implementation UserCommentTableViewCell

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
        _imaurlArr = [NSMutableArray array];
        //头像
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 30*BOScreenH/1334, 90*BOScreenW/750, 90*BOScreenW/750)];
//        _headImage.image = [UIImage imageNamed:@"LOGO"];
        _headImage.layer.cornerRadius = 23;
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
        
        //昵称
        _nicknameLabel = [[UILabel alloc]initWithFrame:CGRectMake(140*BOScreenW/750, 40*BOScreenH/1334, BOScreenW, 30*BOScreenH/1334)];
//        _nicknameLabel.text = @"昵称ID昵称";
        _nicknameLabel.textColor = [UIColor colorWithHexString:@"#4c8cc4" alpha:1];
        [_nicknameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        [self addSubview:_nicknameLabel];
        
        //五角星
        for (int i = 0; i < 5; i ++)
        {
            UIImageView  *pentagramImage = [[UIImageView alloc]initWithFrame:CGRectMake(140*BOScreenW/750+i*(24*BOScreenW/750 + 6*BOScreenW/750), 86*BOScreenH/1334, 24*BOScreenW/750, 24*BOScreenW/750)];
            pentagramImage.image = [UIImage imageNamed:@"evaluate_score_d"];
            pentagramImage.tag = 100+i;
            [self addSubview:pentagramImage];
            [_xingxArr addObject:pentagramImage];
        }
        
        //星星级别
        _pointZeroLabel = [[UILabel alloc]initWithFrame:CGRectMake(294*BOScreenW/750, 86*BOScreenH/1334, 200*BOScreenW/750, 24*BOScreenH/1334)];
//        _pointZeroLabel.text = @"5.0分";
        _pointZeroLabel.textColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1];
        _pointZeroLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_pointZeroLabel];
        
//        //四个评分
//        _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(140*BOScreenW/750, 130*BOScreenH/1334, 400*BOScreenW/750, 30*BOScreenH/1334)];
////        _scoreLabel.text = @"运营5.0 · 风控4.6 · 服务4.8 · 透明4.9";
//        _scoreLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
//        _scoreLabel.font = [UIFont systemFontOfSize:11];
//        [self addSubview:_scoreLabel];
        
        //精华点评
        _essenceImage = [[UIImageView alloc]initWithFrame:CGRectMake(BOScreenW-116*BOScreenW/750, 30*BOScreenH/1334, 86*BOScreenW/750, 76*BOScreenH/1334)];
        _essenceImage.image = [UIImage imageNamed:@"img_jhdp"];
        [self addSubview:_essenceImage];
        
        //详情
//        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 180*BOScreenH/1334, 690*BOScreenW/750, 200*BOScreenH/1334)];
        _detailLabel = [[UILabel alloc]init];
//        _detailLabel.text = @"恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚哈哈哈红红火火恍恍惚惚和红红火火恍恍惚惚红红火火恍恍惚惚和红红火火恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚哈哈";
        _detailLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _detailLabel.numberOfLines = 0;
        _detailLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_detailLabel];
        
//        //图片
//        for (int i = 0; i < 3; i ++)
//        {
//            UIImageView *pictureImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750+i*(160*BOScreenW/750 + 10*BOScreenW/750), _detailLabelY, 160*BOScreenW/750, 160*BOScreenW/750)];
////            pictureImage.image = [UIImage imageNamed:@"LOGO"];
////            [pictureImage sd_setImageWithURL:[NSURL URLWithString:_imaurlArr[i]] placeholderImage:[UIImage imageNamed:@"img_download"]];
//            [self addSubview:pictureImage];
//        }
        
        //时间
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 608*BOScreenH/1334, 300*BOScreenW/750, 20*BOScreenH/1334)];
//        _timeLabel.text = @"2016-08-30";
        _timeLabel.textColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1];
        _timeLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:_timeLabel];
        
        //评论
        _commentbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentbutton.frame = CGRectMake(590*BOScreenW/750, 590*BOScreenH/1334, 140*BOScreenW/750, 56*BOScreenH/1334);
        [_commentbutton setImage:[UIImage imageNamed:@"nav_icon_pinglun"] forState:UIControlStateNormal];
        _commentbutton.imageEdgeInsets = UIEdgeInsetsMake(5, 15, 5, 35);
        
        [_commentbutton setTitle:@" 评论" forState:UIControlStateNormal];
        [_commentbutton setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
        _commentbutton.titleLabel.font = [UIFont systemFontOfSize:12];
        _commentbutton.adjustsImageWhenHighlighted = NO;
        _commentbutton.layer.cornerRadius = 15;
        _commentbutton.layer.masksToBounds = YES;
        _commentbutton.layer.borderWidth = 1;
        _commentbutton.layer.borderColor = [UIColor colorWithHexString:@"#cccccc" alpha:1].CGColor;
//        [_commentbutton addTarget:self action:@selector(commentbuttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_commentbutton];
        
        //赞
        _zanabutton = [UIButton buttonWithType:UIButtonTypeCustom];
        _zanabutton.frame = CGRectMake(440*BOScreenW/750, 590*BOScreenH/1334, 140*BOScreenW/750, 56*BOScreenH/1334);
        [_zanabutton setImage:[UIImage imageNamed:@"nav_icon_zan_nor"] forState:UIControlStateNormal];
        _zanabutton.imageEdgeInsets = UIEdgeInsetsMake(5, 20, 5, 30);
        [_zanabutton setTitle:@" 赞" forState:UIControlStateNormal];
        [_zanabutton setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
        _zanabutton.titleLabel.font = [UIFont systemFontOfSize:12];
        _zanabutton.adjustsImageWhenHighlighted = NO;
        _zanabutton.layer.cornerRadius = 15;
        _zanabutton.layer.masksToBounds = YES;
        _zanabutton.layer.borderWidth = 1;
        _zanabutton.layer.borderColor = [UIColor colorWithHexString:@"#cccccc" alpha:1].CGColor;
        [_zanabutton addTarget:self action:@selector(zanbuttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_zanabutton];
    }
    return self;
}
- (void)setItem:(BiaoQianModel *)item
{
    _item = item;
    [_headImage sd_setImageWithURL:[NSURL URLWithString:item.head_image] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
    _nicknameLabel.text = item.uname;
    _pointZeroLabel.text = [NSString stringWithFormat:@"%@.0分",item.score];
    //判断评分 判断评分是几评级星星显示的是那个图片
    int j = [item.score intValue]%6;
    [self setCount:j];
//    _scoreLabel.text = [NSString stringWithFormat:@"运营%@ · 风控%@ · 服务%@ · 透明%@",item.v1,item.v2,item.v3,item.v4];
    if ([item.is_good integerValue] == 0)
    {
        _essenceImage.hidden = YES;
    }
    _detailLabel.text = item.content;
    
    //设置行高
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: _detailLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_detailLabel.text length])];
    _detailLabel.attributedText = attributedString;
//    [_detailLabel sizeToFit];
//    _detailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    
    //设置详情的位置
    _detailLabel.frame = CGRectMake(30*BOScreenW/750, 150*BOScreenH/1334, 690*BOScreenW/750, [self boundingRectWithString:_detailLabel.text]);
    
    _detailLabelY = CGRectGetMaxY(_detailLabel.frame) + 20*BOScreenH/1334;

    //多张图片
    for (UserDpImaUrlModel *imageUrl in item.img_url)
    {
        [_imaurlArr addObject:imageUrl.img_url];
    }

    if (_imaurlArr.count == 0)
    {
        _tzpFloat = _detailLabelY+10*BOScreenH/1334;
    }else
    {
        _tzpFloat = _detailLabelY+160*BOScreenH/1334 + 30*BOScreenH/1334;
    }

    //图片
//    CGFloat _detailLabelY = CGRectGetMaxY(_detailLabel.frame)+30*BOScreenH/1334;
    //图片
    for (int i = 0; i < _imaurlArr.count; i ++)
    {
        _pictureImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750+i*(160*BOScreenW/750 + 10*BOScreenW/750), _detailLabelY, 160*BOScreenW/750, 160*BOScreenW/750)];
        [_pictureImage sd_setImageWithURL:[NSURL URLWithString:_imaurlArr[i]] placeholderImage:[UIImage imageNamed:@"img_download"]];
        _pictureImage.tag = 300+i;
        [self addSubview:_pictureImage];
    }
    //对时间的截取
    NSArray *newArray = [item.time_h componentsSeparatedByString:@" "];
    _timeLabel.text = newArray[0];
    
    //设置时间的位置
    _timeLabel.frame = CGRectMake(30*BOScreenW/750, _tzpFloat, 300*BOScreenW/750, 20*BOScreenH/1334);
    //设置评论的位置
    _commentbutton.frame = CGRectMake(590*BOScreenW/750, _tzpFloat-18*BOScreenH/1334, 140*BOScreenW/750, 56*BOScreenH/1334);
    //设置赞的位置
    _zanabutton.frame = CGRectMake(440*BOScreenW/750, _tzpFloat-18*BOScreenH/1334, 140*BOScreenW/750, 56*BOScreenH/1334);
    
    [_imaurlArr removeAllObjects];
    
    //判断是否已经点过赞
    if ([item.is_star integerValue] == 1)
    {
        [_zanabutton setImage:[UIImage imageNamed:@"nav_icon_zan_pre"] forState:UIControlStateNormal];
    }else
    {
        [_zanabutton setImage:[UIImage imageNamed:@"nav_icon_zan_nor"] forState:UIControlStateNormal];
    }
    
    //赞的数量
    [_zanabutton setTitle:[NSString stringWithFormat:@" %@",item.star] forState:UIControlStateNormal];
    if ([item.star isEqual:@"0"])
    {
        [_zanabutton setTitle:@" 赞" forState:UIControlStateNormal];
    }
    
    //评论
    [_commentbutton setTitle:[NSString stringWithFormat:@" %@",item.reply_nums] forState:UIControlStateNormal];
    if ([item.reply_nums isEqual:@"0"])
    {
        [_commentbutton setTitle:@" 评论" forState:UIControlStateNormal];
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
//赞的点击事件
- (void)zanbuttonClick
{
    [_zanabutton setImage:[UIImage imageNamed:@"nav_icon_zan_pre"] forState:UIControlStateNormal];
    //赞的数量
    [_zanabutton setTitle:[NSString stringWithFormat:@" %ld",(long)[_item.star integerValue]+1] forState:UIControlStateNormal];
    if ([_item.star isEqual:@"0"])
    {
        [_zanabutton setTitle:@" 1" forState:UIControlStateNormal];
    }
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
//评论的点击事件
- (void)commentbuttonClick
{
    CommentInsideViewController *commVc = [[CommentInsideViewController alloc]init];
    commVc.hidesBottomBarWhenPushed = YES;
    commVc.pidString = _item.pid;
//    commVc.outidString = _item.pid;
    commVc.outtypeString = @"3";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:commVc];
    [nav pushViewController:commVc animated:NO];
}
//计算label高度
- (CGFloat)boundingRectWithString:(NSString *)string
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 6;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, paragraph, NSParagraphStyleAttributeName, nil];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(BOScreenW - 70*BOScreenW/750, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:nil];
    return  rect.size.height;
}

//- (CGFloat)topCommentCellHeight
//{
//    if (self.cellheight == 0) {
//        CGFloat contentHeight = [self.content getSizeFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake([UIScreen screenWidth] - 75, MAXFLOAT) andlineSpacing:1].height;
//        self.cellheight = contentHeight + 90;
//    }
//    return self.cellheight;
//}
@end
