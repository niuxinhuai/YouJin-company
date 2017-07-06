//
//  YJRecentReviewsTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/26.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "YJRecentReviewsTableViewCell.h"
#import "PlatformServeCommentModel.h"

@implementation YJRecentReviewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//     Initialization code
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
        //头像
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 30*BOScreenH/1334, 90*BOScreenW/750, 90*BOScreenW/750)];
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
//        //图片设置圆形
//        UIImage *image = _headImage.image;
//        UIGraphicsBeginImageContext(image.size);
//        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
//        [path addClip];
//        [image drawAtPoint:CGPointZero];
//        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        _headImage.image = newImage;
        
        //昵称
        _nicknameLabel = [[UILabel alloc]initWithFrame:CGRectMake(140*BOScreenW/750, 40*BOScreenH/1334, BOScreenW, 30*BOScreenH/1334)];
//        _nicknameLabel.text = @"昵称ID昵称";
        _nicknameLabel.textColor = [UIColor colorWithHexString:@"#4c8cc4" alpha:1];
        [_nicknameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];

//        //根据字体得到NSString的尺寸
//        CGSize size = [_nicknameLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_nicknameLabel.font,NSFontAttributeName, nil]];
//        //名字的宽度
//        CGFloat nameW = size.width;
//        _nicknameLabel.frame = CGRectMake(140*BOScreenW/750, 40*BOScreenH/1334, nameW,30*BOScreenH/1334);
        [self addSubview:_nicknameLabel];
        
//        //点评了一两理财
////        CGFloat nicknameLabelX = CGRectGetMaxX(_nicknameLabel.frame) + 10*BOScreenW/750;
//        _reviewLabel = [[UILabel alloc]init];
////        _reviewLabel.text = @"点评了一两理财";
//        _reviewLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
//        _reviewLabel.font = [UIFont systemFontOfSize:14];
//        [self addSubview:_reviewLabel];

        //时间
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(BOScreenW-290*BOScreenW/750, 44*BOScreenH/1334, 260*BOScreenW/750, 30*BOScreenH/1334)];
//        _timeLabel.text = @"16分钟前";
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1];
        _timeLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:_timeLabel];
        
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
//        _pointZeroLabel.text = @"5.0";
        _pointZeroLabel.textColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1];
        _pointZeroLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_pointZeroLabel];
        
        //详情
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 160*BOScreenH/1334, 690*BOScreenW/750, 80*BOScreenH/1334)];
//        _detailLabel.text = @"是国内一家互联网公司是国内一家互联网公司是国内一家互联网公司是国内一家互联网公司是国内一家互联网公司是国内一家互联网公司";
        _detailLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.numberOfLines = 2;
        [self addSubview:_detailLabel];
        
        //灰色的view
        _grayView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 260*BOScreenH/1334, 690*BOScreenW/750, 80*BOScreenH/1334)];
        _grayView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        [self addSubview:_grayView];
        
        //小logo
        _logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(14*BOScreenW/750, 14*BOScreenW/750, 52*BOScreenW/750, 52*BOScreenW/750)];
//        _logoImage.image = [UIImage imageNamed:@"LOGO"];
        _logoImage.layer.cornerRadius = 5;
        _logoImage.layer.masksToBounds = YES;
        [_grayView addSubview:_logoImage];
        
        //公司名称
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(140*BOScreenW/750, 40*BOScreenH/1334, BOScreenW, 30*BOScreenH/1334)];
//        _nameLabel.text = @"一两理财";
        _nameLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        _nameLabel.font = [UIFont systemFontOfSize:12];
//        //根据字体得到NSString的尺寸
//        CGSize sizes = [_nameLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_nameLabel.font,NSFontAttributeName, nil]];
//        //名字的宽度
//        CGFloat nameWs = sizes.width;
//        _nameLabel.frame = CGRectMake(86*BOScreenW/750, 20*BOScreenH/1334, nameWs,40*BOScreenH/1334);
        [_grayView addSubview:_nameLabel];
        
        //中间的笑竖线
//        CGFloat nameLabelX = CGRectGetMaxX(_nameLabel.frame)+20*BOScreenW/750;
        _thinView = [[UIView alloc]init];
        _thinView.backgroundColor = [UIColor colorWithHexString:@"#c7c7c7" alpha:1];
        [_grayView addSubview:_thinView];
        
        //四个评分
//        CGFloat thinViewX = CGRectGetMaxX(_thinView.frame)+20*BOScreenW/750;
        _scoreLabel = [[UILabel alloc]init];
//        _scoreLabel.text = @"运营5.0 · 风控4.6 · 服务4.8 · 透明4.9";
        _scoreLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        _scoreLabel.font = [UIFont systemFontOfSize:11];
        [_grayView addSubview:_scoreLabel];
    }
    return self;
}
-(void)setItem:(PlatformServeCommentModel *)item
{
    _item = item;
    //头像
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:item.head_image] placeholderImage:[UIImage imageNamed:@"pic_touxiang"]];
    
//    //图片设置圆形
//    UIImage *image = self.headImage.image;
//    UIGraphicsBeginImageContext(image.size);
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
//    [path addClip];
//    [image drawAtPoint:CGPointZero];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    _headImage.image = newImage;

    //昵称
    self.nicknameLabel.text = item.uname;
    //根据字体得到NSString的尺寸
    CGSize size = [_nicknameLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_nicknameLabel.font,NSFontAttributeName, nil]];
    //名字的宽度
    CGFloat nameW = size.width;
    _nicknameLabel.frame = CGRectMake(140*BOScreenW/750, 40*BOScreenH/1334, nameW,30*BOScreenH/1334);

//    //点评了
//    CGFloat nicknameLabelX = CGRectGetMaxX(_nicknameLabel.frame) + 10*BOScreenW/750;
//    _reviewLabel.frame = CGRectMake(nicknameLabelX, 40*BOScreenH/1334, BOScreenW, 30*BOScreenH/1334);
//    _reviewLabel.text = [NSString stringWithFormat:@"点评了%@",item.object];

    //时间
    _timeLabel.text = item.before;
    
    //星星级别
    _pointZeroLabel.text = [NSString stringWithFormat:@"%@.0分",item.score];
    
    //详情
    _detailLabel.text = item.content;
    //设置行高
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: _detailLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_detailLabel.text length])];
    _detailLabel.attributedText = attributedString;
    [_detailLabel sizeToFit];
    _detailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    //判断评分 判断评分是几评级星星显示的是那个图片
    int j = [item.score intValue]%6;
    [self setCount:j];

    //小logo
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
    
    //公司名称
    _nameLabel.text = item.object;
    //根据字体得到NSString的尺寸
    CGSize sizes = [_nameLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_nameLabel.font,NSFontAttributeName, nil]];
    //名字的宽度
    CGFloat nameWs = sizes.width;
    _nameLabel.frame = CGRectMake(86*BOScreenW/750, 20*BOScreenH/1334, nameWs,40*BOScreenH/1334);
    
    //中间细线
    CGFloat nameLabelX = CGRectGetMaxX(_nameLabel.frame)+20*BOScreenW/750;
    _thinView.frame = CGRectMake(nameLabelX, 20*BOScreenH/1334, 1*BOScreenW/750, 40*BOScreenH/1334);
    
    //四个评分
    CGFloat thinViewX = CGRectGetMaxX(_thinView.frame)+20*BOScreenW/750;
    _scoreLabel.frame = CGRectMake(thinViewX, 20*BOScreenH/1334, 450*BOScreenW/750, 40*BOScreenH/1334);
    _scoreLabel.text = [NSString stringWithFormat:@"运营%@.0 · 风控%@.0 · 服务%@.0 · 透明%@.0",item.v1,item.v2,item.v3,item.v4];
    
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
//计算label高度
- (CGFloat)boundingRectWithString:(NSString *)string
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 6;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, paragraph, NSParagraphStyleAttributeName, nil];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(BOScreenW - 70*BOScreenW/750, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:nil];
    return  rect.size.height;
}
@end
