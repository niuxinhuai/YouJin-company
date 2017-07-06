//
//  BuyBazaarChildCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BuyBazaarChildCell.h"

@implementation BuyBazaarChildCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat labelW = 80 * BOScreenW / BOPictureW;
        // 创建基金公司的label
        CGFloat nameX = 17 * BOScreenW / BOPictureW;
        CGFloat nameY = 5 * BOScreenH / BOPictureH;
        CGFloat nameH = 20 * BOScreenH / BOPictureH;
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, labelW, nameH)];
        nameLabel.text = @"一两理财";
        [nameLabel setFont:[UIFont systemFontOfSize:12]];
        // 创建当月的存量的label
        CGFloat currentX = CGRectGetMaxX(nameLabel.frame) + 60 * BOPictureW / BOPictureH;
        CGFloat currentY = nameY;
        CGFloat currentH = nameH;
        UILabel *currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(currentX, currentY, labelW, currentH)];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, BOColor(252, 91, 31), NSForegroundColorAttributeName, nil];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"↑2,000,000"];
        [attributeString setAttributes:dictionary range:NSMakeRange(0, 1)];
        NSDictionary *dictionary1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, [UIColor blackColor], NSForegroundColorAttributeName, nil];
        [attributeString setAttributes:dictionary1 range:NSMakeRange(1, 9)];

        currentLabel.attributedText = attributeString;
        [currentLabel setFont:[UIFont systemFontOfSize:12]];
        // 创建显示上月存量的label
        CGFloat lastX = CGRectGetMaxX(currentLabel.frame) + 60 * BOScreenW / BOPictureW;
        CGFloat lastY = nameY;
        CGFloat lastH = nameH;
        UILabel *lastLabel = [[UILabel alloc] initWithFrame:CGRectMake(lastX, lastY, labelW, lastH)];
        lastLabel.text = @"100000";
        [lastLabel setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:nameLabel];
        [self addSubview:currentLabel];
        [self addSubview:lastLabel];
        
        // 设置背景颜色
        [self setBackgroundColor:BOColor(250, 250, 250)];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
