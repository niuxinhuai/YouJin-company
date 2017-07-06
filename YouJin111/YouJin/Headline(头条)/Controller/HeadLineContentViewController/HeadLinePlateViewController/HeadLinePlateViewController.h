//
//  HeadLinePlateViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineBaseViewController.h"

@interface HeadLinePlateViewController : HeadLineBaseViewController


@property (nonatomic, retain) NSNumber *plateID;


+ (instancetype)headLinePlateViewControllerWithPlateID:(NSNumber *)plateId;

@end
