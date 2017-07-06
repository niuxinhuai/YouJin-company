//
//  HomePageView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/29.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HomePageView.h"

@implementation HomePageView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //    //银行 股票 基金的image数组
        //    NSArray *bankimageArray = [NSArray arrayWithObjects:@"home_icon_yinhang",@"home_icon_gupiao",@"home_icon_jijin",@"home_icon_baoxian",@"home_icon_huoqi",@"home_icon_wangdai",@"home_icon_jieqian",@"home_icon_xuexi",@"home_icon_shenghuo",@"home_icon_bangzhu", nil];
        //    //银行 股票 基金的label数组
        //    NSArray *bankArray = [NSArray arrayWithObjects:@"银行",@"股票",@"基金",@"保险",@"活期",@"网贷",@"借钱",@"学习",@"生活",@"帮助", nil];
        //银行 股票。。。帮助的view
        //    bankView = [[UIView alloc]initWithFrame:CGRectMake(0, 384*BOScreenH/1334, BOScreenW, 356*BOScreenH/1334)];
        //    bankView.backgroundColor = [UIColor whiteColor];
        //    [self.homeScrollView addSubview:bankView];
        //    //创建十个个button和十个个label
        //    for(int i=0; i<2; i++)
        //    {
        //        for(int j=0; j<5; j++)
        //        {
        //            UIButton *bankButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //            double b = (78*BOScreenW/750)*j;
        //            double c = (BOScreenW-(40*BOScreenW/750)*2-(78*BOScreenW/750)*5)/4*j;
        //            bankButton.frame = CGRectMake(40*BOScreenW/750+b+c, 44*BOScreenH/1334+(78*BOScreenW/750+75*BOScreenH/1334)*i, 78*BOScreenW/750, 78*BOScreenW/750);
        //            bankButton.tag = 5*i+j;
        //            [bankButton addTarget:self action:@selector(bankButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //            [bankView addSubview:bankButton];
        //
        //            UILabel *bankLabel  = [[UILabel alloc]init];
        //            bankLabel.frame = CGRectMake(40*BOScreenW/750+b+c, 44*BOScreenH/1334+78*BOScreenW/750+16*BOScreenH/1334+(153*BOScreenH/1334)*i, 78*BOScreenW/750, 13);
        //            bankLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        //            bankLabel.font = [UIFont systemFontOfSize:13];
        //            bankLabel.textAlignment = NSTextAlignmentCenter;
        //            [bankView addSubview:bankLabel];
        //
        //            if (i==0)
        //            {
        //                [bankButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",bankimageArray[j]]] forState:UIControlStateNormal];
        //                bankLabel.text = [NSString stringWithFormat:@"%@",bankArray[j]];
        //            }else{
        //                [bankButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",bankimageArray[j+5]]] forState:UIControlStateNormal];
        //                bankLabel.text = [NSString stringWithFormat:@"%@",bankArray[j+5]];
        //            }
        //        }
        //    }
        
        //银行 股票。。。帮助的view
        UIView *bankView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 205*BOScreenH/1334)];
        bankView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bankView];
        
        //银行 股票 基金的image数组
        NSArray *bankimageArray = [NSArray arrayWithObjects:@"home_icon_wangdai",@"home_icon_jieqian",@"home_icon_xuexi",@"home_icon_huoqi",@"home_icon_bangzhu", nil];
        //银行 股票 基金的label数组
        NSArray *bankArray = [NSArray arrayWithObjects:@"网贷",@"借钱",@"学习",@"活期",@"帮助", nil];
        //创建五个button和五个label
        for (int i = 0; i < 5; i ++)
        {
            _bankButton = [UIButton buttonWithType:UIButtonTypeCustom];
            double c = (BOScreenW-(40*BOScreenW/750)*2-(78*BOScreenW/750)*5)/4;
            _bankButton.frame = CGRectMake(40*BOScreenW/750+i*(78*BOScreenW/750 + c), 44*BOScreenH/1334, 78*BOScreenW/750, 78*BOScreenW/750);
            _bankButton.tag = 10000+i;
            [_bankButton setBackgroundImage:[UIImage imageNamed:bankimageArray[i]] forState:UIControlStateNormal];
            [_bankButton addTarget:self action:@selector(bankButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [bankView addSubview:_bankButton];
            
            UILabel *bankLabel  = [[UILabel alloc]init];
            bankLabel.frame = CGRectMake(40*BOScreenW/750+i*(78*BOScreenW/750+c), 44*BOScreenH/1334+78*BOScreenW/750+16*BOScreenH/1334, 78*BOScreenW/750, 13);
            bankLabel.text = bankArray[i];
            bankLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            bankLabel.font = [UIFont systemFontOfSize:13];
            bankLabel.textAlignment = NSTextAlignmentCenter;
            [bankView addSubview:bankLabel];
        }
        
        //有金头条的view
        CGFloat bankViewYy = CGRectGetMaxY(bankView.frame) + 1;
        _goldView = [[UIView alloc]initWithFrame:CGRectMake(0, bankViewYy, BOScreenW, 80*BOScreenH/1334)];
        _goldView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_goldView];
        //创建有金头条的图片
        UIImageView *frontPageimage = [[UIImageView alloc]initWithFrame:CGRectMake(20*BOScreenW/750, 24*BOScreenH/1334, 130*BOScreenW/750, 32*BOScreenH/1334)];
        frontPageimage.image = [UIImage imageNamed:@"home_img_toutiao"];
        [_goldView addSubview:frontPageimage];
        
        CGFloat frontPageImagessssX = CGRectGetMaxX(frontPageimage.frame) + 3*BOScreenW/750;
        UILabel *maohaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(frontPageImagessssX, 17*BOScreenH/1334, 10*BOScreenW/750, 40*BOScreenH/1334)];
        maohaoLabel.text = @":";
        maohaoLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
        [_goldView addSubview:maohaoLabel];
//        //创建人寿保险
//        CGFloat frontPageImageX = CGRectGetMaxX(frontPageimage.frame) + 0*BOScreenW/750;
//        UILabel *insuranceLabel = [[UILabel alloc]initWithFrame:CGRectMake(frontPageImageX, 19*BOScreenH/1334, BOScreenW - 190*BOScreenW/750 - 0*BOScreenW/750, 42*BOScreenH/1334)];
//        insuranceLabel.text = @" : ";
//        insuranceLabel.textColor = [UIColor colorWithRed:115/255.0 green:115/255.0 blue:115/255.0 alpha:1];
//        insuranceLabel.font = [UIFont systemFontOfSize:14];
//        [_goldView addSubview:insuranceLabel];
        
        //点评有奖 签到 风险评估的view
        CGFloat goldViewY = CGRectGetMaxY(_goldView.frame) + 16*BOScreenH/1334;
        UIView *commentsView = [[UIView alloc]initWithFrame:CGRectMake(0, goldViewY, BOScreenW, 320*BOScreenH/1334)];
        commentsView.backgroundColor = [UIColor whiteColor];
        [self addSubview:commentsView];
        //点评有奖
        UILabel *commentsLabel = [[UILabel alloc]initWithFrame:CGRectMake(20*BOScreenW/750, 40*BOScreenH/1334, 300*BOScreenW/750, 30*BOScreenH/1334)];
        commentsLabel.text = @"有金点评";
        [commentsLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        commentsLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        [commentsView addSubview:commentsLabel];
        //让你的点评有价值
        CGFloat commentsLabelY = CGRectGetMaxY(commentsLabel.frame) + 18*BOScreenH/1334;
        UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(20*BOScreenW/750, commentsLabelY, 300*BOScreenW/750, 23*BOScreenH/1334)];
        valueLabel.text = @"让你的点评有价值";
        valueLabel.font = [UIFont systemFontOfSize:12];
        valueLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        [commentsView addSubview:valueLabel];
        //点评有奖的图片
        CGFloat valueLabelY = CGRectGetMaxY(valueLabel.frame) + 9*BOScreenH/1334;
        UIImageView *commentsImage = [[UIImageView alloc]initWithFrame:CGRectMake(20*BOScreenW/750, valueLabelY, 300*BOScreenW/750, 200*BOScreenH/1334)];
        commentsImage.image = [UIImage imageNamed:@"home_img_dpyj"];
        [commentsView addSubview:commentsImage];
        //点评有奖的button点击事件
        _commentsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentsBtn.frame = CGRectMake(0, 0, 340*BOScreenW/750, 320*BOScreenH/1334);
//        [commentsBtn addTarget:self action:@selector(commentsBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [commentsView addSubview:_commentsBtn];
        //第一条分界线
        UILabel *boundaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(340*BOScreenW/750, 0, 1, 320*BOScreenH/1334)];
        boundaryLabel.backgroundColor = [UIColor colorWithRed:218/255.0 green:221/255.0 blue:224/255.0 alpha:1];
        [commentsView addSubview:boundaryLabel];
        //签到
        CGFloat boundaryLabelX = CGRectGetMaxX(boundaryLabel.frame) + 30*BOScreenW/750;
        UILabel *signInLabel = [[UILabel alloc]initWithFrame:CGRectMake(boundaryLabelX, 40*BOScreenH/1334, 200*BOScreenW/750, 30*BOScreenH/1334)];
        [signInLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        signInLabel.text = @"签到" ;
        [commentsView addSubview:signInLabel];
        //每日签到赢U币
        CGFloat signInLabelY = CGRectGetMaxY(signInLabel.frame) + 18*BOScreenH/1334;
        UILabel *monerLabel = [[UILabel alloc]initWithFrame:CGRectMake(boundaryLabelX, signInLabelY, 200*BOScreenW/750, 23*BOScreenH/1334)];
        monerLabel.text = @"每日签到领U币";
        monerLabel.font = [UIFont systemFontOfSize:12];
        monerLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        [commentsView addSubview:monerLabel];
        //签到的图片
        UIImageView *signInimage = [[UIImageView alloc]initWithFrame:CGRectMake(BOScreenW-20*BOScreenW/750-160*BOScreenW/750, 0, 160*BOScreenW/750, 160*BOScreenW/750)];
        signInimage.image = [UIImage imageNamed:@"home_img_qd"];
        [commentsView addSubview:signInimage];
        //签到的button点击事件
        _cignInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cignInBtn.frame = CGRectMake(340*BOScreenW/750, 0, 410*BOScreenW/750, 160*BOScreenH/1334);
//        [cignInBtn addTarget:self action:@selector(cignInBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [commentsView addSubview:_cignInBtn];
        //第二条分界线
        UILabel *secondBoundaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(340*BOScreenW/750+1, 160*BOScreenW/750, 410*BOScreenW/750, 1)];
        secondBoundaryLabel.backgroundColor = [UIColor colorWithRed:218/255.0 green:221/255.0 blue:224/255.0 alpha:1];
        [commentsView addSubview:secondBoundaryLabel];
        //风险评估
        CGFloat boundaryLabelXxx = CGRectGetMaxX(boundaryLabel.frame) + 30*BOScreenW/750;
        CGFloat secondBoundaryLabelY = CGRectGetMaxY(secondBoundaryLabel.frame) + 40*BOScreenH/1334;
        UILabel *riskLabel = [[UILabel alloc]initWithFrame:CGRectMake(boundaryLabelXxx, secondBoundaryLabelY, 200*BOScreenW/750, 30*BOScreenH/1334)];
        [riskLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        riskLabel.text = @"风险评估";
        [commentsView addSubview:riskLabel];
        //你的智慧财富管家
        CGFloat riskLabelY = CGRectGetMaxY(riskLabel.frame) + 18*BOScreenH/1334;
        UILabel *stewardLabel = [[UILabel alloc]initWithFrame:CGRectMake(boundaryLabelXxx, riskLabelY, 200*BOScreenW/750, 23*BOScreenH/1334)];
        stewardLabel.text = @"您的智慧财富管家";
        stewardLabel.font = [UIFont systemFontOfSize:12];
        stewardLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        [commentsView addSubview:stewardLabel];
        //风险评估的图片
        UIImageView *riskimage = [[UIImageView alloc]initWithFrame:CGRectMake(BOScreenW-20*BOScreenW/750-160*BOScreenW/750, 160*BOScreenH/1334, 160*BOScreenW/750, 160*BOScreenW/750)];
        riskimage.image = [UIImage imageNamed:@"home_img_fxpg"];
        [commentsView addSubview:riskimage];
        //风险评估的button点击事件
        _riskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _riskBtn.frame = CGRectMake(340*BOScreenW/750+1, 160*BOScreenH/1334, 410*BOScreenW/750, 160*BOScreenH/1334);
//        [riskBtn addTarget:self action:@selector(riskBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [commentsView addSubview:_riskBtn];
        
        NSArray *calculateArray = [[NSArray alloc]initWithObjects:@"理财计算",@"车贷计算",@"房贷计算",@"分期计算", nil];
        NSArray *calculateImageArray = [[NSArray alloc]initWithObjects:@"home_icon_licai",@"home_icon_chedai",@"home_icon_fangdai",@"home_icon_fenqi", nil];
        //理财工具的view
        CGFloat commentsViewY = CGRectGetMaxY(commentsView.frame) + 16*BOScreenH/1334;
        UIView *financialView = [[UIView alloc]initWithFrame:CGRectMake(0, commentsViewY, BOScreenW, 300*BOScreenH/1334)];
        financialView.backgroundColor = [UIColor whiteColor];
        [self addSubview:financialView];
        //理财工具前面的蓝色
        UILabel *blueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 23*BOScreenH/1334, 10*BOScreenW/750, 34*BOScreenH/1334)];
        blueLabel.backgroundColor = [UIColor colorWithRed:70/255.0 green:151/255.0 blue:251/255.0 alpha:1];
        [financialView addSubview:blueLabel];
        //理财工具
        UILabel *toolsLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 300*BOScreenW/750, 30*BOScreenH/1334)];
        toolsLabel.text = @"理财工具";
        [toolsLabel setFont:[UIFont systemFontOfSize:15.0]];
        toolsLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        [financialView addSubview:toolsLabel];
        //理财工具下面的一天灰色的线
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 80*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
        lineLabel.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        [financialView addSubview:lineLabel];
        //创建四个button label
        for (int i = 0; i < 4; i++)
        {
            _calculateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _calculateBtn.frame = CGRectMake(32*BOScreenW/750 + 120*BOScreenW/750*i + (BOScreenW-64*BOScreenW/750-120*BOScreenW/750*4)/3*i, 98*BOScreenH/1334, 120*BOScreenW/750, 120*BOScreenW/750);
            [_calculateBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",calculateImageArray[i]]] forState:UIControlStateNormal];
            _calculateBtn.tag = 10 + i;
            [_calculateBtn addTarget:self action:@selector(calculateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [financialView addSubview:_calculateBtn];
            
            CGFloat calculateBtnY = CGRectGetMaxY(_calculateBtn.frame) + 16*BOScreenH/1334;
            UILabel *calculateLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*BOScreenW/750 + 120*BOScreenW/750*i + (BOScreenW-64*BOScreenW/750-120*BOScreenW/750*4)/3*i, calculateBtnY, 120*BOScreenW/750, 26*BOScreenH/1334)];
            calculateLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            [calculateLabel setFont:[UIFont systemFontOfSize:13]];
            if (iPhone5)
            {
                [calculateLabel setFont:[UIFont systemFontOfSize:12]];
            }
            calculateLabel.textAlignment = NSTextAlignmentCenter;
            [financialView addSubview:calculateLabel];
            calculateLabel.text = [NSString stringWithFormat:@"%@",calculateArray[i]];
        }

    }
    return self;
}

//创建五个button和五个label的代理方法
- (void)bankButtonClick:(UIButton *)sender
{
    //如果myButtonWillTap被实现啦，此时我们就实现myButtonWillTapf方法
    if ([self.delegate respondsToSelector:@selector(buttonBeTouched:)])
    {
        [self.delegate buttonBeTouched:sender];
    }
}
//理财工具 计算的代理方法
- (void)calculateBtnClick:(UIButton *)sender
{
    //如果myButtonWillTap被实现啦，此时我们就实现myButtonWillTapf方法
    if ([self.delegate respondsToSelector:@selector(buttoncalculateBtnClick:)]) {
        [self.delegate buttoncalculateBtnClick:sender];
    }
}
@end
