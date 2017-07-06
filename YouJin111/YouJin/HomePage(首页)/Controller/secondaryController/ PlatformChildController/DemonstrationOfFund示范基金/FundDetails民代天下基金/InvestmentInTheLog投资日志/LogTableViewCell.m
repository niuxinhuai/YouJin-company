//
//  LogTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "LogTableViewCell.h"

@implementation LogTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 调整行间距
    NSMutableAttributedString *fourattributedString = [[NSMutableAttributedString alloc] initWithString:self.logDetailLabel.text];
    NSMutableParagraphStyle *fourparagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [fourparagraphStyle setLineSpacing:6];
    [fourattributedString addAttribute:NSParagraphStyleAttributeName value:fourparagraphStyle range:NSMakeRange(0, [self.logDetailLabel.text length])];
    self.logDetailLabel.attributedText = fourattributedString;
    [self.logDetailLabel sizeToFit];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
