//
//  UserPageBar.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    remarkSelected,
    publishSelected,
    commentSelected
}UserPageBarSelectType;

@protocol UserPageBarDelegate;


@interface UserPageBar : UIView

@property (weak, nonatomic) IBOutlet UIButton *remarkButton;
@property (weak, nonatomic) IBOutlet UIButton *publishButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (nonatomic, assign) UserPageBarSelectType selectType;
@property (nonatomic, assign) id<UserPageBarDelegate> delegate;


+ (instancetype)create;

- (void)updateSelectType:(UserPageBarSelectType)type callDelegate:(BOOL)isCall;
- (void)updateButtonTitleJudgeIsMe:(BOOL)isMe;


@end


@protocol UserPageBarDelegate <NSObject>

@optional

- (void)userPageBar:(UserPageBar *)bar changeSelectedType:(UserPageBarSelectType)type;

@end

