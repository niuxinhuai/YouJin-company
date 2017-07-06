//
//  MessageInputView.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/19.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kKeyboardView_Height 216.0
#define kMinInputView_Height 40.0
#define kBaseMessageInputView_Height 60.0

@protocol MessageInputViewDelegate;

@interface MessageInputView : UIView<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottomToSuperBottom;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UILabel *placehorldLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;


@property (nonatomic, assign) BOOL showBackGroundView;
@property (nonatomic, assign) CGFloat initialBottomViewBottomConstant;
@property (nonatomic, assign) id<MessageInputViewDelegate> delegate;
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, assign) BOOL isRespondToKeyBoardChange;

+ (instancetype) create;


- (void)show;
- (void)dismiss;
- (void)updatePlaceholder:(NSString *)placeholder;

@end

@protocol MessageInputViewDelegate <NSObject>

@optional
- (void)messageInputView:(MessageInputView *)inputView sendText:(NSString *)text;
- (void)messageInputView:(MessageInputView *)inputView cancelEditWithText:(NSString *)text;

@end

