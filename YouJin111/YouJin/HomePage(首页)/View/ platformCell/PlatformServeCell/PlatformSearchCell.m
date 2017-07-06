//
//  PlatformSearchCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/19.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformSearchCell.h"

@implementation PlatformSearchCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       // 添加底部的分割线
        UIView *divisionView = [[UIView alloc] initWithFrame:CGRectMake(15 * BOWidthRate, 69 * BOHeightRate, BOScreenW - 15 * BOWidthRate, 1 * BOHeightRate)];
        divisionView.backgroundColor = [UIColor colorWithHexString:@"#DFE3E6" alpha:1];
        [self.contentView addSubview:divisionView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(15 * BOWidthRate, 10 * BOHeightRate, 50 * BOWidthRate, 50 * BOWidthRate);
    self.imageView.layer.cornerRadius = 8 * BOWidthRate;
    self.imageView.layer.masksToBounds = YES;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 15 * BOHeightRate;
    self.textLabel.height = 50 * BOHeightRate;
    self.textLabel.centerY = self.contentView.centerY;
}

@end
