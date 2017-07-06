//
//  ToApplyForView.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTTAttributedLabel;

typedef enum{
    GoldAccountApplyByMedia = 1,
    GoldAccountApplyByCompany
}GoldAccountApplyType;


@protocol GoldAcountApplyViewDelegate;

@interface ToApplyForView : UIView
@property (nonatomic ,strong)UIVisualEffectView *effectView;//毛玻璃效果
@property (nonatomic ,strong)UIView *homeView;//中间的大白view
@property (nonatomic ,strong)UIImageView *penImage;//中间的大图片
@property (nonatomic ,strong)TTTAttributedLabel *suitableLabel;//大图片下面的文字
@property (nonatomic ,strong)UIButton *sinceMediaButton;//上面申请的按钮
@property (nonatomic ,strong)UIButton *enterpriseGoButton;//下面的申请按钮



@property (nonatomic, assign) GoldAccountApplyType type;
@property (nonatomic, assign) id<GoldAcountApplyViewDelegate>delegate;


- (void)updateApplyType:(GoldAccountApplyType)type;


@end


@protocol GoldAcountApplyViewDelegate <NSObject>

@optional
- (void)goldAcountApplyView:(ToApplyForView *)view switchingApplyType:(GoldAccountApplyType)type;
- (void)goldAcountApplyView:(ToApplyForView *)view applyActionWithApplyType:(GoldAccountApplyType)type;
- (void)goldAcountApplyViewDidClicked:(ToApplyForView *)view;


@end

