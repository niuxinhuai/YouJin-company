//
//  MinePublishCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/31.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MinePublishCell.h"
#import "NSString+Utilities.h"

@implementation MinePublishCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCell];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)configureCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.statusLabel makeCornerWithCornerRadius:3];
}


#pragma mark - publicMethod

- (void)updateModel:(PublishModel *)model {
    if (self.model != model) {
        self.model = model;
        self.contentLabel.text = model.title;
        self.starCountLabel.text = [NSString favourCountString:[model.star integerValue]];
        self.commentCountLabel.text = [NSString commentCountString:[model.lines integerValue]];
        [self fillTypeLableWithModel:model];
    }
}


#pragma mark - helpMethod

- (void)fillTypeLableWithModel:(PublishModel *)model {
    self.statusLabel.text = model.type;
    if ([model.type isEqualToString:@"头条"]) {
        self.statusLabel.backgroundColor = [UIColor colorWithIntRed:84 green:182 blue:250 alpha:1];
    }else if ([model.type isEqualToString:@"动态"]) {
        self.statusLabel.backgroundColor = [UIColor colorWithIntRed:247 green:151 blue:65 alpha:1];
    }
}

@end
