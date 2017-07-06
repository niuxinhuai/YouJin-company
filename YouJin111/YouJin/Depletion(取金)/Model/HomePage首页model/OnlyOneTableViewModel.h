//
//  OnlyOneTableViewModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/25.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OnlyOneTableViewModel : NSObject
@property (nonatomic ,strong)NSString *eaid;//取金编号
@property (nonatomic ,strong)NSString *logo;//logo
@property (nonatomic ,strong)NSString *name;//平台名称
@property (nonatomic ,strong)NSString *title;//标题
@property (nonatomic ,strong)NSString *show_money;//奖励U币
@property (nonatomic ,strong)NSString *url;//链接地址
@property (nonatomic ,strong)NSString *is_baozhang;//是否U盾计划 0/不是 1/是
@property (nonatomic ,strong)NSString *status;//0/未提交任务 1/已提交待审核 2/审核成功 3/审核失败（登陆状态下会有）
@end
