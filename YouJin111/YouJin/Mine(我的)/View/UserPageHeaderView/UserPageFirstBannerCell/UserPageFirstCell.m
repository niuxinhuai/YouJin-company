//
//  UserPageFirstCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "UserPageFirstCell.h"
#import "NSString+Utilities.h"

@implementation UserPageFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    [self configureCell];
}

- (void)configureCell {
    [self addFlagBottomImageView];
    [self.flagLabel sizeToFit];
    [self.headView updateCompanyStatusViewHeight:13 personHeight:17];
    self.headView.showBackgroundView = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.flagBottomImageView makeCornerWithCornerRadius:3];
 //   [self flagColorLayer];
}

- (void)addFlagBottomImageView {
    self.flagBottomImageView = ({
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.image = [UIImage imageNamed:@"user_tab_bottom"];
        [self.contentView insertSubview:imageView belowSubview:self.flagLabel];
        imageView;
    });
    
    [self.flagBottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.flagLabel);
        make.centerY.equalTo(self.flagLabel);
        make.left.equalTo(self.flagLabel).offset(-5);
        make.top.equalTo(self.flagLabel);
    }];
}


#pragma mark - publicMethod

- (void)updateUserInfo:(MinePageItem *)model {
    self.userInfo = model;
    [self.headView updateImageUrlString:model.head_image];
    if ([model.company_vip boolValue]) {
        [self.headView updateHeadStatus:kCompanyVip];
    }else if ([model.person_vip boolValue]) {
        [self.headView updateHeadStatus:kPersonVip];
    }else {
        [self.headView updateHeadStatus:kNormal];
    }
    self.nameLabel.text = model.uname;
    self.fansCountLabel.text = [NSString portStringWithFirstCount:[model.fans intValue] firstSuffix:@"粉丝" secoundCount:[model.counts intValue] secountSuffix:@"关注"];
//    self.subscribeCountLabel.text = [[NSString stringWithCount:[model.counts intValue]] stringByAppendingString:@" 关注"];
//    self.fansCountLabel.text = [[NSString stringWithCount:[model.fans intValue]] stringByAppendingString:@" 粉丝"];
    [self flagLabelHidden:model.tab.length == 0];
    self.flagLabel.text = model.tab;
    [self setNeedsLayout];
}

#pragma mark - helpMethod

- (void)flagColorLayer {
    CAGradientLayer *colorLayer = [CAGradientLayer layer];
    colorLayer.frame = self.flagLabel.bounds;
    colorLayer.colors = @[(id)[UIColor colorWithHexString:@"#FFAE00" alpha:1].CGColor,(id)[UIColor colorWithHexString:@"#FF5A00" alpha:1].CGColor];
    colorLayer.startPoint = CGPointMake(0, 0);
    colorLayer.endPoint = CGPointMake(1, 0);
    [self.flagLabel.layer insertSublayer:colorLayer below:self.flagLabel.layer];
}

- (void)flagLabelHidden:(BOOL)hidden {
    self.flagBottomImageView.hidden = hidden;
    self.flagLabel.hidden = hidden;
}


@end
