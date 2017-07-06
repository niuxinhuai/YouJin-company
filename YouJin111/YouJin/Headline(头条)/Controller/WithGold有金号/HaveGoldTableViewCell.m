//
//  HaveGoldTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HaveGoldTableViewCell.h"

@implementation HaveGoldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //头像
        self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20*BOScreenW/750, 25*BOScreenH/1334, 90*BOScreenW/750, 90*BOScreenW/750)];
        self.headImageView.image = [UIImage imageNamed:@"logo_youjin"];
        [self addSubview:self.headImageView];
        //图片设置圆形
//        UIImage *image = [UIImage imageNamed:@"logo_youjin"];
        UIGraphicsBeginImageContext(self.headImageView.image.size);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.headImageView.image.size.width, self.headImageView.image.size.height)];
        [path addClip];
        [self.headImageView.image drawAtPoint:CGPointZero];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.headImageView.image = newImage;
        
        //昵称ID昵称
        self.nicknameLabel = [[UILabel alloc]initWithFrame:CGRectMake(140*BOScreenW/750, 34*BOScreenH/1334, 564*BOScreenW/750, 30*BOScreenH/1334)];
        self.nicknameLabel.text = @"昵称ID昵称";
        self.nicknameLabel.font = [UIFont systemFontOfSize:14];
        self.nicknameLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [self addSubview:self.nicknameLabel];
        
        //蚂蚁金融胡滔：一年来网货业累
        self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(140*BOScreenW/750, 78*BOScreenH/1334, 564*BOScreenW/750, 30*BOScreenH/1334)];
        self.detailLabel .text = @"蚂蚁金融胡滔：一年来网货业累计停业及货业的服务质量杠杆的颇受业内人士好评";
        self.detailLabel .font = [UIFont systemFontOfSize:13];
        self.detailLabel .textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        [self addSubview:self.detailLabel ];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - helpMethod

- (void)updateFoucsModel:(GoldAccountFoucsModel *)model {
    self.model = model;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.head_image]];
    self.nicknameLabel.text = model.uname;
}


@end
