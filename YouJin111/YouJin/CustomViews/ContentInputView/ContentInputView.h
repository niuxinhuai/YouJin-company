//
//  ContentInputView.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContentInputViewDelegate;

@interface ContentInputView : UIView<UITextViewDelegate>


@property (retain, nonatomic) UITextView *contentTextView;
@property (retain, nonatomic) UILabel *wordCountLabel;
@property (retain, nonatomic) UILabel *placeholderLable;

@property (nonatomic, assign) id<ContentInputViewDelegate> delegate;
@property (nonatomic, assign) NSInteger limitCount;
@property (nonatomic, assign) BOOL showWordCountLabel;


- (void)updatePlaceholderText:(NSString *)placeHolder;
- (void)updateTextLimitCount:(NSInteger)count;
- (void)updateWordCountLabelShow:(BOOL)show;

@end



@protocol ContentInputViewDelegate <NSObject, UITextViewDelegate>

@optional

@end
