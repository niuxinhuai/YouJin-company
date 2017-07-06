//
//  IntroductionPlatformView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "IntroductionPlatformView.h"
#import "PlatformDetailsModel.h"

@implementation IntroductionPlatformView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        //平台简介logo
        UIImageView *introductionImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 40*BOScreenW/750, 40*BOScreenW/750)];
        introductionImage.image = [UIImage imageNamed:@"icon_ptjj"];
        [self addSubview:introductionImage];
        
        //平台简介
        UILabel *introductionLabel = [[UILabel alloc]initWithFrame:CGRectMake(85*BOScreenW/750, 25*BOScreenH/1334, 230*BOScreenW/750, 40*BOScreenH/1334)];
        introductionLabel.text = @"平台简介";
        introductionLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        introductionLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:introductionLabel];
        
        //2016-08-30上线
        _onlineLabel = [[UILabel alloc]initWithFrame:CGRectMake(BOScreenW - 330*BOScreenW/750, 25*BOScreenH/1334, 300*BOScreenW/750, 40*BOScreenH/1334)];
//        _onlineLabel.text = @"2016-08-30上线";
        _onlineLabel.textAlignment = NSTextAlignmentRight;
        _onlineLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        _onlineLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_onlineLabel];
        
        //线view
        UIView *LineView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 89*BOScreenH/1334, BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
        LineView.backgroundColor = [UIColor colorWithHexString:@"dfe3e6" alpha:1];
        [self addSubview:LineView];

        //平台简介详情
        _lineViewY = CGRectGetMaxY(LineView.frame) + 30*BOScreenH/1334;
       _detailIntLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, _lineViewY, BOScreenW - 70*BOScreenW/750, 170*BOScreenH/1334)];
//        _detailIntLabel.text = @"平台品牌著称的";
        _detailIntLabel.numberOfLines = 4;
        _detailIntLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
        _detailIntLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_detailIntLabel];
        
        //全文 按钮
        _detailIntLabelY = CGRectGetMaxY(_detailIntLabel.frame) + 10*BOScreenH/1334;
        _allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _allButton.frame = CGRectMake(30*BOScreenW/750, _detailIntLabelY, 70*BOScreenW/750, 40*BOScreenH/1334);
        [_allButton setTitle:@"全文" forState:UIControlStateNormal];
        [_allButton setTitleColor:[UIColor colorWithHexString:@"#4c8cc4" alpha:1] forState:UIControlStateNormal];
        _allButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _allButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:_allButton];

    }
    return self;
}
-(void)setItem:(PlatformDetailsModel *)item
{
    _item = item;
    self.onlineLabel.text = [NSString stringWithFormat:@"%@上线",item.begin_time];
//    //平台简介详情
//    self.detailIntLabel.text = item.pt_desc;
//    //设置行高
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: _detailIntLabel.text];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:6];
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_detailIntLabel.text length])];
//    _detailIntLabel.attributedText = attributedString;
//    [_detailIntLabel sizeToFit];
//    _detailIntLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//    
//    _heights = [self boundingRectWithString:self.detailIntLabel.text];
}
//#pragma mark---全文的点击事件---
//- (void)allButtonClick
//{
//    if (_onAndoff)
//    {
//        NSLog(@"ssssssss");
//        _onAndoff = NO;
//    }else
//    {
//        NSLog(@"oooooo");
//        _detailIntLabel.numberOfLines = 0;
//        _detailIntLabel.frame = CGRectMake(30*BOScreenW/750, _lineViewY, BOScreenW - 70*BOScreenW/750, _heights);
//        [_detailIntLabel sizeToFit];
//        _onAndoff = YES;
//    }
//}
////计算高度的方法,可自行封装
//- (CGFloat)boundingRectWithString:(NSString *)string
//{
//    CGRect rect = [string boundingRectWithSize:CGSizeMake(BOScreenW - 70*BOScreenW/750, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
//    return  rect.size.height;
//}
@end
