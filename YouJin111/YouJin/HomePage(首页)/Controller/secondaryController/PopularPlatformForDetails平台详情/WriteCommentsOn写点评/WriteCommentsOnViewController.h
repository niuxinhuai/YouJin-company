//
//  WriteCommentsOnViewController.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^CallBackBlcok) (NSString *text);

@interface WriteCommentsOnViewController : BaseViewController
@property (nonatomic ,copy)NSString *nameString;//接受上一页的平台名称
@property (nonatomic ,copy)NSString *ptidStr;//接受上一页的ptid
@property (nonatomic ,strong)NSNumber *type;//接受上一页的类型编号

@property (nonatomic ,copy)CallBackBlcok callBackBlock;
@end
