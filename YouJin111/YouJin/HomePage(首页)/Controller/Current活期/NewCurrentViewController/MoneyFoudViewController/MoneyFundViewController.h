//
//  MoneyFundViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseSwipeSubViewController.h"
#import "ConditionSelectedBar.h"

@class CurrentSectionHeaderView;

@interface MoneyFundViewController : BaseSwipeSubViewController<ConditionSelectedBarDelegate>

@property (nonatomic, retain) ConditionSelectedBar *sectionBar;
@property (nonatomic, retain) NSMutableArray *sectionTitles;
@property (nonatomic, strong) NSString *key;


@property (nonatomic, retain) NSMutableArray *dataArray;



@end
