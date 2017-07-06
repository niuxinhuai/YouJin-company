//
//  SubscribeCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/11.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "SubscribeCell.h"
#import "NSString+Utilities.h"

@implementation SubscribeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCell];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)configureCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.cancelSubscribeButton makeCornerWithCornerRadius:5];
    [self.subscrubeButton makeCornerBorderWithWidth:1 cornerRadius:5 borderColor:[UIColor colorWithIntRed:143 green:195 blue:31 alpha:1]];
    [self.headView updateCompanyStatusViewHeight:10 personHeight:15];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - publicMethod

- (void)updateAttentionModel:(AttentionModel *)model {
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
    if (self.isFromGold) {
         self.countLabel.text = [NSString portStringWithFirstCount:[model.top_nums intValue] firstSuffix:@"头条" secoundCount:[model.fans intValue] secountSuffix:@"粉丝"];
    }else {
         self.countLabel.text = [NSString portStringWithFirstCount:[model.dianping_nums intValue] firstSuffix:@"点评" secoundCount:[model.news_nums intValue] secountSuffix:@"动态"];
    }
    [self subscribeHidden:[model.is_each_other boolValue]];
    [self subscribeButtonEnable:YES];
}

#pragma mark - helpMethod

- (void)subscribeHidden:(BOOL)hidden {
    self.subscrubeButton.hidden = hidden;
    self.cancelSubscribeButton.hidden = !hidden;
}

- (void)subscribeButtonEnable:(BOOL)enable {
    self.subscrubeButton.enabled = enable;
    self.cancelSubscribeButton.enabled = enable;
}


#pragma mark - actionMethod

- (IBAction)subscirbeAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(subscribeCell: didClickSubscibe:)]) {
        [self.delegate subscribeCell:self didClickSubscibe:sender == self.subscrubeButton];
    }
    
}



@end
