//
//  UserCommentsOnViewController.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/19.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCommentsOnViewController : UIViewController
@property (nonatomic,copy)NSString *ptidString;//接受上一页的ptid
@property (nonatomic ,copy)NSString *numberString;//接受上一页的用户点评总数
@property (nonatomic ,copy)NSString *yhdpString;//接受上一页的用户点评（--）
@property (nonatomic ,copy)NSString *namestring;//解释上一页的平台名称
@end
