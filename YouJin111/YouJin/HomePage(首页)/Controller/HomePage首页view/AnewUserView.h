//
//  AnewUserView.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnewUserView : UIView
@property (nonatomic ,strong)UIImageView *slidingBgimage;//大红色的滑动背景图片
@property (nonatomic ,strong)UIImageView *receiveImage;//领取的背景图片
@property (nonatomic ,strong)UISlider *slider;//滑块
@property (nonatomic ,strong)UIButton *countdownbtn;//定时器的button
@property (nonatomic ,strong)UIButton *crossbutt;//叉号button
@property (nonatomic ,strong)UIButton *crossbutto;//叉号button
@property (nonatomic ,strong)UITextField *plNumberText;//请输入你的手机号

//领取
@property (nonatomic ,strong)UILabel *phoneLabel;//电话号码
@property (nonatomic ,strong)UITextField *verificationText;//输入验证码
@property (nonatomic ,strong)UIButton *toreceiveButton;//领取按钮

@end
