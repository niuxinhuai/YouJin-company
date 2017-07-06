//
//  GoldMainViewController+LogicalFlow.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "GoldMainViewController.h"

@interface GoldMainViewController (LogicalFlow)

- (void)requireCanApplyGoldStatus;
- (void)requireGoldAccountFoucsListWithStartCount:(NSInteger)start limitCount:(NSInteger)limitCount;


@end
