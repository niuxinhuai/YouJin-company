//
//  TopContentDetailCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "TopContentDetailCell.h"

static CGFloat BaseCellheight = 229;

@interface TopContentDetailCell ()<UIWebViewDelegate>

@end

@implementation TopContentDetailCell


+ (instancetype)create {
    TopContentDetailCell *cell = [[NSBundle mainBundle] loadNibNamed:@"TopContentDetailCell" owner:nil options:nil].firstObject;
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCell];
    [self addGesture];
}

- (void)layoutSubviews {
    [super layoutSubviews];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    if (self.isObserving) {
        [self removeObservingHeight];
    }
}


#pragma mark - configureCell

- (void)configureCell {
    [self configureWebView];
    [self.rewardButton makeCornerWithCornerRadius:5];
    [self.subscribeButton makeCornerBorderWithWidth:1 cornerRadius:5 borderColor:[UIColor colorWithIntRed:143 green:195 blue:31 alpha:1]];
    [self.headView updateCompanyStatusViewHeight:8 personHeight:12];
}

- (void)addGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    self.headView.userInteractionEnabled = YES;
    [self.headView addGestureRecognizer:tap];
}


- (void)configureWebView {
    self.contentWebView.scalesPageToFit = YES;
    self.contentWebView.delegate = self;
    self.contentWebView.scrollView.bounces = NO;
    self.contentWebView.scrollView.showsHorizontalScrollIndicator = NO;
    self.contentWebView.scrollView.scrollEnabled = NO;
    [self.contentWebView scalesPageToFit];
    self.contentWebView.clipsToBounds = YES;
}

#pragma mark - actionMethod

- (IBAction)subscribeAction:(UIButton *)sender {
    if (!USERSid) {
        [self alertToLogin];
        return;
    }
    sender.enabled = NO;
    if ([self.delegate respondsToSelector:@selector(topContentDetailCell: didClickSubscribe:)]) {
        [self.delegate topContentDetailCell:self didClickSubscribe:[self.content.is_friend boolValue]];
    }
}

- (IBAction)favourAction:(UIButton *)sender {
    if (!USERSid) {
        [self alertToLogin];
        return;
    }
    if ([self.content.is_star boolValue]) return;
    self.content.star = @([self.content.star intValue] + 1);
    self.content.is_star = @1;
    [self updateFavourStatus:[self.content.is_star boolValue] starCount:self.content.star];
    if ([self.delegate respondsToSelector:@selector(topDetailCellDidClickStarButton:)]) {
        [self.delegate topDetailCellDidClickStarButton:self];
    }
}

- (IBAction)rewardAction:(UIButton *)sender {
    if (!USERSid) {
        [self alertToLogin];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(topDetailCellRewardAction:)]) {
        [self.delegate topDetailCellRewardAction:self];
    }
}

- (void)tap:(UIGestureRecognizer *)sender {
    if (!USERSid) {
        [self alertToLogin];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(topDetailCellDidClickHeadImageView:)]) {
        [self.delegate topDetailCellDidClickHeadImageView:self];
    }
}


- (IBAction)wrongAction:(UIButton *)sender {
    if (!USERSid) {
        [self alertToLogin];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(topDetailCellDidClickWrongButton:)]) {
        [self.delegate topDetailCellDidClickWrongButton:self];
    }
}



#pragma mark - publishMethod

- (void)updateContent:(TopContentModel *)content {
    self.content = content;
    [self.headView updateImageUrlString:content.head_image];
    if ([content.company_vip boolValue]) {
        [self.headView updateHeadStatus:kCompanyVip];
    }else if ([content.person_vip boolValue]) {
        [self.headView updateHeadStatus:kPersonVip];
    }else {
        [self.headView updateHeadStatus:kNormal];
    }
    self.nameLabel.text = content.uname;
    self.timeLabel.text = content.time_h;
    self.viewCountLabel.text = [content.click stringValue];
    self.subscribeButton.hidden = [self isMe];
    self.rewardCountLabel.text = [NSString stringWithFormat:@"%@人打赏",content.gift_nums];
    [self updateFavourStatus:[content.is_star boolValue] starCount:content.star];
    [self updateSubscribeStatus:[content.is_friend boolValue]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[TopDetailUrl stringByAppendingString:[NSString stringWithFormat:@"tid=%@",content.tid]]]];
    [self.contentWebView loadRequest:request];
}


#pragma mark - <UIWebViewDelegate>

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self webViewHeightChangeWithWebView:webView];
    if (!self.isObserving) {
        [self addObservingHeight];
    }
}

#pragma mark - observerAction 

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        [self webViewHeightChangeWithWebView:self.contentWebView];
    }
}



- (void)webViewHeightChangeWithWebView:(UIWebView *)webView {
    CGFloat webViewHeight =[[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"]floatValue];
    self.frame = CGRectMake(0, 0, [UIScreen screenWidth], webViewHeight + BaseCellheight);
    self.webViewHeight.constant = webViewHeight;
    [self layoutIfNeeded];
    if ([self.delegate respondsToSelector:@selector(topContentDetailCell: heightChange:)]) {
        [self.delegate topContentDetailCell:self heightChange:(webViewHeight + BaseCellheight)];
    }
}

#pragma mark - helpMethod

- (void)updateSubscribeStatus:(BOOL)subscribe {
    NSString *title = subscribe ? @"已关注" : @"+ 关注";
    [self.subscribeButton setTitle:title forState:UIControlStateNormal];
    CGFloat boardWidth = subscribe ? 0 : 1;
    [self.subscribeButton makeCornerBorderWithWidth:boardWidth cornerRadius:5 borderColor:[UIColor colorWithIntRed:143 green:195 blue:31 alpha:1]];
    UIColor *titleColor = subscribe ? [UIColor colorWithIntRed:153 green:153 blue:153 alpha:1] : [UIColor colorWithIntRed:143 green:195 blue:31 alpha:1];
    [self.subscribeButton setTitleColor:titleColor forState:UIControlStateNormal];
    UIColor *backgroundColor = subscribe ? [UIColor colorWithIntRed:245 green:245 blue:247 alpha:1] : [UIColor whiteColor];
    self.subscribeButton.backgroundColor = backgroundColor;
}

- (BOOL)isMe {
    if ([[self.content.uid stringValue] isEqualToString:USERUID]) {
        return YES;
    }
    return NO;
}

- (void)updateRewarderCount:(NSInteger)rewarderCount {
    self.content.gift_nums = @(rewarderCount);
    self.rewardCountLabel.text = [NSString stringWithFormat:@"%@人打赏",self.content.gift_nums];
}

- (void)updateFavourStatus:(BOOL)isStar starCount:(NSNumber *)count{
    self.starImageView.image = isStar ? [UIImage imageNamed:@"common_icon_dianzan_pre"] : [UIImage imageNamed:@"common_icon_dianzan"];
    self.favourCountLabel.textColor = isStar ? [UIColor colorWithIntRed:70 green:151 blue:251 alpha:1] : [UIColor colorWithIntRed:153 green:153 blue:153 alpha:1];
    self.favourCountLabel.text = [count stringValue];
}


- (void)alertToLogin {
    if ([self.delegate respondsToSelector:@selector(topDetailCellAlertToLogin:)]) {
        [self.delegate topDetailCellAlertToLogin:self];
    }
}

- (void)addObservingHeight {
    [self.contentWebView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    self.isObserving = YES;
}

- (void)removeObservingHeight {
    [self.contentWebView.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
    self.isObserving = NO;
}

@end
