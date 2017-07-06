//
//  NotAttentionVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/23.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NotAttentionVC.h"

@interface NotAttentionVC ()

@end

@implementation NotAttentionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BOColor(244, 245, 247);
    // 设置关注控制器的子控件
    [self setupAttentionChildView];
}

- (void)setupAttentionChildView {
    // 添加pictureIcon
    CGFloat pictureX = (BOScreenW - 125 * BOWidthRate) * 0.5;
    CGFloat pictureY = 130 * BOHeightRate;
    CGFloat pictureWH = 125 * BOWidthRate;
    UIImageView *pictureImageV = [[UIImageView alloc] initWithFrame:CGRectMake(pictureX, pictureY, pictureWH, pictureWH)];
    pictureImageV.image = [UIImage imageNamed:@"img_a"];
    [self.view addSubview:pictureImageV];
    
    // 添加您还没有关注的版块
    CGFloat noAttentionX = 0;
    CGFloat noAttentionY = CGRectGetMaxY(pictureImageV.frame) + 15 * BOHeightRate;
    CGFloat noAttentionW = BOScreenW;
    CGFloat noAttentionH = 15 * BOHeightRate;
    UILabel *noAttentionLabel = [[UILabel alloc] initWithFrame:CGRectMake(noAttentionX, noAttentionY, noAttentionW, noAttentionH)];
    noAttentionLabel.text = @"您还没有关注的版块";
    [noAttentionLabel setFont:[UIFont systemFontOfSize:14]];
    noAttentionLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    noAttentionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:noAttentionLabel];
    //  添加关注版块按钮
    CGFloat moduleX = (BOScreenW - 95 * BOWidthRate) * 0.5;
    CGFloat moduleY = CGRectGetMaxY(noAttentionLabel.frame) + 25;
    CGFloat moduleW = 95 * BOWidthRate;
    CGFloat moduleH = 34 * BOHeightRate;
    UIButton *moduleBtn = [[UIButton alloc] initWithFrame:CGRectMake(moduleX, moduleY, moduleW, moduleH)];
    moduleBtn.layer.cornerRadius = 4 * BOWidthRate;
    moduleBtn.layer.masksToBounds = YES;
    moduleBtn.backgroundColor = [UIColor colorWithHexString:@"#8FC31F" alpha:1];
    [moduleBtn setTitle:@"关注版块" forState:UIControlStateNormal];
    [moduleBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [moduleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:moduleBtn];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
