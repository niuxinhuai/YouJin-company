//
//  CheckAnswerViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/24.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CheckAnswerViewController.h"

@interface CheckAnswerViewController ()<UIScrollViewDelegate>
@property(nonatomic ,strong)UIView *problemBgView;//提交答案的view
@end

@implementation CheckAnswerViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"答题签到"];
//    // 设置leftButtonItem
//    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
//    self.navigationItem.leftBarButtonItem = btnItem;
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view .backgroundColor = [UIColor whiteColor];
    
    UIScrollView *homeScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    homeScrView.delegate = self;
    homeScrView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    homeScrView.showsVerticalScrollIndicator = NO;
    homeScrView.contentSize = CGSizeMake(BOScreenW, 3840*BOScreenH/1334+64);
    [self.view addSubview:homeScrView];
    
    UIImageView *onlyImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1080
*BOScreenW/750, 3840*BOScreenH/1334)];
    onlyImage.image  = [UIImage imageNamed:@"toutiaobanner"];
    [homeScrView addSubview:onlyImage];
    
    //提交答案的view
    [self theProblemView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y >= 1317)
    {
        [UIView animateWithDuration:0.8 animations:^{
            _problemBgView.frame = CGRectMake(0, BOScreenH - 480*BOScreenH/1334-64, BOScreenW, 480*BOScreenH/1334);
        }];
    }else
    {
        [UIView animateWithDuration:0.8 animations:^{
            _problemBgView.frame = CGRectMake(0, BOScreenH, BOScreenW, 480*BOScreenH/1334);
        }];
    }
}
#pragma mark---提交答案的view---
- (void)theProblemView
{
    _problemBgView = [[UIView alloc]initWithFrame:CGRectMake(0, BOScreenH, BOScreenW, 480*BOScreenH/1334)];
    _problemBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_problemBgView];
    
    //今日答题签到剩余30/100次
    UILabel *numberOfLabel = [[UILabel alloc]initWithFrame:CGRectMake(BOScreenW - 520*BOScreenW/750, 34*BOScreenH/1334, 500*BOScreenW/750, 30*BOScreenH/1334)];
    numberOfLabel.text =  @"今日答题签到剩余30/100次";
    numberOfLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    numberOfLabel.font = [UIFont systemFontOfSize:12];
    numberOfLabel.textAlignment = NSTextAlignmentRight;
    [_problemBgView addSubview:numberOfLabel];
    
    //问题
    UILabel *proLabel = [[UILabel alloc]init];
    proLabel.text = @"问题:";
    proLabel.textColor = [UIColor colorWithHexString:@"#2d84f2" alpha:1];
    [proLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    //根据字体得到NSString的尺寸
    CGSize sizes = [proLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:proLabel.font,NSFontAttributeName, nil]];
    //名字的W
    CGFloat nameWs = sizes.width;
    proLabel.frame = CGRectMake(20*BOScreenW/750, 92*BOScreenH/1334, nameWs,40*BOScreenH/1334);
    [_problemBgView addSubview:proLabel];
    
    //新手专享复投宝，计划期限12个月
    CGFloat proLabelX = CGRectGetMaxX(proLabel.frame) + 22*BOScreenW/750;
    UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(proLabelX, 92*BOScreenH/1334, BOScreenW - proLabelX - 22*BOScreenW/750, 90*BOScreenH/1334)];
    newLabel.text =  @"新手专享复投宝，计划期限12个月，预期年化率为_________。";
    newLabel.numberOfLines = 0;
    newLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    newLabel.font = [UIFont systemFontOfSize:16];
    [_problemBgView addSubview:newLabel];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 6;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16], NSParagraphStyleAttributeName:paragraphStyle};
    newLabel.attributedText = [[NSAttributedString alloc]initWithString:newLabel.text attributes:attributes];
    
    //输入你的答案
    UITextField *inputTextField = [[UITextField alloc]initWithFrame:CGRectMake(117*BOScreenW/750, 210*BOScreenH/1334, 516*BOScreenW/750, 88*BOScreenH/1334)];
    inputTextField.placeholder = @"输入你的答案";
    inputTextField.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    inputTextField.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2" alpha:1];
    inputTextField.font = [UIFont systemFontOfSize:16];
    inputTextField.textAlignment = NSTextAlignmentCenter;
    inputTextField.layer.cornerRadius = 23;
    inputTextField.layer.masksToBounds = YES;
    [_problemBgView addSubview:inputTextField];
    
    //提交答案
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(117*BOScreenW/750, 332*BOScreenH/1334, 516*BOScreenW/750, 88*BOScreenH/1334);
    [submitButton setTitle:@"提交答案" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor colorWithHexString:@"#fefefe" alpha:1] forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    submitButton.backgroundColor = [UIColor colorWithHexString:@"#4697fb" alpha:1];
    submitButton.layer.cornerRadius = 23;
    submitButton.layer.masksToBounds = YES;
    [_problemBgView addSubview:submitButton];
    
    if (iPhone5)
    {
        newLabel.frame = CGRectMake(proLabelX, 88*BOScreenH/1334, BOScreenW - proLabelX - 22*BOScreenW/750, 105*BOScreenH/1334);
        inputTextField.layer.cornerRadius = 19;
        submitButton.layer.cornerRadius = 19;
    }
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
