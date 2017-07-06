//
//  CommentInsideViewController.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CommentInsideViewController : BaseViewController
@property (nonatomic ,copy)NSString *pidString;//接受上一页的pid
@property (nonatomic ,copy)NSString *outtypeString;//接受上一页的outtype
@property (nonatomic ,copy)NSString *outidString;//接受上一页的outid
@property (nonatomic ,copy)NSString *zidString;
@property (nonatomic ,copy)NSString *uidString;
@property (nonatomic ,copy)NSString *fidString;
@property (nonatomic ,copy)NSString *nameString;

@property (nonatomic ,copy)NSString *playKeyboard;//判断弹不弹键盘
@end
