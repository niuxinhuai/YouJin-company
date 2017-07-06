//
//  RewardView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/31.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "RewardView.h"

@interface RewardView()<UITextFieldDelegate>

@end

@implementation RewardView


+ (instancetype)create {
    RewardView *view = [[NSBundle mainBundle]loadNibNamed:@"RewardView" owner:nil options:nil].firstObject;
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureViews];
    [self addGestures];
    [self layoutConstraintConfigure];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = [UIScreen bounds];
}

#pragma mark - configureViews 

- (void)configureViews {
    self.userInteractionEnabled = YES;
    [self.containerView makeCornerWithCornerRadius:13];
    [self.rewardButton makeCornerWithCornerRadius:self.rewardButton.height / 2.0];
    [self.headImageView makeCornerWithCornerRadius:self.headImageView.height / 2.0];
    self.rewardCountLabel.text = @"100";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    self.rewardTextField.delegate = self;
    [self rewardButtonEnableWithText:self.rewardCountLabel.text];
}


- (void)addGestures {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}

- (void)layoutConstraintConfigure {
    if ([UIScreen screenWidth] == 320) {
        self.containerWidth.constant = ContainerWidthRate * [UIScreen screenWidth];
        self.topContainerHeght.constant = 100;
        self.containerHeight.constant = 300;
    }else {
        self.containerWidth.constant = 290;
        self.topContainerHeght.constant = 110;
        self.containerHeight.constant = 320;
    }
}


#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self rewardButtonEnableWithText:textField.text];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self rewardButtonEnableWithText:textField.text];
}


#pragma mark - actionMethod

- (IBAction)rewardAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(rewardView: rewardCount:)]) {
        [self.delegate rewardView:self rewardCount:self.rewardCount];
    }
}


- (IBAction)closeAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(rewardViewDidClosed:)]) {
        [self.delegate rewardViewDidClosed:self];
    }
    [self close];
}

- (IBAction)inputSwiching:(UIButton *)sender {
    [self rewardButtonEnableWithText:self.rewardTextField.text];
    [self inputSwichingSecondContainerShow:YES];
}

- (void)tap:(UIGestureRecognizer *)sender {
    [self endEditing:YES];
}

- (void)textFieldDidChange:(NSNotification *)sender {
    [self rewardButtonEnableWithText:self.rewardTextField.text];
}
#pragma mark - alertShowAndClose

- (void)show
{
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    self.containerView.layer.opacity = 0.5f;
    self.containerView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
    self.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0];
    [UIView animateWithDuration:.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
                         self.containerView.layer.opacity = 1.0f;
                         self.containerView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:NULL];
}


- (void)close
{
    [self closeWithAnimation:YES];
    
}


- (void)closeWithAnimation:(BOOL)animation {
    if (animation) {
        CATransform3D currentTransform = self.containerView.layer.transform;
        self.containerView.layer.opacity = 1.0f;
        
        [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                         animations:^{
                             self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                             self.containerView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
                             self.containerView.layer.opacity = 0.0f;
                         }
                         completion:^(BOOL finished) {
                             for (UIView *v in [self subviews]) {
                                 [v removeFromSuperview];
                             }
                             [self removeFromSuperview];
                         }];
    }else {
        for (UIView *v in [self subviews]) {
            [v removeFromSuperview];
        }
        [self removeFromSuperview];
    }
}


#pragma mark - publishMethod

- (void)updateUserInfo:(MineHomePageModel *)model {
    self.userInfo = model;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.head_image] placeholderImage:[UIImage placeholderImage] options:SDWebImageCacheMemoryOnly];
    self.totalCountLabel.text = [model.balance stringValue];
    [self rewardButtonEnableWithText:self.rewardCountLabel.text];
}

#pragma mark - helpMethod

- (void)inputSwichingSecondContainerShow:(BOOL)show {
    self.midFirstContainer.hidden = show;
    self.midSecondContainer.hidden = !show;
}


- (void)rewardButtonEnableWithText:(NSString *)text {
    self.rewardCount = text.length > 0 ? [text integerValue] : 0;
    BOOL enable = text.length > 0 && [text integerValue] < [self.userInfo.balance integerValue];
    self.rewardButton.enabled = enable;
    enable ? [self.rewardButton setBackgroundColor:[UIColor colorWithIntRed:224 green:82 blue:72 alpha:1]] : [self.rewardButton setBackgroundColor:[UIColor colorWithIntRed:235 green:146 blue:139 alpha:1]];
}


@end
