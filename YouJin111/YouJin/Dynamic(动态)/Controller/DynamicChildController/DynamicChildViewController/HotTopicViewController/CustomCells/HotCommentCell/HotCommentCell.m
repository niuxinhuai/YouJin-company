//
//  HotCommentCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HotCommentCell.h"
#import "NSString+Utilities.h"
#import "StarView.h"


@implementation HotCommentCell


- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCell];
    [self addGesture];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - configureCell
- (void)configureCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.targetLogoImageView makeCornerWithCornerRadius:5];
    self.targetLogoImageView.layer.masksToBounds = YES;
    self.commentLabel.lineSpacing = 1;
    [self.starView updateForeImage:@"total_yellow_star" backImage:@"total_gray_star"];
    [self.headView updateCompanyStatusViewHeight:10 personHeight:15];
}


- (void)addGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headImageClicked:)];
    [self.headView addGestureRecognizer:tap];
    self.headView.userInteractionEnabled = YES;
}


- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - publicMethod

- (void)updateCommentModel:(HotCommentModle *)model {
    if (self.model != model) {
        self.model = model;
        [self.headView updateImageUrlString:model.head_image];
        if ([model.company_vip boolValue]) {
            [self.headView updateHeadStatus:kCompanyVip];
        }else if ([model.person_vip boolValue]) {
            [self.headView updateHeadStatus:kPersonVip];
        }else {
            [self.headView updateHeadStatus:kNormal];
        }
        [self updateShowTransform:self.isTransform];
        self.commentTargetLabel.text = self.showHeadImageView ? @"" : [NSString commentTagetStringWithTarget:model.object];
        self.timeLabel.text = model.before;
        self.commentLabel.text = model.content;
        [self.starView updateScore:[model.score floatValue] / 5.0];
        self.gradeLabel.text = [NSString stringWithFormat:@"%.1f分",[model.score floatValue]];
        [self.targetLogoImageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
        self.targetNameLabel.text = model.object;
        self.targetStatusLabel.text = [NSString commentTargetEvaluateWithHotCommentModel:model];
    }
}

- (void)updateShowHeadImageView:(BOOL)show {
    self.showHeadImageView = show;
    if (show) {
        self.nameLableLeftToHeadImageView.constant = 10;
        self.headView.hidden = NO;
    }else {
        self.nameLableLeftToHeadImageView.constant = -45;
        self.headView.hidden = YES;
    }
    [self layoutIfNeeded];
    self.commentTargetLabel.hidden = show;
}

- (void)updateShowTransform:(BOOL)isTransform {
    self.isTransform = isTransform;
    self.userNameLabel.text = self.model.uname;
    if (isTransform) {
        self.userNameLabel.text = [[self.model.uid stringValue] isEqualToString:USERUID] ? @"我" : self.model.uname;
    }
}

#pragma mark - actionMethod

- (IBAction)userNameClicked:(UIButton *)sender {
    if (!USERSid) {
        [self alterToPushLoginViewController];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(hotCommentCellDidClickName:)]) {
        [self.delegate hotCommentCellDidClickName:self];
    }
}

- (void)headImageClicked:(UIGestureRecognizer *)sender {
    if (!USERSid) {
        [self alterToPushLoginViewController];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(hotCommentCellDidClickHeadImageView:)]) {
        [self.delegate hotCommentCellDidClickHeadImageView:self];
    }
}
- (IBAction)platformCilicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(hotCommentCellDidClickPlatform:)]) {
        [self.delegate hotCommentCellDidClickPlatform:self];
    }
}


#pragma mark - helpMethod

- (void)alterToPushLoginViewController {
    if ([self.delegate respondsToSelector:@selector(hotCommentCellAlertToPushLogin:)]) {
        [self.delegate hotCommentCellAlertToPushLogin:self];
    }
}


@end
