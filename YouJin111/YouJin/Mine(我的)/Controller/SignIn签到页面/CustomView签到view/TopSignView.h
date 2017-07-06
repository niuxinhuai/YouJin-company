//
//  TopSignView.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SignInPageModel;
@interface TopSignView : UIView
@property (nonatomic ,strong)UIButton *sigInButton;//签到的buuton
@property (nonatomic ,strong)UIButton *fouButton;//阅读签到下面的四个button
@property (nonatomic ,strong)UIImageView *headImage;//头像
@property (nonatomic ,strong)UILabel *numberLabel;//1,000,000
@property (nonatomic ,strong)UILabel  *signInToLabel;//明日签到即可得 300
@property (nonatomic ,strong)UIButton *shoutButton;//喊好友签到的按钮
@property (nonatomic ,strong)SignInPageModel *item;
@end
