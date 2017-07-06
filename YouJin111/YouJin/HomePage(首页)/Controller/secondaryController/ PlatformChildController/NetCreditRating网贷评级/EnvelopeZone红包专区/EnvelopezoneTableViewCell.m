//
//  EnvelopezoneTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "EnvelopezoneTableViewCell.h"
#import "EnvelopeModel.h"
@implementation EnvelopezoneTableViewCell

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
        self.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        //大红色的背景图片
        UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(35*BOScreenW/750, 0, 680*BOScreenW/750, 278*BOScreenH/1334)];
        bgImage.image = [UIImage imageNamed:@"img_kaquan"];
        [self addSubview:bgImage];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(400*BOScreenW/750, 31*BOScreenH/1334, 240*BOScreenW/750, 30*BOScreenH/1334)];
//        _nameLabel.text = @"惠普理财";
        [_nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
        _nameLabel.textAlignment = NSTextAlignmentRight;
        _nameLabel.textColor = [UIColor whiteColor];
        [bgImage addSubview:_nameLabel];
        
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(40*BOScreenW/750, 75*BOScreenH/1334, 460*BOScreenW/750, 100*BOScreenH/1334)];
//        _moneyLabel.text = @"¥300元理财红包";
        [_moneyLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
        _moneyLabel.textColor = [UIColor whiteColor];
        [bgImage addSubview:_moneyLabel];
//        // 改变字体大小
//        NSMutableAttributedString *str  = [[NSMutableAttributedString alloc] initWithString:_moneyLabel.text];
//        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(1,3)];
//        _moneyLabel.attributedText = str;
        
        //虚线的图片
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(25*BOScreenW/750, 189*BOScreenH/1334, 630*BOScreenW/750, 5*BOScreenH/1334)];
         imageView.image = [self drawLineOfDashByImageView:imageView];
        [bgImage addSubview:imageView];
        
        _downLabel = [[UILabel alloc]initWithFrame:CGRectMake(40*BOScreenH/1334, 195*BOScreenH/1334, 600*BOScreenW/750, 70*BOScreenH/1334)];
//        _downLabel.text = @"注册送300，投资抢红包，理财投资红包，投资惠普理财产品使用，不可直接提现";
        _downLabel.numberOfLines = 0;
        _downLabel.textColor = [UIColor whiteColor];
        _downLabel.font = [UIFont systemFontOfSize:12];
        [bgImage addSubview:_downLabel];
    }
    return self;
}
- (UIImage *)drawLineOfDashByImageView:(UIImageView *)imageView {
    // 开始划线 划线的frame
    UIGraphicsBeginImageContext(imageView.frame.size);
    
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    
    // 获取上下文
    CGContextRef line = UIGraphicsGetCurrentContext();
    
    // 设置线条终点的形状
    CGContextSetLineCap(line, kCGLineCapRound);
    // 设置虚线的长度 和 间距
    CGFloat lengths[] = {5,1};
    
    CGContextSetStrokeColorWithColor(line, [UIColor colorWithHexString:@"#fa9d8a" alpha:1].CGColor);
    // 开始绘制虚线
    CGContextSetLineDash(line, 0, lengths, 1);
    
    CGContextMoveToPoint(line, 0.0, 1.0);
    
    CGContextAddLineToPoint(line, 630*BOScreenW/750, 1.0);
    
    CGContextStrokePath(line);
    
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}
-(void)setItem:(EnvelopeModel *)item
{
    _item = item;
    _nameLabel.text = item.name;
    _moneyLabel.text = [NSString stringWithFormat:@"¥%@元理财红包",item.show_money];
    // 改变字体大小
    NSString *str1 = @"¥";
    long len1 = [str1 length];
    long len2 = [item.show_money length];
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:_moneyLabel.text];
    [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24.0f] range:NSMakeRange(len1,len2)];
    _moneyLabel.attributedText = str2;
    
    _downLabel.text = item.desc;
}
@end
