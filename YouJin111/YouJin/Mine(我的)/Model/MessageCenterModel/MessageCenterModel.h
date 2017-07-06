//
//  MessageCenterModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SystemNoticeModel.h"
#import "AttentionModel.h"
#import "HuifuModel.h"

@interface MessageCenterModel : NSObject


@property (nonatomic, strong) SystemNoticeModel *sys_notice;
@property (nonatomic, strong) AttentionModel *focus;
@property (nonatomic, strong) SystemNoticeModel *offical_notice;
@property (nonatomic, strong) HuifuModel *huifu;



@end
