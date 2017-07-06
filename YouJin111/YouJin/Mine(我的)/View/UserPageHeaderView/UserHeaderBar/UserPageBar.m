//
//  UserPageBar.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "UserPageBar.h"

@implementation UserPageBar

+ (instancetype)create {
    UserPageBar *bar = [[NSBundle mainBundle]loadNibNamed:@"UserPageBar" owner:nil options:nil].firstObject;
    return bar;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userInteractionEnabled = YES;
    [self buttonSelectedWithType:remarkSelected];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.width = [UIScreen screenWidth];
    self.height = 40;
}

- (void)configureViews {
}


#pragma mark - actionMethod

- (IBAction)remarkAction:(UIButton *)sender {
    [self updateSelectType:remarkSelected callDelegate:YES];
}
- (IBAction)commentAction:(UIButton *)sender {
    [self updateSelectType:commentSelected callDelegate:YES];
}
- (IBAction)publishAction:(UIButton *)sender {
    [self updateSelectType:publishSelected callDelegate:YES];
}


- (void)updateSelectType:(UserPageBarSelectType)type callDelegate:(BOOL)isCall{
    if (self.selectType != type) {
        self.selectType = type;
        [self buttonSelectedWithType:type];
        if (isCall && [self.delegate respondsToSelector:@selector(userPageBar: changeSelectedType:)]) {
            [self.delegate userPageBar:self changeSelectedType:type];
        }
    }
}

#pragma mark - publicMethod

- (void)updateButtonTitleJudgeIsMe:(BOOL)isMe {
    NSString *title = isMe ? @"我的": @"TA的";
    [self button:self.remarkButton updateTitleWithTitle:[title stringByAppendingString:@"点评"]];
    [self button:self.publishButton updateTitleWithTitle:[title stringByAppendingString:@"发表"]];
    [self button:self.commentButton updateTitleWithTitle:[title stringByAppendingString:@"评论"]];
}


#pragma mark - helpMethod

- (void)buttonSelectedWithType:(UserPageBarSelectType)type {
    self.remarkButton.selected = type == remarkSelected;
    self.publishButton.selected = type == publishSelected;
    self.commentButton.selected = type == commentSelected;
}




- (void)button:(UIButton *)button updateTitleWithTitle:(NSString *)title {
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
}


@end
