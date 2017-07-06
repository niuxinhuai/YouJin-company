//
//  MessageInputView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/19.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MessageInputView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface MessageInputView ()

@property (nonatomic, assign) CGFloat viewHeightOld;

@end

@implementation MessageInputView

+ (instancetype) create {
    MessageInputView *view = [[NSBundle mainBundle]loadNibNamed:@"MessageInputView" owner:nil options:nil].firstObject;
    return view;
}

- (void)dealloc {
    [self removeKeyBoardNotification];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.isRespondToKeyBoardChange = YES;
    [self registerForKeyboardNotifications];
    [self configureViews];
    [self updateBottomViewHeight];
    self.userInteractionEnabled = YES;
}

- (void)configureViews {
    [self.replyButton makeCornerWithCornerRadius:5];
    [self.inputTextView makeCornerBorderWithWidth:1 cornerRadius:5 borderColor:[UIColor lightGrayColor]];
    [self configureInputView];
}

- (void)configureInputView {
    self.inputTextView.font = [UIFont systemFontOfSize:14];
    self.inputTextView.textColor = [UIColor textColor];
    self.inputTextView.returnKeyType = UIReturnKeySend;
    self.inputTextView.scrollsToTop = NO;
    self.inputTextView.delegate = self;
    UIEdgeInsets insets = self.inputTextView.textContainerInset;
    insets.left += 8.0;
    insets.right += 8.0;
    self.inputTextView.textContainerInset = insets;
    __weak typeof(self) weakSelf = self;
    [[RACObserve(self.inputTextView, contentSize) takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSValue *contentSize) {
        [weakSelf updateBottomViewHeight];
    }];
}



- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyBoardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - reset 

- (void)setInitialBottomViewBottomConstant:(CGFloat)initialBottomViewBottomConstant {
    _initialBottomViewBottomConstant = initialBottomViewBottomConstant;
    self.bottomViewBottomToSuperBottom.constant = initialBottomViewBottomConstant;
    [self layoutIfNeeded];
}

#pragma mark - actionMethod

- (IBAction)dismissAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(messageInputView: cancelEditWithText:)]) {
        [self.delegate messageInputView:self cancelEditWithText:self.inputTextView.text];
    }
    [self.inputTextView resignFirstResponder];
}

- (IBAction)sendAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(messageInputView: sendText:)]) {
        [self.delegate messageInputView:self sendText:self.inputTextView.text];
    }
    [self.inputTextView resignFirstResponder];
}



#pragma mark - keyBoardNotification

- (void)keyboardWillShown:(NSNotification *)sender {
    if (!self.isRespondToKeyBoardChange) return;
    [self bottomBarAnimationWithNotification:sender show:YES];
}

- (void)keyboardWillHidden:(NSNotification *)sender {
    if (!self.isRespondToKeyBoardChange) return;
    [self bottomBarAnimationWithNotification:sender show:NO];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        [self updateBottomViewHeight];
    }
}

#pragma mark - <UITextViewDelegate>

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.placehorldLabel.hidden = textView.text.length > 0;
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.placehorldLabel.hidden = textView.text.length > 0;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.placehorldLabel.hidden = textView.text.length > 0;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self sendAction:nil];
        return NO;
    }
    return YES;
}



#pragma mark - publicMethod

- (void)show {
    [self.inputTextView becomeFirstResponder];
}

- (void)dismiss {
    [self dismissAction:nil];
}
- (void)updatePlaceholder:(NSString *)placeholder {
    self.placeholder = placeholder;
    self.placehorldLabel.text = placeholder;
}

#pragma mark - helpMethod

- (void)bottomBarAnimationWithNotification:(NSNotification *)sender show:(BOOL)show {
    self.hidden = NO;
    NSDictionary* info = [sender userInfo];
    CGSize keyBoardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSTimeInterval duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    CGFloat boottonConstant = show ? keyBoardSize.height : self.initialBottomViewBottomConstant;
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        self.bottomViewBottomToSuperBottom.constant = boottonConstant;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.hidden = !show;
    }];
}

- (void)updateBottomViewHeight {
    CGSize  textSize  = self.inputTextView.contentSize;
    CGSize  mediaSize = CGSizeZero;
    CGSize contentSize = CGSizeMake(textSize.width, textSize.height + mediaSize.height);
    CGFloat inputViewHeight = MAX(kMinInputView_Height, contentSize.height);
    
    CGFloat maxSelfHeight = [UIScreen screenHeight]/2;
    
    CGFloat selfHeight = MIN(maxSelfHeight, inputViewHeight + kBaseMessageInputView_Height);
    CGFloat diffHeight = selfHeight - _viewHeightOld;
    if (ABS(diffHeight) > 0.5) {
        self.bottomViewHeight.constant = selfHeight;
        self.viewHeightOld = selfHeight;
        [self layoutIfNeeded];
    }
    
}



@end
