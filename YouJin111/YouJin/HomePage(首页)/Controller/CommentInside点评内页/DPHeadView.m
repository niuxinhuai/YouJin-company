//
//  DPHeadView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "DPHeadView.h"
#import "DPdetailModel.h"
#import "ThePictureModel.h"
#import "FourTheLabelModel.h"
#import "HeadView.h"

@implementation DPHeadView

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
        _imaurlArr = [NSMutableArray array];
        _xingxArr = [NSMutableArray array];
        _fourTLArr = [NSMutableArray array];
        
        //头像
        _headimageview = [[HeadView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 30*BOScreenH/1334, 90*BOScreenW/750, 90*BOScreenW/750)];
        [self addSubview:_headimageview];
        
        
        //头像上面放个按钮
        _coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _coverButton.frame = CGRectMake(30*BOScreenW/750, 30*BOScreenH/1334, 90*BOScreenW/750, 90*BOScreenW/750);
        [self addSubview:_coverButton];
        
//        //昵称
//        _nicknameLabel = [[UILabel alloc]initWithFrame:CGRectMake(140*BOScreenW/750, 40*BOScreenH/1334, BOScreenW, 30*BOScreenH/1334)];
////        _nicknameLabel.text = @"昵称ID昵称";
//        _nicknameLabel.textColor = [UIColor colorWithHexString:@"#4c8cc4" alpha:1];
////        _nicknameLabel.font = [UIFont systemFontOfSize:14];
//        [_nicknameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
//        [self addSubview:_nicknameLabel];
        
        _nicknameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nicknameButton.frame = CGRectMake(140*BOScreenW/750, 40*BOScreenH/1334, BOScreenW, 30*BOScreenH/1334);
        [_nicknameButton setTitleColor:[UIColor colorWithHexString:@"#4c8cc4" alpha:1] forState:UIControlStateNormal];
        _nicknameButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        _nicknameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:_nicknameButton];
        
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
        
        //四个评分
        _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(140*BOScreenW/750, 130*BOScreenH/1334, 400*BOScreenW/750, 30*BOScreenH/1334)];
//        _scoreLabel.text = @"运营5.0 · 风控4.6 · 服务4.8 · 透明4.9";
        _scoreLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        _scoreLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:_scoreLabel];
        
        //精华点评
        _essenceImage = [[UIImageView alloc]initWithFrame:CGRectMake(BOScreenW-116*BOScreenW/750, 30*BOScreenH/1334, 86*BOScreenW/750, 76*BOScreenH/1334)];
        _essenceImage.image = [UIImage imageNamed:@"img_jhdp"];
        [self addSubview:_essenceImage];
        
        //详情
//        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 180*BOScreenH/1334, 690*BOScreenW/750, 470*BOScreenH/1334)];
        _detailLabel = [[UILabel alloc]init];
//        _detailLabel.text = @"恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚哈哈哈红红火火恍恍惚惚和红红火火恍恍惚惚红红火火恍恍惚惚和红红火火恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚恍恍惚惚哈哈";
        _detailLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _detailLabel.numberOfLines = 0;
        _detailLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_detailLabel];
        
//        //图片
//        for (int i = 0; i < _imaurlArr.count; i ++)
//        {
//            UIImageView *pictureImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750+i*(160*BOScreenW/750 + 10*BOScreenW/750), 680*BOScreenH/1334, 160*BOScreenW/750, 160*BOScreenW/750)];
//            [pictureImage sd_setImageWithURL:[NSURL URLWithString:_imaurlArr[i]] placeholderImage:[UIImage imageNamed:@"logo"]];
////            pictureImage.image = [UIImage imageNamed:@"LOGO"];
//            [self addSubview:pictureImage];
//        }

        //时间
//        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 866*BOScreenH/1334, 200*BOScreenW/750, 20*BOScreenH/1334)];
        _timeLabel = [[UILabel alloc]init];
//        _timeLabel.text = @"2016-08-30";
        _timeLabel.textColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1];
        _timeLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:_timeLabel];
    }
    return self;
}
-(void)setItem:(DPdetailModel *)item
{
    _item = item;
    [_headimageview updateImageUrlString:item.head_image];
    if ([item.person_vip integerValue] == 1)
    {
        [_headimageview updateHeadStatus:kPersonVip];
    }else if ([item.company_vip integerValue] == 1)
    {
        [_headimageview updateHeadStatus:kCompanyVip];
    }else
    {
        [_headimageview updateHeadStatus:kNormal];
    }
    [_headimageview updateCompanyStatusViewHeight:11 personHeight:15];
    
    [_nicknameButton setTitle:item.uname forState:UIControlStateNormal];
    //判断评分 判断评分是几评级星星显示的是那个图片
    int j = [item.score intValue]%6;
    [self setCount:j];
    //几分
    _pointZeroLabel.text = [NSString stringWithFormat:@"%@.0分",item.score];
    for (FourTheLabelModel *repalychild in item.repaly_child)
    {
        [_fourTLArr addObject:repalychild.desc];
    }
    _scoreLabel.text = [NSString stringWithFormat:@"%@%@.0 · %@%@.0 · %@%@.0 · %@%@.0",_fourTLArr[0],item.v1,_fourTLArr[1],item.v2,_fourTLArr[2],item.v3,_fourTLArr[3],item.v4];
    
    if ([item.is_good integerValue] == 0)
    {
        _essenceImage.hidden = YES;
    }
    
    _detailLabel.text = item.content;
    _detailLabel.frame = CGRectMake(30*BOScreenW/750, 180*BOScreenH/1334, 690*BOScreenW/750, self.textheight);
    _timeLabel.text = item.before;

    //多张图片
    for (ThePictureModel *imageUrl in item.img_url)
    {
        [_imaurlArr addObject:imageUrl.img_url];
    }
    //图片
    CGFloat _detailLabelY = CGRectGetMaxY(_detailLabel.frame)+30*BOScreenH/1334;
    for (int i = 0; i < _imaurlArr.count; i ++)
    {
        UIImageView *pictureImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750+i*(160*BOScreenW/750 + 10*BOScreenW/750), _detailLabelY, 160*BOScreenW/750, 160*BOScreenW/750)];
        [pictureImage sd_setImageWithURL:[NSURL URLWithString:_imaurlArr[i]] placeholderImage:[UIImage imageNamed:@"img_download"]];
        [self addSubview:pictureImage];
    }
    _timeLabel.frame = CGRectMake(30*BOScreenW/750, _detailLabelY + 160*BOScreenW/750 + 26*BOScreenH/1334 + _imageheight, 200*BOScreenW/750, 20*BOScreenH/1334);
    [_imaurlArr removeAllObjects];
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
