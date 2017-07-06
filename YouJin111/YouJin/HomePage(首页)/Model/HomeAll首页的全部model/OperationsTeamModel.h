//
//  OperationsTeamModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OperationsTeamModel : NSObject

/**
 运营团队
 */
@property (nonatomic ,copy)NSString *name;//姓名
@property (nonatomic ,copy)NSString *job;//职位
@property (nonatomic ,copy)NSString *desc;//描述
@property (nonatomic, assign)BOOL is_opend;
@property (nonatomic ,copy)NSString *logo;//图片
/**
 最新活动
 */
@property (nonatomic ,copy)NSString *title;//活动标题
@property (nonatomic ,copy)NSString *img_url;//图片地址
@property (nonatomic ,copy)NSString *href_url;//跳转地址
@end
