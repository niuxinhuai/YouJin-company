//
//  LackVIew.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/3.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "LackVIew.h"
#import <Masonry.h>

@implementation LackVIew


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureViews];
}


#pragma mark - configureView

- (void)configureViews {
    [self addLackImageView];
    [self addLackLabel];
    self.backgroundColor = [UIColor whiteColor];
}


- (void)addLackImageView {
    self.lackImageView = ({
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:@"img_b"];
        [self addSubview:imageView];
        imageView;
    });
    
    [self.lackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).offset(-10);
        make.width.equalTo(self.lackImageView.mas_height);
        make.width.equalTo(@(125 * BOWidthRate));
    }];
}

- (void)addLackLabel {
    self.lackLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        [label setFont:[UIFont systemFontOfSize:13]];
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        [self addSubview:label];
        label;
    });
    
    [self.lackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.lackImageView.mas_bottom).offset(5);
    }];
}

#pragma mark - publicMethod
- (void)updateImage:(NSString *)imageString lackText:(NSString *)text {
    self.lackImageView.image = [UIImage imageNamed:imageString];
    self.lackLabel.text = text;
}

- (void)updateImage:(NSString *)imageString {
    self.lackImageView.image = [UIImage imageNamed:imageString];
}

- (void)updateLackText:(NSString *)text {
    self.lackLabel.text = text;
}

@end
