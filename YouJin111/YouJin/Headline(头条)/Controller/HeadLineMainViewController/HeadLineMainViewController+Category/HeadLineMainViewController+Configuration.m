//
//  HeadLineMainViewController+Configuration.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineMainViewController+Configuration.h"
#import "HeadLineMainViewController+Delegate.h"

@implementation HeadLineMainViewController (Configuration)


- (void)configureViews {
    [self addHeadBannerView];
    [self addHeaderBar];
    [self configrueSearchBar];
    [self.view bringSubviewToFront:self.topView];
    self.topBackgroundView.alpha = 0;
    self.layout.itemSize = CGSizeMake([UIScreen screenWidth], [UIScreen screenHeight] - 49);
}

- (void)configureLayoutConstraint {
    self.searchBarWidth.constant = 250 * BOScreenW / BOPictureW;
}


- (void)addHeadBannerView {
    self.headerView = ({
        SDCycleScrollView *headerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen screenWidth], 192 * BOScreenH / BOPictureH)  delegate:self placeholderImage:[UIImage imageNamed:@"img_loadingc"]];
        headerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        headerView.autoScrollTimeInterval = 4;
        [self.view addSubview:headerView];
        headerView;
    });
}

- (void)addHeaderBar {
    self.headBarView = ({
        HomeLineHeadBarView *view = [[HomeLineHeadBarView alloc]initWithFrame:CGRectMake(0, 192 * BOScreenH / BOPictureH, [UIScreen screenWidth], 45)];
        [view updateTitles:self.barTitles];
        view.delegate = self;
        [self.view addSubview:view];
        view;
    });
    [self.headBarView makeShadowWithShadowColor:[UIColor grayColor] shadowOffset:CGSizeMake(0, .5) shadowRadius:.5 shadowOpacity:.5 shadowPath:[UIBezierPath bezierPathWithRect:self.headBarView.bounds].CGPath];
}

- (void)configrueSearchBar {
    [self.searchBar makeCornerWithCornerRadius:self.searchBar.height / 2.0];
    self.searchBar.clipsToBounds = YES;
    self.searchBar.delegate = self;
    UIImage *backImage = [UIImage imageWithAlpha:0.05];
    self.searchBar.backgroundImage = backImage;
}


#pragma mark - helpMethod

- (SDCycleScrollView *)getHeadView {
    return (SDCycleScrollView *)self.headerView;
}

- (HomeLineHeadBarView *)getHeadBarView {
    return (HomeLineHeadBarView *)self.headBarView;
}




@end
