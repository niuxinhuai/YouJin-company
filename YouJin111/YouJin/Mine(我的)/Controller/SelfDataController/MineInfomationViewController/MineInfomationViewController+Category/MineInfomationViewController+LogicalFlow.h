//
//  MineInfomationViewController+LogicalFlow.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/8.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MineInfomationViewController.h"

@interface MineInfomationViewController (LogicalFlow)

- (void)requireUserData;
- (void)requireQiNiuTokenSuccessBlock:(dispatch_block_t)successBlock;
- (void)requireForUpdateUserInfoSuccessBlock:(dispatch_block_t)successBlock;

@end
