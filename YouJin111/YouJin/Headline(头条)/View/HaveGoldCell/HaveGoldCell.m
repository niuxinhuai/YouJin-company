//
//  HaveGoldCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/5.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HaveGoldCell.h"

@implementation HaveGoldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCell];
    [self addGesture];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.headView updateCompanyStatusViewHeight:9 personHeight:13];
}

- (void)addGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    self.headView.userInteractionEnabled = YES;
    [self.headView addGestureRecognizer:tap];
}


#pragma mark - actionMethod

- (void)tap:(UIGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(haveGoldCellDidClickUserHead:)]) {
        [self.delegate haveGoldCellDidClickUserHead:self];
    }
}


#pragma mark - helpMethod

- (void)updateFoucsModel:(GoldAccountFoucsModel *)model {
    self.model = model;
    [self.headView updateImageUrlString:model.head_image];
    if ([model.company_vip boolValue]) {
        [self.headView updateHeadStatus:kCompanyVip];
    }else if ([model.person_vip boolValue]) {
        [self.headView updateHeadStatus:kPersonVip];
    }else {
        [self.headView updateHeadStatus:kNormal];
    }
    self.nameLabel.text = model.uname;
    self.contentLabel.text = model.title;
}




@end
