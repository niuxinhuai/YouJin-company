//
//  SendPostVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/23.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "SendPostVC.h"

@interface SendPostVC ()<UIGestureRecognizerDelegate>

@end

@implementation SendPostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.alpha = 0.92;
    // 添加点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    // 设置子控件
    [self setupChildView];
}
#pragma mark - 处理点击View的事件
- (void)viewClick {
    [self.view removeFromSuperview];
}
- (void)setupChildView {
    // 添加发表动态的按钮
    CGFloat sendConX = (BOScreenW - 230 * BOWidthRate) * 0.5;
    CGFloat sendConY = 279 * BOHeightRate;
    CGFloat sendConWH = 75 * BOWidthRate;
    UIButton *sendConditionBtn = [[UIButton alloc] initWithFrame:CGRectMake(sendConX, sendConY, sendConWH, sendConWH)];
    [sendConditionBtn setImage:[UIImage imageNamed:@"icon_fbdt"] forState:UIControlStateNormal];
    [self.view addSubview:sendConditionBtn];
    
    // 添加参与话题的按钮
    CGFloat participationX = CGRectGetMaxX(sendConditionBtn.frame) + 80 * BOWidthRate;
    CGFloat participationY = sendConY;
    CGFloat participationWH = sendConWH;
    UIButton *participationBtn = [[UIButton alloc] initWithFrame:CGRectMake(participationX, participationY, participationWH, participationWH)];
    [participationBtn setImage:[UIImage imageNamed:@"icon_cyht"] forState:UIControlStateNormal];
    [self.view addSubview:participationBtn];
    
    // 添加发表动态的label
    CGFloat sendX = sendConX;
    CGFloat sendY = CGRectGetMaxY(sendConditionBtn.frame) + 12 * BOHeightRate;
    CGFloat sendW = 75 * BOWidthRate;
    CGFloat sendH = 15 * BOHeightRate;
    UILabel *sendConditionLabel = [[UILabel alloc] initWithFrame:CGRectMake(sendX, sendY, sendW, sendH)];
    sendConditionLabel.text = @"发表动态";
    sendConditionLabel.textAlignment = NSTextAlignmentCenter;
    sendConditionLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    [self.view addSubview:sendConditionLabel];
    // 添加参与话题的label
    CGFloat takeX = CGRectGetMaxX(sendConditionLabel.frame) + 80 * BOWidthRate;
    CGFloat takeY = CGRectGetMaxY(sendConditionBtn.frame) + 12 * BOHeightRate;
    CGFloat takeW = 75 * BOWidthRate;
    CGFloat takeH = 15 * BOHeightRate;
    UILabel *takePartInLabel = [[UILabel alloc] initWithFrame:CGRectMake(takeX, takeY, takeW, takeH)];
    takePartInLabel.text = @"参与话题";
    takePartInLabel.textAlignment = NSTextAlignmentCenter;
    takePartInLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    [self.view addSubview:takePartInLabel];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
