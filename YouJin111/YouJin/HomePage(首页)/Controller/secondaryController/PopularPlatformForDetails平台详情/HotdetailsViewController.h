//
//  HotdetailsViewController.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotdetailsViewController : UIViewController
@property (nonatomic, copy) NSString *ptid;//接受上一页的平台编号
@property (nonatomic ,copy) NSString *nameOfPlatform;//接受上一页的平台名称

@property (nonatomic ,copy) NSString *xffqString;//判断是不是在消费分期页面进来的
@property (nonatomic ,copy) NSString *xffqlxStr;
@end
