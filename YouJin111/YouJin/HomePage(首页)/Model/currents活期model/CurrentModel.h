//
//  CurrentModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/11.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentModel : NSObject
//互金活期
@property (nonatomic ,copy)NSString *logo;//logo
@property (nonatomic ,copy)NSString *today_apr;//今日年化
@property (nonatomic ,copy)NSString *wf_lixi;//万份收益
@property (nonatomic ,copy)NSString *tixian;//提现
@property (nonatomic ,copy)NSString *speed;//提现速度

@end
