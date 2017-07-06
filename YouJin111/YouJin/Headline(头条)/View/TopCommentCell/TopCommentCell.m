//
//  TopCommentCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/19.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "TopCommentCell.h"
#import "UIButton+Utilities.h"

@implementation TopCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCell];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell {
    self.contentLabel.lineSpacing = 1;
    [self.headView updateCompanyStatusViewHeight:8 personHeight:12];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.contentLabel.activeLinkAttributes = @{(NSString *)kCTUnderlineStyleAttributeName : [NSNumber numberWithBool:NO],(NSString *)kCTForegroundColorAttributeName : (__bridge id)[[UIColor colorWithIntRed:76 green:140 blue:196 alpha:1] CGColor]};
    self.contentLabel.linkAttributes = @{(__bridge NSString *)kCTUnderlineStyleAttributeName : [NSNumber numberWithBool:NO],(NSString *)kCTForegroundColorAttributeName : (__bridge id)[[UIColor colorWithIntRed:76 green:140 blue:196 alpha:1] CGColor]};
    [self addGesture];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.favourButton makeTitleToImageInset];
}


- (void)addGesture {
    self.headView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.headView addGestureRecognizer:tap];
}


#pragma mark - publicMethod

- (void)updateCommentModel:(HuifuModel *)model {
    self.commentModel = model;
    [self.headView updateImageUrlString:model.head_image];
    if ([model.company_vip boolValue]) {
        [self.headView updateHeadStatus:kCompanyVip];
    }else if ([model.person_vip boolValue]) {
        [self.headView updateHeadStatus:kPersonVip];
    }else {
        [self.headView updateHeadStatus:kNormal];
    }
    self.nameLabel.text = model.uname;
    self.contentLabel.text = model.content;
    [self setFavourButtonTitle:[self.commentModel.star stringValue]];
    self.favourButton.selected = [model.is_star boolValue];
    self.timeLabel.text = model.time_h;
    if (model.replyed_uname.length > 0) {
        NSRange range = [model.content rangeOfString:[NSString stringWithFormat:@"%@", model.replyed_uname]];
        [self.contentLabel addLinkToTransitInformation:nil withRange:range];
    }
}
#pragma mark - actionMethod

- (IBAction)replyAction:(UIButton *)sender {
    if (!USERSid) {
        [self alertToLogin];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(topCommentCellDidClickReplyButton:)]) {
        [self.delegate topCommentCellDidClickReplyButton:self];
    }
}

- (IBAction)favourAction:(UIButton *)sender {
    if (!USERSid) {
        [self alertToLogin];
        return;
    }
    if (self.favourButton.selected) return;
    self.commentModel.star = @([self.commentModel.star intValue] + 1);
    self.commentModel.is_star = @1;
    self.favourButton.selected = YES;
    [self setFavourButtonTitle:[self.commentModel.star stringValue]];
    if ([self.delegate respondsToSelector:@selector(topCommentCellDidClickStarButton:)]) {
        [self.delegate topCommentCellDidClickStarButton:self];
    }
}
- (IBAction)nameClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(topCommentCellDidClickName:)]) {
        [self.delegate topCommentCellDidClickName:self];
    }
}


- (void)tap:(UIGestureRecognizer *)sender {
    if (!USERSid) {
        [self alertToLogin];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(topCommentCellDidClickHeadImageView:)]) {
        [self.delegate topCommentCellDidClickHeadImageView:self];
    }
}


#pragma mark - helpMethod

- (void)setFavourButtonTitle:(NSString *)title {
    [self.favourButton setTitle:title forState:UIControlStateNormal];
    [self.favourButton setTitle:title forState:UIControlStateSelected];
    [self layoutSubviews];
}



- (void)alertToLogin {
    if ([self.delegate respondsToSelector:@selector(topCommentCellAlertToLogin:)]) {
        [self.delegate topCommentCellAlertToLogin:self];
    }
}





@end
