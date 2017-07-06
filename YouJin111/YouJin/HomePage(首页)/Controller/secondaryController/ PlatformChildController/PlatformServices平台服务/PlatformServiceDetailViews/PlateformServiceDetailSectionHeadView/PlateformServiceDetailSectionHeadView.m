//
//  PlateformServiceDetailSectionHeadView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlateformServiceDetailSectionHeadView.h"

@implementation PlateformServiceDetailSectionHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureViews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViews];
    }
    return self;
}

- (void)configureViews {
    self.backgroundColor = [UIColor whiteColor];
    self.label = ({
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor colorWithIntRed:51 green:51 blue:51 alpha:1];
        [label sizeToFit];
        [self addSubview:label];
        label;
    });
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@(15));
    }];
    
    self.arrowImageView = ({
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_goto"]];
        [self addSubview:imageView];
        imageView;
    });
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(@(-15));
        make.height.equalTo(@(12));
        make.width.equalTo(self.arrowImageView.mas_height).multipliedBy(7 / 12.0);
    }];
    
    self.lineView = ({
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor placeholderColor];
        [self addSubview:lineView];
        lineView;
    });
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.height.equalTo(@1);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
}


@end
