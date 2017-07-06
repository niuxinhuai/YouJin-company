//
//  HotSearchButton.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/11.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HotSearchButton.h"
@interface HotSearchButton()

@end
@implementation HotSearchButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *shopImageV = [[UIImageView alloc] init];
        self.shopImageV = shopImageV;
        shopImageV.layer.cornerRadius = 8 * BOWidthRate;
        shopImageV.layer.masksToBounds = YES;
        [self addSubview:shopImageV];
        
        UILabel *shopLabel = [[UILabel alloc] init];
        self.shopLabel = shopLabel;
        [shopLabel setFont:[UIFont systemFontOfSize:12]];
        shopLabel.textAlignment = NSTextAlignmentCenter;
        shopLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [self addSubview:shopLabel];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.shopImageV.frame = CGRectMake((self.width - 50 * BOWidthRate) * 0.5, 0, 50 * BOWidthRate, 50 * BOWidthRate);
    self.shopLabel.frame = CGRectMake(0, CGRectGetMaxY(self.shopImageV.frame) + 10 * BOHeightRate, self.width, 15 * BOHeightRate);
}

@end
