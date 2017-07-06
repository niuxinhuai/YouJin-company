//
//  MoreTaskTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MoreTaskTableViewCell.h"
#import "OnlyOneTableViewModel.h"

@implementation MoreTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        //底部灰色的view
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 180*BOScreenH/1334)];
        bgView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        [self addSubview:bgView];
        //白色的圆角view
        _whiteView = [[UIView alloc]initWithFrame:CGRectMake(20*BOScreenW/750, 0, 710*BOScreenW/750, 160*BOScreenH/1334)];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.layer.cornerRadius = 8;
        _whiteView.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;
        _whiteView.layer.shadowOffset = CGSizeMake(0,2);
        _whiteView.layer.shadowOpacity = 0.3;
        _whiteView.layer.shadowRadius = 3;
        [bgView addSubview:_whiteView];
        //图片icon
        _imgeView = [[UIImageView alloc]initWithFrame:CGRectMake(20*BOScreenW/750, 30*BOScreenH/1334, 100*BOScreenW/750, 100*BOScreenW/750)];
        _imgeView.layer.cornerRadius = 8;
        _imgeView.layer.masksToBounds = YES;
        _imgeView.image = [UIImage imageNamed:@"logo_youjin"];
        [_whiteView addSubview:_imgeView];

        //互惠理财
        _imgeViewX = CGRectGetMaxX(_imgeView.frame) + 24*BOScreenW/750;
        _manageMMLabel = [[UILabel alloc]init];
//        _manageMMLabel.text = @"互惠理财";
        _manageMMLabel.font = [UIFont fontWithName:@"Helvetica-Bold"size:14];
        [_manageMMLabel setTextColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
//        //根据字体得到NSString的尺寸
//        CGSize size = [_manageMMLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_manageMMLabel.font,NSFontAttributeName, nil]];
//        //名字的W
//        CGFloat nameW = size.width;
//        _manageMMLabel.frame = CGRectMake(_imgeViewX, 40*BOScreenH/1334, nameW,30*BOScreenH/1334);
        [_whiteView addSubview:_manageMMLabel];

        //分割线
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#999999" alpha:0.5];
        [_whiteView addSubview:_lineView];
        
        //理财详情
//        CGFloat _lineViewX = CGRectGetMaxX(_lineView.frame) + 10*BOScreenW/750;
        _detailsLabel = [[UILabel alloc]init];
//        _detailsLabel.text = @"阿里巴巴A轮五千万投资，江西银行存管rrrrrrrr";
        _detailsLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
        _detailsLabel.font = [UIFont fontWithName:@"Helvetica-Bold"size:11];
        [_whiteView addSubview:_detailsLabel];
        
        //奖励9000u币
        _awardLabel = [[UILabel alloc]init];
//        _awardLabel.text = @"奖励:  9000";
        _awardLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        _awardLabel.font = [UIFont systemFontOfSize:13];
        
//        //根据字体得到NSString的尺寸
//        CGSize sizes = [_awardLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_awardLabel.font,NSFontAttributeName, nil]];
//        //名字的W
//        CGFloat nameWs = sizes.width;
//        _awardLabel.frame = CGRectMake(_imgeViewX, 92*BOScreenH/1334, nameWs,30*BOScreenH/1334);
        [_whiteView addSubview:_awardLabel];
        
//        //label中间添加图片
//        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@"奖励:  9000"];
//        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
//        attch.image = [UIImage imageNamed:@"common_icon_ub"];
//        attch.bounds = CGRectMake(0, -2, 27*BOScreenW/750, 27*BOScreenW/750);
//        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
//        [attri insertAttributedString:string atIndex:4];//在第几个文字后面
//        _awardLabel.attributedText = attri;
        
//        //字体显示两种颜色
//        NSRange nineredRangeTwo = NSMakeRange([[attri string] rangeOfString:@"9000"].location, [[attri string] rangeOfString:@"9000"].length);
//        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5a00" alpha:1] range:nineredRangeTwo];
//        [_awardLabel setAttributedText:attri];
//        [_awardLabel sizeToFit];
        
        //u盾计划
//        CGFloat awardLabelX = CGRectGetMaxX(_awardLabel.frame) + 20*BOScreenW/750;
        _shieldImage = [[UIImageView alloc]init];
        _shieldImage.image = [UIImage imageNamed:@"note_udjh"];
        [_whiteView addSubview:_shieldImage];
        
        //审核中
        _auditImage = [[UIImageView alloc]initWithFrame:CGRectMake(BOScreenW-120*BOScreenW/750, 95*BOScreenH/1334, 80*BOScreenW/750, 27*BOScreenH/1334)];
        _auditImage.image = [UIImage imageNamed:@"img_shz"];
        [_whiteView addSubview:_auditImage];
        
        //对号图片
        _checkImage = [[UIImageView alloc]initWithFrame:CGRectMake(BOScreenW - 108*BOScreenW/750, 160*BOScreenH/1334 - 68*BOScreenW/750, 68*BOScreenW/750, 68*BOScreenW/750)];
        _checkImage.image = [UIImage imageNamed:@"img_complete"];
        [_whiteView addSubview:_checkImage];
    }
    return self;
}
-(void)setItem:(OnlyOneTableViewModel *)item
{
    _item = item;
    //设置logo
    [self.imgeView sd_setImageWithURL:[NSURL URLWithString:item.logo] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
    
    //设置平台名称
    self.manageMMLabel.text = item.name;
    //根据字体得到NSString的尺寸
    CGSize size = [_manageMMLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_manageMMLabel.font,NSFontAttributeName, nil]];
            //名字的W
    CGFloat nameW = size.width;
    _manageMMLabel.frame = CGRectMake(_imgeViewX, 40*BOScreenH/1334, nameW,30*BOScreenH/1334);
    //分割线
    CGFloat manageMMLabelX = CGRectGetMaxX(_manageMMLabel.frame) + 10*BOScreenW/750;
    _lineView.frame = CGRectMake(manageMMLabelX, self.manageMMLabel.frame.origin.y, 1, 30*BOScreenH/1334);
    //理财详情
    CGFloat _lineViewX = CGRectGetMaxX(_lineView.frame) + 10*BOScreenW/750;
    _detailsLabel.frame = CGRectMake(_lineViewX, 40*BOScreenH/1334, 710*BOScreenW/750 - _lineViewX-40*BOScreenW/750, 30*BOScreenH/1334);
    _detailsLabel.text = item.title;
    
    if ([item.show_money isEqualToString:@"0"])
    {
        _awardLabel.frame = CGRectMake(_imgeViewX, 92*BOScreenH/1334, 0,30*BOScreenH/1334);
    }else
    {
        //奖励u币
//        int m = [item.show_money intValue]/10000;
//        NSString *strM = [NSString stringWithFormat:@"%d万",m];
        _awardLabel.text = [NSString stringWithFormat:@"  %@",item.show_money];
        //根据字体得到NSString的尺寸
        CGSize sizes = [_awardLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_awardLabel.font,NSFontAttributeName, nil]];
        //名字的W
        CGFloat nameWs = sizes.width;
        _awardLabel.frame = CGRectMake(_imgeViewX, 92*BOScreenH/1334, nameWs,30*BOScreenH/1334);
        //label中间添加图片
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",item.show_money]];
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        attch.image = [UIImage imageNamed:@"common_icon_ub"];
        attch.bounds = CGRectMake(0, -2, 27*BOScreenW/750, 27*BOScreenW/750);
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        [attri insertAttributedString:string atIndex:0];//在第几个文字后面
        _awardLabel.attributedText = attri;
        //字体显示两种颜色
        NSRange nineredRangeTwo = NSMakeRange([[attri string] rangeOfString:item.show_money].location, [[attri string] rangeOfString:item.show_money].length);
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5a00" alpha:1] range:nineredRangeTwo];
        [_awardLabel setAttributedText:attri];
        [_awardLabel sizeToFit];
    }
//    //奖励u币
//    int m = [item.show_money intValue]/10000;
//    NSString *strM = [NSString stringWithFormat:@"%d万",m];
//    _awardLabel.text = [NSString stringWithFormat:@"奖励:  %@",strM];
//    //根据字体得到NSString的尺寸
//    CGSize sizes = [_awardLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_awardLabel.font,NSFontAttributeName, nil]];
//    //名字的W
//    CGFloat nameWs = sizes.width;
//    _awardLabel.frame = CGRectMake(_imgeViewX, 92*BOScreenH/1334, nameWs,30*BOScreenH/1334);
//    //label中间添加图片
//    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"奖励:  %@",strM]];
//    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
//    attch.image = [UIImage imageNamed:@"common_icon_ub"];
//    attch.bounds = CGRectMake(0, -2, 27*BOScreenW/750, 27*BOScreenW/750);
//    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
//    [attri insertAttributedString:string atIndex:4];//在第几个文字后面
//    _awardLabel.attributedText = attri;
//    //字体显示两种颜色
//    NSRange nineredRangeTwo = NSMakeRange([[attri string] rangeOfString:strM].location, [[attri string] rangeOfString:strM].length);
//    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5a00" alpha:1] range:nineredRangeTwo];
//    [_awardLabel setAttributedText:attri];
//    [_awardLabel sizeToFit];
    
    //u盾计划
    CGFloat awardLabelX = CGRectGetMaxX(_awardLabel.frame) + 20*BOScreenW/750;
    _shieldImage.frame = CGRectMake(awardLabelX, 95*BOScreenH/1334, 125*BOScreenW/750, 27*BOScreenH/1334);
    if ([item.is_baozhang intValue] == 0)
    {
        _shieldImage.hidden = YES;
    }
    else if ([item.is_baozhang intValue] == 1)
    {
        _shieldImage.hidden = NO;
    }else
    {
        _shieldImage.hidden = YES;
    }
    
    //审核中和审核成功
    if ([item.status intValue] == 0)
    {
        _auditImage.hidden = YES;
        _checkImage.hidden = YES;
    }else if ([item.status intValue] == 1)
    {
        _auditImage.hidden = NO;
        _checkImage.hidden = YES;
    }else if ([item.status intValue] == 2)
    {
        _auditImage.hidden = YES;
        _checkImage.hidden = NO;
    }else if ([item.status intValue] == 3)
    {
        _auditImage.hidden = YES;
        _checkImage.hidden = YES;
    }else
    {
        _auditImage.hidden = YES;
        _checkImage.hidden = YES;
    }
}

@end
