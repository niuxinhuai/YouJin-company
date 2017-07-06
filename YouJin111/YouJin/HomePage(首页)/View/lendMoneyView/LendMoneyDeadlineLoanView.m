//
//  LendMoneyDeadlineLoanView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/14.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "LendMoneyDeadlineLoanView.h"
#import "BOLcationButton.h"
#import "LendMoneyDetailModel.h"
@interface LendMoneyDeadlineLoanView()

/**引用显示借款金额的label*/
@property (nonatomic, weak) UILabel *loanNumLabel;

/**引用中间的分割线View*/
@property (nonatomic, weak) UIView *divisionView;

/**引用分期时间的button*/
@property (nonatomic, weak) BOLcationButton *deadlineBtn;

/**引用分期时间的label*/
@property (nonatomic, weak) UILabel *deadlineLabel;
@end
@implementation LendMoneyDeadlineLoanView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 添加显示借款金额的Button
        BOLcationButton *loanMoneyBtn = [[BOLcationButton alloc] init];
        self.loanMoneyBtn = loanMoneyBtn;
        [self addSubview:loanMoneyBtn];
        
        //借钱的button
        _jiekuanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_jiekuanButton];
        
        // 添加显示借款金额的label
        UILabel *loanNumLabel = [[UILabel alloc] init];
        self.loanNumLabel = loanNumLabel;
        [self addSubview:loanNumLabel];
        
        // 添加中部的分割线View
        UIView *divisionView = [[UIView alloc] init];
        self.divisionView = divisionView;
        [self addSubview:divisionView];
        
        // 添加显示分期时间的Button
        BOLcationButton *deadlineBtn = [[BOLcationButton alloc] init];
        self.deadlineBtn = deadlineBtn;
        [self addSubview:deadlineBtn];
        
        //分期期限的按钮
        _yueButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_yueButton];
        
        // 添加显示分期的label
        UILabel *deadlineLabel = [[UILabel alloc] init];
        self.deadlineLabel = deadlineLabel;
        [self addSubview:deadlineLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setItem:(LendMoneyDetailModel *)item {
    _item = item;
    // 设置借款金额的button
    CGFloat loanMoneyX = ((BOScreenW - 30) * 0.5 - 100) * 0.5 * BOWidthRate;
    CGFloat loanMOneyY = 21 * BOHeightRate;
    CGFloat loanMoneyW = 100 * BOWidthRate;
    CGFloat loanMoneyH = 20 * BOHeightRate;
    self.loanMoneyBtn.frame = CGRectMake(loanMoneyX, loanMOneyY, loanMoneyW, loanMoneyH);
//    [self.loanMoneyBtn setTitle:@"5000" forState:UIControlStateNormal];
//    [self.loanMoneyBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
//    [self.loanMoneyBtn setTitleColor:[UIColor colorWithHexString:@"#FA9531" alpha:1] forState:UIControlStateNormal];
//    [self.loanMoneyBtn setImage:[UIImage imageNamed:@"icon_arrowgreen"] forState:UIControlStateNormal];
    
    //借钱按钮
    _jiekuanButton.frame = CGRectMake(loanMoneyX, loanMOneyY, loanMoneyW, loanMoneyH);
    [_jiekuanButton setTitle:@"5000" forState:UIControlStateNormal];
    _jiekuanButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    [_jiekuanButton setTitleColor:[UIColor colorWithHexString:@"#FA9531" alpha:1] forState:UIControlStateNormal];
    [_jiekuanButton setImage:[UIImage imageNamed:@"icon_arroworange"] forState:UIControlStateNormal];
    // 重点位置开始
    _jiekuanButton.imageEdgeInsets = UIEdgeInsetsMake(0, _jiekuanButton.titleLabel.width, 0, -_jiekuanButton.titleLabel.width - 1.5*loanMoneyW);
    _jiekuanButton.titleEdgeInsets = UIEdgeInsetsMake(0, -_jiekuanButton.currentImage.size.width, 0, _jiekuanButton.currentImage.size.width);
    
    // 设置借款金额的label
    CGFloat loanNumX = 0;
    CGFloat loanNumY = CGRectGetMaxY(self.loanMoneyBtn.frame) + 15 * BOHeightRate;
    CGFloat loanNumW = (BOScreenW - 30 * BOWidthRate) * 0.5;
    CGFloat loanNumH = 15 * BOHeightRate;
    self.loanNumLabel.frame = CGRectMake(loanNumX, loanNumY, loanNumW, loanNumH);
    NSString *string = [[NSString alloc] init];
        string = [NSString stringWithFormat:@"%.1f万",[item.min_limit floatValue] / 10000];
    NSString *string1 = [[NSString alloc] init];
    if ([item.max_limit intValue] / 10000) {
        string1 = [NSString stringWithFormat:@"%.0f万",[item.max_limit floatValue] / 10000];
    }else {
        string1 = [NSString stringWithFormat:@"%@",item.max_limit];
    }
    
    self.loanNumLabel.text = [NSString stringWithFormat:@"借款金额(%@~%@)",string,string1];
    [self.loanNumLabel setFont:[UIFont systemFontOfSize:11]];
    self.loanNumLabel.textColor = [UIColor colorWithHexString:@"#B3B3B3" alpha:1];
    [self.loanNumLabel setTextAlignment:NSTextAlignmentCenter];
    // 设置中间的分割线
    CGFloat divisionX = (BOScreenW - 30 * BOWidthRate) * 0.5;
    CGFloat divisionY = 19 * BOHeightRate;
    CGFloat divisionW = 1;
    CGFloat divisionH = 42 * BOHeightRate;
    self.divisionView.frame = CGRectMake(divisionX, divisionY, divisionW, divisionH);
    self.divisionView.backgroundColor = [UIColor colorWithHexString:@"#8CCFFB" alpha:1];
    // 设置分期期限的button
    CGFloat deadlineX = (BOScreenW - 30 * BOWidthRate) * 0.5 +
    loanMoneyX;
    CGFloat deadlineY = loanMOneyY;
    CGFloat deadlineW = loanMoneyW;
    CGFloat deadlineH = loanMoneyH;
    self.deadlineBtn.frame = CGRectMake(deadlineX, deadlineY, deadlineW, deadlineH);
//    [self.deadlineBtn setTitle:@"1月" forState:UIControlStateNormal];
//    [self.deadlineBtn setTitleColor:[UIColor colorWithHexString:@"#8FC31F" alpha:1] forState:UIControlStateNormal];
//    [self.deadlineBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
//    [self.deadlineBtn setImage:[UIImage imageNamed:@"icon_arrowgreen"] forState:UIControlStateNormal];
    
    //分期期限的按钮
    _yueButton.frame = CGRectMake(deadlineX, deadlineY, deadlineW, deadlineH);
    [_yueButton setTitle:@"1月" forState:UIControlStateNormal];
    [_yueButton setTitleColor:[UIColor colorWithHexString:@"#8FC31F" alpha:1] forState:UIControlStateNormal];
    _yueButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    [_yueButton setImage:[UIImage imageNamed:@"icon_arrowgreen"] forState:UIControlStateNormal];
    // 重点位置开始
    _yueButton.imageEdgeInsets = UIEdgeInsetsMake(0, _yueButton.titleLabel.width, 0, -_yueButton.titleLabel.width - deadlineW);
    _yueButton.titleEdgeInsets = UIEdgeInsetsMake(0, -_yueButton.currentImage.size.width, 0, _yueButton.currentImage.size.width);
    
    // 设置分期期限的label
    CGFloat deadLX = (BOScreenW - 30 * BOWidthRate) * 0.5;
    CGFloat deadLY = loanNumY;
    CGFloat deadLW = (BOScreenW - 30 * BOWidthRate) * 0.5;
    CGFloat deadLH = loanNumH;
    self.deadlineLabel.frame = CGRectMake(deadLX, deadLY, deadLW, deadLH);
    
    if (item.fenqi_limit.length > 0)
    {
        NSString *str2 = item.fenqi_limit;
        NSArray *temp=[str2 componentsSeparatedByString:@","];
        self.deadlineLabel.text = [NSString stringWithFormat:@"分期期限(%@-%@月)",[temp firstObject],[temp lastObject]];
    }
    
    [self.deadlineLabel setFont:[UIFont systemFontOfSize:11]];
    self.deadlineLabel.textColor = [UIColor colorWithHexString:@"#B3B3B3" alpha:1];
    self.deadlineLabel.textAlignment = NSTextAlignmentCenter;
    
    // 设置圆角半径和阴影
    self.layer.cornerRadius = 10 * BOWidthRate;
    //    self.layer.masksToBounds = YES;
    self.layer.shadowColor = [UIColor colorWithHexString:@"1380F2" alpha:1].CGColor;
    self.layer.shadowRadius = 10 * BOWidthRate;
    self.layer.shadowOpacity = 0.16;
    self.layer.shadowOffset = CGSizeMake(2.5 * BOWidthRate, 4 * BOHeightRate);
}

//-(NSMutableArray*)test:(NSInteger)min  max:(NSInteger)max
//{
//    NSMutableArray *muArray=[NSMutableArray arrayWithCapacity:20];
//    NSInteger temp=min;
//    while (temp<=max) {
//        [muArray addObject:[NSString stringWithFormat: @"%ld",(long)temp]];
//        temp+=1000;
//    }
//    NSLog(@"muArray%@",muArray);
//    return muArray;
//}
@end
