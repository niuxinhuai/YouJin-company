//
//  ShengModel.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShengModel : NSObject

/**省编号*/
@property (nonatomic, copy) NSString *id;
/**名称*/
@property (nonatomic, copy) NSString *name;
/**父级编号，靠这个来确定关系*/
@property (nonatomic, copy) NSString *pid;
/**下级市区*/
@property (nonatomic, strong) NSArray *child;

@end
