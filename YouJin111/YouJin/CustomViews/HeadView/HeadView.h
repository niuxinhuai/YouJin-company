//
//  HeadView.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    kNormal = 1,
    kPersonVip,
    kCompanyVip,
}HeadStatus;

@interface HeadView : UIView

@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UIImageView *personStatusView;
@property (nonatomic, retain) UIImageView *companyStatusView;
@property (nonatomic, retain) UIView *backgroundView;

@property (nonatomic, assign) BOOL showBackgroundView;
@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, assign) HeadStatus status;
@property (nonatomic, assign) CGFloat companyStatusViewHeight;
@property (nonatomic, assign) CGFloat personStatusViewHeight;

- (void)updateImageUrlString:(NSString *)url;
- (void)updateHeadStatus:(HeadStatus)type;
- (void)updateCompanyStatusViewHeight:(CGFloat)height personHeight:(CGFloat)personHeight;

@end
