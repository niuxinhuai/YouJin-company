//
//  StarView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "StarView.h"
#import <Masonry.h>

@implementation StarView

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
    [self addBackView];
    [self addForeView];
    [self addBackImageView];
    [self addForeImageView];
    [self updateForeImage:@"total_yellow_star" backImage:@"total_gray_star"];
}

- (void)addForeView {
    self.foreView = ({
        UIView *view = [[UIImageView alloc]init];
        [self addSubview:view];
        view.clipsToBounds = YES;
        view;
    });
    
    [self.foreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left);
        make.width.equalTo(self.backView.mas_width).multipliedBy(0);
        make.height.equalTo(self.backView.mas_height);
        make.top.equalTo(self.backView.mas_top);
    }];
}
- (void)addBackView {
    self.backView = ({
        UIView *view = [[UIImageView alloc]init];
        [self addSubview:view];
        view;
    });
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

- (void)addBackImageView {
    self.backImageView = ({
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.backView addSubview:imageView];
        imageView;
    });
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

- (void)addForeImageView {
    self.foreImageView = ({
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.foreView addSubview:imageView];
        imageView;
    });
    
    [self.foreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.width.equalTo(self.mas_width);
        make.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
}

#pragma mark - publicMethod

- (void)updateScore:(CGFloat)score {
    if (self.score != score) {
        self.score = score;
        [self.foreView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView.mas_left);
            make.width.equalTo(self.backView.mas_width).multipliedBy(score);
            make.height.equalTo(self.backView.mas_height);
            make.top.equalTo(self.backView.mas_top);
        }];
        [self layoutIfNeeded];
    }
}


- (void)updateForeImage:(NSString *)foreString backImage:(NSString *)backString  {
    self.foreImageView.image = [UIImage imageNamed:foreString];
    self.backImageView.image = [UIImage imageNamed:backString];
}


@end
