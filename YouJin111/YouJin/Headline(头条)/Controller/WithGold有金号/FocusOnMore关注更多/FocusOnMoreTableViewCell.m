//
//  FocusOnMoreTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "FocusOnMoreTableViewCell.h"

@implementation FocusOnMoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //头像
        UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(20*BOScreenW/750, 25*BOScreenH/1334, 90*BOScreenW/750, 90*BOScreenW/750)];
        headImage.image = [UIImage imageNamed:@"logo_youjin"];
        [self addSubview:headImage];
        //图片设置圆形
        //        UIImage *image = [UIImage imageNamed:@"logo_youjin"];
        UIGraphicsBeginImageContext(headImage.image.size);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, headImage.image.size.width, headImage.image.size.height)];
        [path addClip];
        [headImage.image drawAtPoint:CGPointZero];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        headImage.image = newImage;
        
        //V标志
        UIImageView *vImage = [[UIImageView alloc]initWithFrame:CGRectMake(60*BOScreenW/750, 65*BOScreenH/1334, 25*BOScreenW/750, 25*BOScreenW/750)];
        vImage.image = [UIImage imageNamed:@"icon_v"];
        [headImage addSubview:vImage];
        
        //企业V
        UIImageView *vImages = [[UIImageView alloc]initWithFrame:CGRectMake(47*BOScreenW/750, 65*BOScreenH/1334, 50*BOScreenW/750, 25*BOScreenW/750)];
        vImages.image = [UIImage imageNamed:@"icon_vqiye"];
        [headImage addSubview:vImages];
        
        //昵称ID昵称
        UILabel *nicknameLabels = [[UILabel alloc]initWithFrame:CGRectMake(140*BOScreenW/750, 34*BOScreenH/1334, 470*BOScreenW/750, 30*BOScreenH/1334)];
        nicknameLabels.text = @"昵称ID昵称";
        nicknameLabels.font = [UIFont systemFontOfSize:14];
        nicknameLabels.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [self addSubview:nicknameLabels];
        
        //0篇头条 · 0个粉丝
        UILabel *detailLabels = [[UILabel alloc]initWithFrame:CGRectMake(140*BOScreenW/750, 78*BOScreenH/1334, 470*BOScreenW/750, 30*BOScreenH/1334)];
        detailLabels.text = @"0篇头条 · 0个粉丝";
        detailLabels.font = [UIFont systemFontOfSize:13];
        detailLabels.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        [self addSubview:detailLabels];
        
        UIButton *focusOnButton = [UIButton buttonWithType:UIButtonTypeCustom];
        focusOnButton.frame = CGRectMake(630*BOScreenW/750, 47*BOScreenH/1334, 100*BOScreenW/750, 46*BOScreenH/1334);
        [focusOnButton setBackgroundImage:[UIImage imageNamed:@"common_btn_guanzhu_nor"] forState:UIControlStateNormal];
        [self addSubview:focusOnButton];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
