//
//  AboutYoujinViewController.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutYoujinViewController : UIViewController
@property (nonatomic ,copy)NSString *titleviewstr;//接受上一页的titleview
@property (nonatomic ,strong)NSMutableArray *numberArr;//接受上一个的数据的数组
@property (nonatomic ,strong)NSMutableArray *detailArr;//接受上一页详情的数组
@end
