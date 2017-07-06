//
//  ContentInputView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "ContentInputView.h"
#import "NSString+Utilities.h"
#import "UITextView+Utilities.h"

@implementation ContentInputView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViews];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureViews];
}


#pragma mark - configuration

- (void)configureViews {
    [self addWordCountLabel];
    [self addContentTextView];
    [self addPlaceHolderLabel];
}


- (void)addPlaceHolderLabel
{
    self.placeholderLable = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        label.textColor= [UIColor colorWithIntRed:0 green:0 blue:0 alpha:0.26];
        label.font = [UIFont systemFontOfSize:15];
        [self addSubview:label];
        label;
    });
    
    [self.placeholderLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(7);
        make.left.equalTo(self).offset(12);
        make.height.mas_equalTo(18);
        make.centerX.equalTo(self);
    }];
}

- (void)addContentTextView
{
    self.contentTextView = ({
        UITextView *textView = [[UITextView alloc]init];
        textView.backgroundColor = [UIColor whiteColor];
        textView.delegate = self;
        textView.font = [UIFont systemFontOfSize:14];
        UIEdgeInsets insets = textView.textContainerInset;
        insets.left += 8.0;
        insets.right += 8.0;
        textView.textContainerInset = insets;
        [self addSubview:textView];
        textView;
    });
    
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.bottom.equalTo(self.wordCountLabel.mas_top).offset(0);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
    }];
}

- (void)addWordCountLabel
{
    self.wordCountLabel = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor textColor];
        label.font = [UIFont systemFontOfSize:13];
        label.hidden = YES;
        [self addSubview:label];
        label;
    });
    
    [self.wordCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-5);
        make.right.equalTo(self).offset(-10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
}

#pragma mark - <UITextViewDelegate>

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.placeholderLable.hidden = textView.text.length > 0;
    [self updateWordCountWithTextView:textView];
    if ([self.delegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        [self.delegate textViewShouldBeginEditing:textView];
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.placeholderLable.hidden = textView.text.length > 0;
    [self updateWordCountWithTextView:textView];
    if ([self.delegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.delegate textViewDidEndEditing:textView];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    self.placeholderLable.hidden = textView.text.length > 0;
    [self updateWordCountWithTextView:textView];
    if ([self.delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.delegate textViewDidChange:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        if ([self.delegate respondsToSelector:@selector(textView: shouldChangeTextInRange:replacementText:)]) {
            [self.delegate textView:textView shouldChangeTextInRange:range replacementText:text];
        }
        return NO;
    }
    if ([self.delegate respondsToSelector:@selector(textView: shouldChangeTextInRange:replacementText:)]) {
        [self.delegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}


#pragma mark - publicMethod

- (void)updatePlaceholderText:(NSString *)placeHolder {
    self.placeholderLable.text = placeHolder;
}

- (void)updateTextLimitCount:(NSInteger)count {
    self.limitCount = count;
}

- (void)updateWordCountLabelShow:(BOOL)show {
    self.showWordCountLabel = show;
    if (!show) {
        [self.wordCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.height.mas_equalTo(0);
            make.width.mas_equalTo(0);
        }];
    }else {
        [self.wordCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-5);
            make.right.equalTo(self).offset(-10);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(100);
        }];
    }
    [self layoutIfNeeded];
}

#pragma mark - helpMethod

- (void)updateWordCountWithTextView:(UITextView *)textView {
    NSInteger textCount = [textView caculateTextViewTextCount];
    self.wordCountLabel.text = [NSString stringWithFormat:@"%@/%@",@(textCount), @(self.limitCount)];
}

@end
