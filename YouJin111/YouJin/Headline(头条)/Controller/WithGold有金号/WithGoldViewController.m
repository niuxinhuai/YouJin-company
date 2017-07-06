//
//  WithGoldViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "WithGoldViewController.h"
#import "ToApplyForView.h"
#import "EnterpriseCertificationViewController.h"
#import "MediaCertificationViewController.h"

@interface WithGoldViewController ()
@property (nonatomic ,strong)UIView *bgView;//底部View
@property (nonatomic ,strong)ToApplyForView *toApplyforview;//申请有金号的view
@end

@implementation WithGoldViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"有金号"];
//    // 设置leftButtonItem
//    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
//    self.navigationItem.leftBarButtonItem = btnItem;
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
//    //设置rightBarButtonItem
//    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,130*BOScreenW/750,40*BOScreenH/1334)];
//    [rightButton setTitle:@"申请" forState:UIControlStateNormal];
//    rightButton.backgroundColor = [UIColor orangeColor];
//    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 250, 0, 10);
////    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame= CGRectMake(0, 0, 130*BOScreenW/750, 40*BOScreenH/1334);
    [btn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -14;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];

    
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //企业和自媒体认证返回的时候
    _toApplyforview.hidden = YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //背景view
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    _bgView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    [self.view addSubview:_bgView];
    
    //还没有关注有金号View
    [self aboutTopView];
    //为你推荐
    [self aboutMiddleView];
    //头像 名称 关注
    [self aboutBelowView];
}
#pragma mark---topView----
-(void)aboutTopView
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 510*BOScreenH/1334)];
    topView.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:topView];
    
    UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(250*BOScreenW/750, 104*BOScreenH/1334, 250*BOScreenW/750, 250*BOScreenW/750)];
    topImage.image = [UIImage imageNamed:@"img_a"];
    [topView addSubview:topImage];
    
    CGFloat topImageY = CGRectGetMaxY(topImage.frame) + 30*BOScreenH/1334;
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(205*BOScreenW/750, topImageY, 340*BOScreenW/750, 40*BOScreenH/1334)];
    topLabel.text = @"你还没有关注的有金号";
    topLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.font = [UIFont systemFontOfSize:14];
    [topView addSubview:topLabel];
}
#pragma mark---为你推荐View---
- (void)aboutMiddleView
{
    UIView *middleView = [[UIView alloc]initWithFrame:CGRectMake(0, 510*BOScreenH/1334, BOScreenW, 60*BOScreenH/1334)];
    middleView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    [_bgView addSubview:middleView];
    
    UIView *frontLineView = [[UIView alloc]initWithFrame:CGRectMake(136*BOScreenW/750, 29*BOScreenH/1334, 124*BOScreenW/750, 1)];
    frontLineView.backgroundColor = [UIColor colorWithHexString:@"#cccccc" alpha:1];
    [middleView addSubview:frontLineView];
    
    UIButton *middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    middleButton.userInteractionEnabled = NO;
    middleButton.frame = CGRectMake(280*BOScreenW/750, 10*BOScreenH/1334, 190*BOScreenW/750, 40*BOScreenH/1334);
    [middleButton setImage:[UIImage imageNamed:@"icon_hots"] forState:UIControlStateNormal];
    [middleButton setTitle:@"  为你推荐" forState:UIControlStateNormal];
    [middleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [middleButton setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
    [middleButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    middleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [middleView addSubview:middleButton];
    
    UIView *backLineView = [[UIView alloc]initWithFrame:CGRectMake(490*BOScreenW/750, 29*BOScreenH/1334, 124*BOScreenW/750, 1)];
    backLineView.backgroundColor = [UIColor colorWithHexString:@"#cccccc" alpha:1];
    [middleView addSubview:backLineView];
}
#pragma mark---头像 名称 关注View---
- (void)aboutBelowView
{
    UIView *belowView= [[UIView alloc]initWithFrame:CGRectMake(0, 570*BOScreenH/1334, BOScreenW, BOScreenH-570*BOScreenH/1334)];
    belowView.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:belowView];
    
    for (int i = 0; i < 6; i ++)
    {
        NSInteger index = i % 3;//取余数
        NSInteger page = i / 3;//取商
        
        UIImageView *belowImage = [[UIImageView alloc]initWithFrame:CGRectMake(index*(100*BOScreenW/750+145*BOScreenW/750)+80*BOScreenW/750, page*(100*BOScreenW/750 + 170*BOScreenH/1334)+60*BOScreenH/1334, 100*BOScreenW/750, 100*BOScreenW/750)];
        [belowView addSubview:belowImage];
        //图片设置圆形
        UIImage *image = [UIImage imageNamed:@"logo_youjin"];
        UIGraphicsBeginImageContext(image.size);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        [path addClip];
        [image drawAtPoint:CGPointZero];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        belowImage.image = newImage;
        
        UILabel *belowLabel = [[UILabel alloc]initWithFrame:CGRectMake(index*(200*BOScreenW/750+45*BOScreenW/750)+32*BOScreenW/750 - 30*BOScreenW/750, page*(23*BOScreenW/750 + 250*BOScreenH/1334)+180*BOScreenH/1334, 260*BOScreenW/750, 26*BOScreenH/1334)];
        belowLabel.text = @"昵称昵称昵称昵称";
        belowLabel.font = [UIFont systemFontOfSize:12];
        belowLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        belowLabel.textAlignment = NSTextAlignmentCenter;
        [belowView addSubview:belowLabel];
        
        UIButton *belowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        belowButton.frame = CGRectMake(index*(80*BOScreenW/750+165*BOScreenW/750)+80*BOScreenW/750, page*(40*BOScreenW/750 + 232*BOScreenH/1334)+233*BOScreenH/1334, 100*BOScreenW/750, 46*BOScreenH/1334);
        [belowButton setBackgroundImage:[UIImage imageNamed:@"common_btn_guanzhu_nor"] forState:UIControlStateNormal];
        [belowView addSubview:belowButton];
    }
}
#pragma mark----点击申请按钮的点击事件----
- (void)rightButtonClick
{
    //隐藏navigationBar
    self.navigationController.navigationBarHidden = YES;
    
    //申请有金号view
    _toApplyforview = [[ToApplyForView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    [self.view addSubview:_toApplyforview];
    
    //添加单击的点击事件
    UITapGestureRecognizer *Ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GesClick:)];
    Ges.numberOfTapsRequired = 1;
    [_toApplyforview.effectView addGestureRecognizer:Ges];
    
    //企业申请的点击事件(也就是最下面按钮)
    [_toApplyforview.enterpriseGoButton addTarget:self action:@selector(enterpriseGoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //自媒体申请的点击事件(也就是最上面按钮)
    [_toApplyforview.sinceMediaButton addTarget:self action:@selector(sinceMediaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark---自媒体申请也就是上面按钮的点击事件---
- (void)sinceMediaButtonClick:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"自媒体申请"])
    {
        NSLog(@"自媒体申请");
        MediaCertificationViewController *medcarVc = [[MediaCertificationViewController alloc]init];
        medcarVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:medcarVc animated:YES];
    }
    if ([sender.titleLabel.text isEqualToString:@"企业申请"])
    {
        NSLog(@"企业申请");
        EnterpriseCertificationViewController *encerVc = [[EnterpriseCertificationViewController alloc]init];
        encerVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:encerVc animated:YES];
    }
}
#pragma mark---企业申请也就是下面按钮的点击事件---
- (void)enterpriseGoButtonClick:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"自媒体申请"])
    {
        NSLog(@"自媒体申请");
        //改变图片
        _toApplyforview.penImage.image = [UIImage imageNamed:@"img_geren"];
        //改变文字
       // _toApplyforview.suitableLabel.text = @"适合垂直领域专家、意见领袖、评论家及自媒体人士申请";
        [_toApplyforview.sinceMediaButton setTitle:@"自媒体申请" forState:UIControlStateNormal];
        [_toApplyforview.enterpriseGoButton setTitle:@"企业申请" forState:UIControlStateNormal];
    }else
    {
        //改变图片
        _toApplyforview.penImage.image = [UIImage imageNamed:@"img_qiye"];
        //改变文字
       // _toApplyforview.suitableLabel.text = @"适合各企事业单位申请";
        [_toApplyforview.sinceMediaButton setTitle:@"企业申请" forState:UIControlStateNormal];
        [_toApplyforview.enterpriseGoButton setTitle:@"自媒体申请" forState:UIControlStateNormal];
    }
}
#pragma mark---毛玻璃效果view的手势单击事件---
- (void)GesClick:(UITapGestureRecognizer *)sender
{
    [_toApplyforview removeFromSuperview];
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
