//
//  SubsribeViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MessageBaseController.h"

@interface SubsribeViewController : MessageBaseController

@property (nonatomic, assign) BOOL isMySubscribe;


+ (instancetype)createWithMySubscribe:(BOOL)isMySubscribe;



@end
