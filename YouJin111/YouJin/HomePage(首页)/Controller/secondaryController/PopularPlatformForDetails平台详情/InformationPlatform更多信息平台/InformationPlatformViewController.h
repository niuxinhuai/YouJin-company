//
//  InformationPlatformViewController.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationPlatformViewController : UIViewController
@property (nonatomic,copy)NSString *ptid;//接受上一页的平台编号
@property (nonatomic,copy)NSString *titleViewString;//接受上一页的平台名称
@property (nonatomic ,assign)BOOL onAndoff;//全文和收回
@property (nonatomic ,assign)CGFloat heights;//平台简介详情文字高度
@end
