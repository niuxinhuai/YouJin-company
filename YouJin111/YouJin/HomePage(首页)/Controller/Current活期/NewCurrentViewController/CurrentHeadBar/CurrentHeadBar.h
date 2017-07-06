//
//  CurrentHeadBar.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeLineHeadBarView.h"
#import "CurrentSectionHeaderView.h"

@interface CurrentHeadBar : UIView

@property (nonatomic, retain) HomeLineHeadBarView *topBarView;
@property (nonatomic, retain) UIScrollView *bottomContainer;
@property (nonatomic, retain) CurrentSectionHeaderView *leftSectionView;
@property (nonatomic, retain) CurrentSectionHeaderView *rightSectionView;

@end
