//
//  InvestmentGuideView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/25.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "InvestmentGuideView.h"

@implementation InvestmentGuideView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.oneContentLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:7];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.oneContentLabel.text length])];
    self.oneContentLabel.attributedText = attributedString;
    [self.oneContentLabel sizeToFit];
    // 调整行间距
    NSMutableAttributedString *twoattributedString = [[NSMutableAttributedString alloc] initWithString:self.twoContentLabel.text];
    NSMutableParagraphStyle *twoparagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [twoparagraphStyle setLineSpacing:7];
    [twoattributedString addAttribute:NSParagraphStyleAttributeName value:twoparagraphStyle range:NSMakeRange(0, [self.twoContentLabel.text length])];
    self.twoContentLabel.attributedText = twoattributedString;
    [self.twoContentLabel sizeToFit];
    // 调整行间距
    NSMutableAttributedString *threeattributedString = [[NSMutableAttributedString alloc] initWithString:self.threeContentLabel.text];
    NSMutableParagraphStyle *threeparagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [threeparagraphStyle setLineSpacing:7];
    [threeattributedString addAttribute:NSParagraphStyleAttributeName value:threeparagraphStyle range:NSMakeRange(0, [self.threeContentLabel.text length])];
    self.threeContentLabel.attributedText = threeattributedString;
    [self.threeContentLabel sizeToFit];
    // 调整行间距
    NSMutableAttributedString *fourattributedString = [[NSMutableAttributedString alloc] initWithString:self.fourContentLabel.text];
    NSMutableParagraphStyle *fourparagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [fourparagraphStyle setLineSpacing:7];
    [fourattributedString addAttribute:NSParagraphStyleAttributeName value:fourparagraphStyle range:NSMakeRange(0, [self.fourContentLabel.text length])];
    self.fourContentLabel.attributedText = fourattributedString;
    [self.fourContentLabel sizeToFit];
}

@end
