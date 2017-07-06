//
//  TopSignView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "TopSignView.h"
#import "SignInPageModel.h"

@interface TopSignView()
@end
@implementation TopSignView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        //头像
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 44*BOScreenH/1334, 110*BOScreenW/750, 110*BOScreenW/750)];
//        _headImage.image = [UIImage imageNamed:@"logo_youjin"];
        [self addSubview:_headImage];
       
        //u币的图片
        CGFloat headImageX = CGRectGetMaxX(_headImage.frame) + 26*BOScreenW/750;
        UIImageView *uCoinImage = [[UIImageView alloc]initWithFrame:CGRectMake(headImageX, 60*BOScreenH/1334, 30*BOScreenW/750, 30*BOScreenW/750)];
        uCoinImage.image = [UIImage imageNamed:@"common_icon_ub"];
        [self addSubview:uCoinImage];
        
        //1,000,000
        CGFloat uCoinImageX = CGRectGetMaxX(uCoinImage.frame) + 18*BOScreenW/750;
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(uCoinImageX, 52*BOScreenH/1334, 300*BOScreenW/750, 40*BOScreenH/1334)];
//        numberLabel.text = @"1,000,000";
        [_numberLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        _numberLabel.textColor = [UIColor colorWithHexString:@"#ff5a00" alpha:1];
        [self addSubview:_numberLabel];
        
        //明日签到即可得 300
        CGFloat numberLabelY = CGRectGetMaxY(_numberLabel.frame) + 27*BOScreenH/1334;
        _signInToLabel = [[UILabel alloc]initWithFrame:CGRectMake(headImageX, numberLabelY, 300*BOScreenW/750, 30*BOScreenH/1334)];
//        _signInToLabel.text = @"明日签到即可得 300";
        _signInToLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        _signInToLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_signInToLabel];
        
        //签到
        _sigInButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sigInButton.frame = CGRectMake(570*BOScreenW/750, 70*BOScreenH/1334, 160*BOScreenW/750, 80*BOScreenH/1334);
        [_sigInButton setTitle:@"签到" forState:UIControlStateNormal];
        _sigInButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_sigInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sigInButton setBackgroundImage:[UIImage imageNamed:@"btn_green"] forState:UIControlStateNormal];
        _sigInButton.contentEdgeInsets = UIEdgeInsetsMake(0,0, 10, 0);
        [self addSubview:_sigInButton];

        //喊好友签到额外领50U币/人
        UIView *peopleView = [[UIView alloc]initWithFrame:CGRectMake(0, 200*BOScreenH/1334, BOScreenW, 80*BOScreenH/1334)];
        peopleView.backgroundColor = [UIColor colorWithHexString:@"#fff9f5" alpha:1];
        [self addSubview:peopleView];
        
        UILabel *peopleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 420*BOScreenW/750, 30*BOScreenH/1334)];
        peopleLabel.text = @"喊好友签到额外领 1000U币/人";
        peopleLabel.font = [UIFont systemFontOfSize:13];
        peopleLabel.textColor = [UIColor colorWithHexString:@"#b87b5a" alpha:1];
        [peopleView addSubview:peopleLabel];
        //字体显示两种颜色
        NSMutableAttributedString *attris = [[NSMutableAttributedString alloc] initWithString:@"喊好友签到额外领 1000U币/人"];
        NSRange nineredRangeTwos = NSMakeRange([[attris string] rangeOfString:@"1000U币"].location, [[attris string] rangeOfString:@"1000U币"].length);
        [attris addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5a00" alpha:1] range:nineredRangeTwos];
        [peopleLabel setAttributedText:attris];
        [peopleLabel sizeToFit];
      
        UIImageView *jtImage = [[UIImageView alloc]initWithFrame:CGRectMake(715*BOScreenW/750, 27*BOScreenH/1334, 15*BOScreenW/750, 26*BOScreenH/1334)];
        jtImage.image = [UIImage imageNamed:@"common_goto"];
        [peopleView addSubview:jtImage];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 79*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
        [peopleView addSubview:lineView];
        
        //喊好友签到的按钮
        _shoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shoutButton.frame = CGRectMake(0, 0, BOScreenW, 80*BOScreenH/1334);
        [peopleView addSubview:_shoutButton];
        
        //16pxview
        UIView *tenView = [[UIView alloc]initWithFrame:CGRectMake(0, 280*BOScreenH/1334, BOScreenW, 16*BOScreenH/1334)];
        tenView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        [self addSubview:tenView];
        
//        //阅读签到前面的蓝色
//        CGFloat tenViewY = CGRectGetMaxY(tenView.frame);
//        UILabel *blueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, tenViewY + 23*BOScreenH/1334, 10*BOScreenW/750, 34*BOScreenH/1334)];
//        blueLabel.backgroundColor = [UIColor colorWithRed:70/255.0 green:151/255.0 blue:251/255.0 alpha:1];
//        [self addSubview:blueLabel];
//        //阅读签到
//        UILabel *toolsLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, tenViewY + 25*BOScreenH/1334, 300*BOScreenW/750, 30*BOScreenH/1334)];
//        toolsLabel.text = @"阅读签到";
//        [toolsLabel setFont:[UIFont systemFontOfSize:15.0]];
//        toolsLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
//        [self addSubview:toolsLabel];
//        
//        //细线
//        for (int i = 0; i < 2; i ++)
//        {
//            UIView *linView = [[UIView alloc]initWithFrame:CGRectMake(0, tenViewY+80*BOScreenH/1334+i*(180*BOScreenH/1334), BOScreenW, 1*BOScreenH/1334)];
//            linView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
//            [self addSubview:linView];
//        }
//        UIView *liView = [[UIView alloc]initWithFrame:CGRectMake(BOScreenW/2, tenViewY+80*BOScreenH/1334, 1*BOScreenW/750, 360*BOScreenH/1334)];
//        liView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
//        [self addSubview:liView];
//        
//        //四个
//        for (int i = 0; i < 4; i ++)
//        {
//            int j = i%2;
//            int k = i/2;
//            //四个大图片
//            UIImageView *fourImage = [[UIImageView alloc]initWithFrame:CGRectMake(175*BOScreenW/750 + j*(180*BOScreenW/750 + 195*BOScreenW/750), tenViewY+105*BOScreenH/1334 + k*(130*BOScreenH/1334+50*BOScreenH/1334), 180*BOScreenW/750, 130*BOScreenH/1334)];
//            fourImage.image = [UIImage imageNamed:@"toutiaobanner"];
//            fourImage.layer.cornerRadius = 3;
//            fourImage.layer.masksToBounds = YES;
//            [self addSubview:fourImage];
//            
//            //四个标题标题
//            UILabel *fourLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750+j*(140*BOScreenW/750+235*BOScreenW/750), tenViewY+120*BOScreenH/1334 + k*(40*BOScreenH/1334+140*BOScreenH/1334), 140*BOScreenW/750, 40*BOScreenH/1334)];
//            fourLabel.text = @"标题标题";
//            fourLabel.font = [UIFont systemFontOfSize:15];
//            fourLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
//            [self addSubview:fourLabel];
//            
//            //四个100U币
//            UILabel *fourLabels = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750+j*(140*BOScreenW/750+235*BOScreenW/750), tenViewY+160*BOScreenH/1334 + k*(40*BOScreenH/1334+140*BOScreenH/1334), 140*BOScreenW/750, 40*BOScreenH/1334)];
//            fourLabels.text = @"100U币";
//            fourLabels.font = [UIFont systemFontOfSize:12];
//            fourLabels.textColor = [UIColor colorWithHexString:@"#ff5a00" alpha:1];
//            [self addSubview:fourLabels];
//            
//
//        }
//        for (int i = 0; i < 4; i ++)
//        {
//            int j = i%2;
//            int k = i/2;
//            //四个按钮
//            _fouButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            _fouButton.frame = CGRectMake(j*(BOScreenW/2), tenViewY + 80*BOScreenH/1334 + k*(180*BOScreenH/1334), BOScreenW/2, 180*BOScreenH/1334);
//            _fouButton.tag = 1000+i;
//            [self addSubview:_fouButton];
//        }
//        //16pxview
//        UIView *tensView = [[UIView alloc]initWithFrame:CGRectMake(0, tenViewY + 440*BOScreenH/1334, BOScreenW, 16*BOScreenH/1334)];
//        tensView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
//        [self addSubview:tensView];
//        
//        //热门活动前面的蓝色
//        CGFloat tensViewY = CGRectGetMaxY(tensView.frame);
//        UILabel *hotLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, tensViewY + 23*BOScreenH/1334, 10*BOScreenW/750, 34*BOScreenH/1334)];
//        hotLabel.backgroundColor = [UIColor colorWithRed:70/255.0 green:151/255.0 blue:251/255.0 alpha:1];
//        [self addSubview:hotLabel];
//        //热门活动
//        UILabel *toolsLabels = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, tensViewY + 25*BOScreenH/1334, 300*BOScreenW/750, 30*BOScreenH/1334)];
//        toolsLabels.text = @"热门活动";
//        [toolsLabels setFont:[UIFont systemFontOfSize:15.0]];
//        toolsLabels.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
//        [self addSubview:toolsLabels];

    }
    return self;
}

-(void)setItem:(SignInPageModel *)item
{
    _item = item;
    //头像
    [_headImage sd_setImageWithURL:[NSURL URLWithString:item.head_image] placeholderImage:[UIImage imageNamed:@"pic_touxiang"]];
    //图片设置圆形
    //        UIImage *image = [UIImage imageNamed:@"logo_youjin"];
    UIGraphicsBeginImageContext(_headImage.image.size);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, _headImage.image.size.width, _headImage.image.size.height)];
    [path addClip];
    [_headImage.image drawAtPoint:CGPointZero];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _headImage.image = newImage;
    //u币
    _numberLabel.text = item.balance;
    //明日签到即可得
    _signInToLabel.text = [NSString stringWithFormat:@"明日签到可得 %@",item.tomorrow];
    //字体显示两种颜色
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:_signInToLabel.text];
    NSRange nineredRangeTwo = NSMakeRange([[attri string] rangeOfString:item.tomorrow].location, [[attri string] rangeOfString:item.tomorrow].length);
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5a00" alpha:1] range:nineredRangeTwo];
    [_signInToLabel setAttributedText:attri];
    [_signInToLabel sizeToFit];
}
@end
