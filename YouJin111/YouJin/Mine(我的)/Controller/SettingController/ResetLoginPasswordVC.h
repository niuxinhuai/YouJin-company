//
//  ResetLoginPasswordVC.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseViewController.h"

@interface ResetLoginPasswordVC : BaseViewController

/**
 判断从哪儿跳过来
 */
@property (nonatomic ,assign)int flag;
@property (nonatomic, copy) NSString *titleString;
@end
