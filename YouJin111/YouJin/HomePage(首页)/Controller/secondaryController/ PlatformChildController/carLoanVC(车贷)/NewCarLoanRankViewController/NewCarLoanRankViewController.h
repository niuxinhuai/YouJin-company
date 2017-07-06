//
//  NewCarLoanRankViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseSwipeSubViewController.h"
#import "ConditionSelectedBar.h"
#import "ConditionSelectedBar.h"

@interface NewCarLoanRankViewController : BaseSwipeSubViewController<ConditionSelectedBarDelegate>

@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) ConditionSelectedBar *sectionBar;
@property (nonatomic, retain) NSMutableArray *sectionTitles;
@property (nonatomic, strong) NSString *key;

@end
