//
//  GuanzhuBangModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/6/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuanzhuBangModel : NSObject
@property (nonatomic ,copy)NSString *ID;
@property (nonatomic ,copy)NSString *ptid;//平台编号
@property (nonatomic ,copy)NSString *logo;//Logo
@property (nonatomic ,copy)NSString *name;//平台名称
@property (nonatomic ,strong)NSNumber *fans;//关注人数
@property (nonatomic ,copy)NSString *is_focus;//1/已关注 0/未关注
@end
