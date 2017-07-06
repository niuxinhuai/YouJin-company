//
//  BaseHeadLineCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseHeadLineCell.h"
#import "NSString+Utilities.h"

@implementation BaseHeadLineCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.statusLabel.hidden = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.statusLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)updateContent:(TopContentModel *)content {
    self.content = content;
    self.titleLabel.text = content.title;
    self.timeLabel.text = content.time_h;
    self.browseLabel.text = [[content.click stringValue] stringByAppendingString:@"浏览"];
    if ([content.is_stick boolValue]) {
        self.statusLabel.hidden = NO;
        self.statusLabel.text = @"置顶";
        self.statusLabel.textColor = [UIColor colorWithIntRed:70 green:151 blue:251 alpha:1];
    }else if ([content.is_myself boolValue]) {
        self.statusLabel.hidden = NO;
        self.statusLabel.text = @"原创";
        self.statusLabel.textColor = [UIColor colorWithIntRed:143 green:195 blue:31 alpha:1];
    }
    [self.statusLabel makeCornerBorderWithWidth:1 cornerRadius:3 borderColor:self.statusLabel.textColor];
    
}






@end
