//
//  CurrentHeadBar.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CurrentHeadBar.h"

@implementation CurrentHeadBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViews];
    }
    return self;
}


#pragma mark - configuration


- (void)configureViews {
    [self addTopBarView];
    [self addBottomContainer];
    //[self addLeftSectionView];
   // [self addRightSectionView];
    [self bringSubviewToFront:self.topBarView];
}

- (void)addTopBarView {
    self.topBarView = ({
        HomeLineHeadBarView *view = [[HomeLineHeadBarView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen screenWidth], 45)];
        [view updateLineViewWidth:90*BOScreenW/750];
        [view updateTitles:@[@"互金活期", @"货币基金"]];
        [self addSubview:view];
        view;
    });
//    [self.topBarView makeShadowWithShadowColor:[UIColor grayColor] shadowOffset:CGSizeMake(0, .5) shadowRadius:.5 shadowOpacity:.5 shadowPath:[UIBezierPath bezierPathWithRect:self.topBarView.bounds].CGPath];
}


- (void)addBottomContainer {
    self.bottomContainer = ({
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 45, [UIScreen screenWidth], 40)];
        scrollView.contentSize = CGSizeMake(2 * [UIScreen screenWidth], 40);
        scrollView.scrollEnabled = NO;
        [self addSubview:scrollView];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView;
    });
}

- (void)addLeftSectionView {
    self.leftSectionView = ({
        CurrentSectionHeaderView *view = [CurrentSectionHeaderView create];
        [view updateSectionHeaderType:kEachGoldCurrent];
        view.frame = CGRectMake(0, 0, [UIScreen screenWidth], 40);
        [self.bottomContainer addSubview:view];
        view;
    });
}

- (void)addRightSectionView {
    self.rightSectionView = ({
        CurrentSectionHeaderView *view = [CurrentSectionHeaderView create];
        [view updateSectionHeaderType:kMoneyFund];
        view.frame = CGRectMake([UIScreen screenWidth], 0, [UIScreen screenWidth], 40);
        [self.bottomContainer addSubview:view];
        view;
    });
}

@end
