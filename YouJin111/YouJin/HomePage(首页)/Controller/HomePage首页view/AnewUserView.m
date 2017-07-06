//
//  AnewUserView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "AnewUserView.h"

@implementation AnewUserView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.7];
        
        //大红色的滑动 背景图片
        _slidingBgimage = [[UIImageView alloc]initWithFrame:CGRectMake(125*BOScreenW/750, 298*BOScreenH/1334, 500*BOScreenW/750, 640*BOScreenH/1334)];
        _slidingBgimage.image = [UIImage imageNamed:@"img_hongbaofirst"];
        _slidingBgimage.userInteractionEnabled = YES;
        [self addSubview:_slidingBgimage];
        
        //叉号button
        _crossbutt = [UIButton buttonWithType:UIButtonTypeCustom];
        _crossbutt.frame = CGRectMake(0, 0, 65*BOScreenW/750, 65*BOScreenW/750);
        [_slidingBgimage addSubview:_crossbutt];
        
        //请输入你的手机号
        _plNumberText = [[UITextField alloc]initWithFrame:CGRectMake(140*BOScreenW/750, 455*BOScreenH/1334, 270*BOScreenW/750, 30*BOScreenH/1334)];
        _plNumberText.placeholder = @"请输入你的手机号";
        _plNumberText.keyboardType = UIKeyboardTypeNumberPad;
        _plNumberText.font = [UIFont systemFontOfSize:14];
        _plNumberText.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [_slidingBgimage addSubview:_plNumberText];
        
        //滑块
        _slider = [[UISlider alloc]initWithFrame:CGRectMake(54*BOScreenW/750, 536*BOScreenH/1334, 392*BOScreenW/750, 78*BOScreenH/1334)];
        _slider.minimumValue = 0;//滑动条的最小值
        _slider.maximumValue = 392*BOScreenW/750;//滑动条的最大值
        _slider.value = 0;//滑动条的当前值
        [_slider setThumbImage:[UIImage imageNamed:@"icon_jinbi"] forState:UIControlStateHighlighted];//设置滑动状态的时候滑块显示的图片
        [_slider setThumbImage:[UIImage imageNamed:@"icon_jinbi"] forState:UIControlStateNormal];//设置正常状态的时候滑块显示的图片
        [_slider setMinimumTrackTintColor:[UIColor clearColor]];//滑块左边的轨道颜色
        
        [_slider setMaximumTrackTintColor:[UIColor clearColor]];//滑块右边的轨道颜色
        _slider.continuous = NO;//设置只有在离开滑动条的最后时刻才触发滑动事件
        [_slidingBgimage addSubview:_slider];
        
        //领取的背景图片
        _receiveImage = [[UIImageView alloc]initWithFrame:CGRectMake(125*BOScreenW/750, 298*BOScreenH/1334, 500*BOScreenW/750, 640*BOScreenH/1334)];
        _receiveImage.image = [UIImage imageNamed:@"img_hongbaosecond"];
        _receiveImage.userInteractionEnabled = YES;
        [self addSubview:_receiveImage];
        
        //叉号button
        _crossbutto = [UIButton buttonWithType:UIButtonTypeCustom];
        _crossbutto.frame = CGRectMake(0, 0, 65*BOScreenW/750, 65*BOScreenW/750);
        [_receiveImage addSubview:_crossbutto];

        //电话号码
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(140*BOScreenW/750, 120*BOScreenH/1334, 270*BOScreenW/750, 30*BOScreenH/1334)];
//        _phoneLabel.text = @"13787659878";
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        _phoneLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [_receiveImage addSubview:_phoneLabel];
        
        //输入验证码
        _verificationText = [[UITextField alloc]initWithFrame:CGRectMake(100*BOScreenW/750, 220*BOScreenH/1334, 160*BOScreenW/750, 30*BOScreenH/1334)];
        _verificationText.placeholder = @"输入验证码";
        _verificationText.keyboardType = UIKeyboardTypeNumberPad;
        _verificationText.font = [UIFont systemFontOfSize:13];
        _verificationText.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [_receiveImage addSubview:_verificationText];

        //定时器
        _countdownbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _countdownbtn.frame = CGRectMake(303*BOScreenW/750, 220*BOScreenH/1334, 150*BOScreenW/750, 30*BOScreenH/1334);
        [_countdownbtn setTitle:@"59s 后发送" forState:UIControlStateNormal];
        _countdownbtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_countdownbtn setTitleColor:[UIColor colorWithHexString:@"#eead38" alpha:1] forState:UIControlStateNormal];
        [_receiveImage addSubview:_countdownbtn];
        
        //领取的按钮
        _toreceiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _toreceiveButton.frame = CGRectMake(150*BOScreenW/750, 330*BOScreenH/1334, 200*BOScreenW/750, 200*BOScreenW/750);
        [_receiveImage addSubview:_toreceiveButton];
    }
    return self;
}
@end
