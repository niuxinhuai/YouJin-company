//
//  ToApplyForView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "ToApplyForView.h"
#import "TTTAttributedLabel.h"

@implementation ToApplyForView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //设置毛玻璃效果
        _effectView =[[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        _effectView.frame = CGRectMake(0, 0, BOScreenW, BOScreenH);
        _effectView.alpha = 0.7;
        [self addSubview:_effectView];
        UIVisualEffectView *sub = [[UIVisualEffectView alloc]initWithEffect:[UIVibrancyEffect effectForBlurEffect:(UIBlurEffect *)_effectView.effect]];
        sub.frame = _effectView.bounds;
        [_effectView.contentView addSubview:sub];
        
        //自媒体 企业的 view
        _homeView = [[UIView alloc]initWithFrame:CGRectMake(61*BOScreenW/750, 212*BOScreenH/1334, 628*BOScreenW/750, 910*BOScreenH/1334)];
        _homeView.backgroundColor = [UIColor whiteColor];
        _homeView.layer.cornerRadius = 20;
        _homeView.layer.masksToBounds = YES;
        [self addSubview:_homeView];
        
        //成为有金号可以获得在头条中发表文章的权限
        UILabel *becomeLabel = [[UILabel alloc]init];
        becomeLabel.text = @"成为有金号可以获得在头条中发表文章的权限";
        becomeLabel.font = [UIFont fontWithName:@"Helvetica-Bold"size:12];
        [becomeLabel setTextColor:[UIColor colorWithHexString:@"#b3b3b3" alpha:1]];
        //根据字体得到NSString的尺寸
        CGSize size = [becomeLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:becomeLabel.font,NSFontAttributeName, nil]];
        //名字的W
        CGFloat becomeLabelW = size.width;
        becomeLabel.frame = CGRectMake((628*BOScreenW/750-becomeLabelW)/2, 48*BOScreenH/1334, becomeLabelW,30*BOScreenH/1334);
        [_homeView addSubview:becomeLabel];
        
        //小蓝点
        CGFloat becomeLabelX = CGRectGetMaxX(becomeLabel.frame) - becomeLabelW - 20*BOScreenW/750;
        UIView *smallView = [[UIView alloc]initWithFrame:CGRectMake(becomeLabelX, 57*BOScreenH/1334, 12*BOScreenW/750, 12*BOScreenW/750)];
        smallView.backgroundColor = [UIColor colorWithHexString:@"#2380f4" alpha:1];
        smallView.layer.cornerRadius = 3;
        smallView.layer.masksToBounds = YES;
        [_homeView addSubview:smallView];
        
        //笔书
        _penImage = [[UIImageView alloc]initWithFrame:CGRectMake(134*BOScreenW/750, 160*BOScreenH/1334, 360*BOScreenW/750, 260*BOScreenH/1334)];
        _penImage.image = [UIImage imageNamed:@"img_geren"];
        [_homeView addSubview:_penImage];
        
        //适合垂直领域专家、意见领袖、评论家及自媒体人士申请
        CGFloat penImageY = CGRectGetMaxY(_penImage.frame) + 20;
        _suitableLabel = [[TTTAttributedLabel alloc]initWithFrame:CGRectMake(90*BOScreenW/750, penImageY, 460*BOScreenW/750, 50)];
//        _suitableLabel.backgroundColor = [UIColor redColor];
        self.suitableLabel.text = @"适合垂直领域专家、意见领袖、评论家及自媒体人士申请";
        _suitableLabel.lineSpacing = 6;
        //[_suitableLabel sizeToFit];
        _suitableLabel.textAlignment = NSTextAlignmentCenter;
        _suitableLabel.numberOfLines = 0;
        _suitableLabel.font = [UIFont systemFontOfSize:15];
        [_suitableLabel setTextColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
        [_homeView addSubview:_suitableLabel];
    
        //自媒体image
        CGFloat pensImageY = CGRectGetMaxY(_penImage.frame) + 224*BOScreenH/1334;
        UIImageView *sinceMediaImage = [[UIImageView alloc]initWithFrame:CGRectMake(164*BOScreenW/750, pensImageY, 300*BOScreenW/750, 110*BOScreenH/1334)];
        sinceMediaImage.image = [UIImage imageNamed:@"btn_blue"];
        [_homeView addSubview:sinceMediaImage];
        
        //自媒体申请button
        _sinceMediaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sinceMediaButton.frame = CGRectMake(164*BOScreenW/750, pensImageY, 300*BOScreenW/750, 77*BOScreenH/1334);
        [_sinceMediaButton setTintColor:[UIColor whiteColor]];
        _sinceMediaButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold"size:15];
        [_sinceMediaButton addTarget:self action:@selector(applyAction:) forControlEvents:UIControlEventTouchUpInside];
        [_homeView addSubview:_sinceMediaButton];
        
        //企业申请button
        CGFloat sinceMediaImageY = CGRectGetMaxY(sinceMediaImage.frame) + 46*BOScreenH/1334;
        _enterpriseGoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _enterpriseGoButton.frame = CGRectMake(265*BOScreenW/750, sinceMediaImageY, 130*BOScreenW/750, 30*BOScreenH/1334);
        [_enterpriseGoButton setTitleColor:[UIColor colorWithHexString:@"#78affc" alpha:1] forState:UIControlStateNormal];
        [_enterpriseGoButton setTitle:@"企业申请" forState:UIControlStateNormal];
        _enterpriseGoButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold"size:13];
        [_enterpriseGoButton setImage:[UIImage imageNamed:@"icon_bluearrow"] forState:UIControlStateNormal];
        _enterpriseGoButton.imageEdgeInsets = UIEdgeInsetsMake(0, _enterpriseGoButton.frame.size.width - _enterpriseGoButton.imageView.frame.origin.x - _enterpriseGoButton.imageView.frame.size.width - 6*BOScreenW/750, 0, 0);
        _enterpriseGoButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(_enterpriseGoButton.frame.size.width - _enterpriseGoButton.imageView.frame.size.width ) + 50*BOScreenW/750, 0, 0);
        [_enterpriseGoButton addTarget:self action:@selector(enterpriseGoAction:) forControlEvents:UIControlEventTouchUpInside];
        if (iPhone5)
        {
            _enterpriseGoButton.imageEdgeInsets = UIEdgeInsetsMake(0, _enterpriseGoButton.frame.size.width - _enterpriseGoButton.imageView.frame.origin.x - _enterpriseGoButton.imageView.frame.size.width + 100*BOScreenW/750, 0, 0);
            _enterpriseGoButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(_enterpriseGoButton.frame.size.width - _enterpriseGoButton.imageView.frame.size.width ) + 50*BOScreenW/750, 0, 0);
        }
        [_homeView addSubview:_enterpriseGoButton];
        [self updateApplyType:GoldAccountApplyByMedia];
        [self addTapGesture];

    }
    return self;
}

- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
}


- (void)updateApplyType:(GoldAccountApplyType)type {
    self.type = type;
    switch (type) {
        case GoldAccountApplyByMedia:
            [self updateMessageWhenApplyTypeEqualGoldAccountApplyByMedia];
            break;
        case GoldAccountApplyByCompany:
            [self updateMessageWhenApplyTypeEqualGoldAccountApplyByCompany];
            break;
        default:
            break;
    }
}

- (void)updateMessageWhenApplyTypeEqualGoldAccountApplyByMedia {
    self.penImage.image = [UIImage imageNamed:@"img_geren"];
    self.suitableLabel.text = @"适合垂直领域专家、意见领袖、评论家及自媒体人士申请";
    [self.sinceMediaButton setTitle:@"自媒体申请" forState:UIControlStateNormal];
    [self.enterpriseGoButton setTitle:@"企业申请" forState:UIControlStateNormal];
}

- (void)updateMessageWhenApplyTypeEqualGoldAccountApplyByCompany {
    self.penImage.image = [UIImage imageNamed:@"img_qiye"];
    self.suitableLabel.text = @"适合各企事业单位申请";
    [self.sinceMediaButton setTitle:@"企业申请" forState:UIControlStateNormal];
    [self.enterpriseGoButton setTitle:@"自媒体申请" forState:UIControlStateNormal];
}

#pragma mark - actionMethod

- (void)applyAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(goldAcountApplyView: applyActionWithApplyType:)]) {
        [self.delegate goldAcountApplyView:self applyActionWithApplyType:self.type];
    }
}

- (void)enterpriseGoAction:(UIButton *)button {
    if (self.type == GoldAccountApplyByMedia) {
        [self updateApplyType:GoldAccountApplyByCompany];
    }else if (self.type == GoldAccountApplyByCompany) {
        [self updateApplyType:GoldAccountApplyByMedia];
    }
    if ([self.delegate respondsToSelector:@selector(goldAcountApplyView: switchingApplyType:)]) {
        [self.delegate goldAcountApplyView:self switchingApplyType:self.type];
    }
}

- (void)tapAction:(UIGestureRecognizer *)gesture {
    if ([self.delegate respondsToSelector:@selector(goldAcountApplyViewDidClicked:)]) {
        [self.delegate goldAcountApplyViewDidClicked:self];
    }
}


@end
