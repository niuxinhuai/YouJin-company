//
//  BOSettingArrowItem.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BORowItem.h"

@interface BOSettingArrowItem : BORowItem
//要跳转的控制器名称
@property (assign, nonatomic) Class desVCName;
//点击时要执行的任务(代码)
@property (copy, nonatomic) void(^desTask)(NSIndexPath *indexPath);
@end
