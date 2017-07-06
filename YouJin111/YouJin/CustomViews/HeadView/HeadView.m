//
//  HeadView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

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

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.headImageView makeCornerWithCornerRadius:self.headImageView.width / 2.0];
    [self.backgroundView makeCornerWithCornerRadius:self.backgroundView.width / 2.0];
}

#pragma mark - configuration

- (void)configureViews {
    self.clipsToBounds = NO;
    [self configureBackgroundView];
    [self configureHeadImageView];
    [self configureStatusView];
}

- (void)configureBackgroundView {
    self.backgroundView = ({
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.hidden = !self.showBackgroundView;
        [self addSubview:view];
        view;
    });
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(-1));
        make.bottom.equalTo(@1);
        make.left.equalTo(@(-1));
        make.right.equalTo(@1);
    }];
}

- (void)configureHeadImageView {
    self.headImageView = ({
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imageView];
        imageView;
    });
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
    }];
}

- (void)configureStatusView {
    self.personStatusView = ({
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:@"user_person_icon"];
        [self addSubview:imageView];
        imageView;
    });
    [self.personStatusView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.personStatusViewHeight));
        make.bottom.equalTo(@0);
        make.height.equalTo(self.personStatusView.mas_width);
        make.right.equalTo(@0);
    }];
    
    self.companyStatusView = ({
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:@"user_company_icon"];
        [self addSubview:imageView];
        imageView;
    });
    [self.companyStatusView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.companyStatusViewHeight));
        make.bottom.equalTo(@0);
        make.width.equalTo(self.companyStatusView.mas_height).multipliedBy(75/36.0);
        make.right.equalTo(@0);
    }];
    
    [self bringSubviewToFront:self.personStatusView];
    
}

#pragma mark - publicMethod

- (void)updateImageUrlString:(NSString *)url {
    self.urlString = url;
//    if (!url || url.length == 0) {
//        self.headImageView.image = [UIImage imageNamed:@"pic_touxiang"];
//        return;
//    }
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pic_touxiang"] options:SDWebImageCacheMemoryOnly];
}


- (void)updateHeadStatus:(HeadStatus)type {
    self.status = type;
    switch (type) {
        case kNormal: {
            self.personStatusView.hidden = YES;
            self.companyStatusView.hidden = YES;
        }
            break;
        case kPersonVip: [self personStatusHidden:NO];
            break;
        case kCompanyVip: [self personStatusHidden:YES];
            break;
        default:
            break;
    }
}

- (void)updateCompanyStatusViewHeight:(CGFloat)height personHeight:(CGFloat)personHeight; {
    self.companyStatusViewHeight = height;
    self.personStatusViewHeight = personHeight;
    [self.personStatusView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(personHeight));
        make.bottom.equalTo(@0);
        make.height.equalTo(self.personStatusView.mas_width);
        make.right.equalTo(@0);
    }];
    [self.companyStatusView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
        make.bottom.equalTo(@0);
        make.width.equalTo(self.companyStatusView.mas_height).multipliedBy(75/36.0);
        make.right.equalTo(@0);
    }];
    [self layoutIfNeeded];
}

#pragma mark - helpMethod

- (void)personStatusHidden:(BOOL)isHidden {
    self.personStatusView.hidden = isHidden;
    self.companyStatusView.hidden = !isHidden;
}

#pragma mark - reget && reset

- (void)setShowBackgroundView:(BOOL)showBackgroundView {
    _showBackgroundView = showBackgroundView;
    self.backgroundView.hidden = !showBackgroundView;
}

@end
