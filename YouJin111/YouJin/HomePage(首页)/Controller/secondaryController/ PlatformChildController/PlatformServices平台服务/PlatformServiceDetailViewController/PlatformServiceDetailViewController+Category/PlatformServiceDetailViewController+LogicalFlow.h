//
//  PlatformServiceDetailViewController+LogicalFlow.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformServiceDetailViewController.h"

@interface PlatformServiceDetailViewController (LogicalFlow)

- (void)requireForPlatSeviceDetailWithSvid:(NSNumber *)svid;
- (void)requireForPlatSeviceDetailCommentList;
- (void)requestForStarCommentWithOutId:(NSInteger)outId;

@end
