//
//  PlatformServiceDetailHeadView.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
#import "TTTAttributedLabel.h"
#import "PlatformServiceDetailModel.h"

@protocol PlatformServiceDetailHeadViewDelegate;

@interface PlatformServiceDetailHeadView : UIView

@property (weak, nonatomic) IBOutlet SDCycleScrollView *detailImageCycleView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet StarView *starView;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *evaluateLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerLabel;
@property (weak, nonatomic) IBOutlet UILabel *officiaUrlLabel;
@property (weak, nonatomic) IBOutlet UILabel *proProductLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *productLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UIView *companyTabContainer;
@property (weak, nonatomic) IBOutlet UILabel *companyTabLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *companyInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIButton *loadMoreButton;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productContainerHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loadMoreButtonBottomToSuperBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loadMoreButtonHeight;

@property (nonatomic, retain) PlatformServiceDetailModel *detail;
@property (nonatomic, assign) id<PlatformServiceDetailHeadViewDelegate> delegate;


+ (instancetype)create;

- (void)updatePlatformServiceDetailModel:(PlatformServiceDetailModel *)model;



@end


@protocol PlatformServiceDetailHeadViewDelegate <NSObject>

@optional

- (void)platformServiceDetailHeadView:(PlatformServiceDetailHeadView *)view pasteText:(NSString *)text;
- (void)platformServiceDetailHeadView:(PlatformServiceDetailHeadView *)view pushOfficialUrl:(NSString *)urlString;
- (void)platformServiceDetailHeadView:(PlatformServiceDetailHeadView *)view loadMoreCompanyInfo:(BOOL)isLoadMore;

@end

