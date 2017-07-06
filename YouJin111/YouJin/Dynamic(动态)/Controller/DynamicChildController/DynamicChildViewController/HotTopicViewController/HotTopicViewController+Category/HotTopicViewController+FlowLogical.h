//
//  HotTopicViewController+FlowLogical.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HotTopicViewController.h"

@interface HotTopicViewController (FlowLogical)

- (void)requireBanner;
- (void)requireForHotListWithStartCount:(NSNumber *)startCount;

@end
