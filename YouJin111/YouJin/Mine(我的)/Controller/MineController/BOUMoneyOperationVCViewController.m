//
//  BOUMoneyOperationVCViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOUMoneyOperationVCViewController.h"
#import "BOUMoneyIncomeVC.h"
#import "BOUMoneyExpendVC.h"
#import "BOUMoneyTaskVC.h"
@interface BOUMoneyOperationVCViewController ()

@end

@implementation BOUMoneyOperationVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupChildViewController];
    self.titleViewH = 44 * BOHeightRate;
    self.titleBackColor = [UIColor whiteColor];
}

#pragma mark - 添加当前控制器的子控制器
- (void)setupChildViewController {
    // U币收入的控制器
    BOUMoneyIncomeVC *uMoneyIncomeVC = [BOUMoneyIncomeVC createUMoneyVCWithAdd:YES];
    uMoneyIncomeVC.title = @"收入";
    [self addChildViewController:uMoneyIncomeVC];
    // 添U币支出的控制器
    BOUMoneyIncomeVC *uMoneyExpendVC = [BOUMoneyIncomeVC createUMoneyVCWithAdd:NO];;
    uMoneyExpendVC.title = @"支出";
    [self addChildViewController:uMoneyExpendVC];
    // U币任务的控制器
    BOUMoneyTaskVC *uMoneyTaskVC = [[BOUMoneyTaskVC alloc] init];
    uMoneyTaskVC.title = @"任务记录";
    [self addChildViewController:uMoneyTaskVC];
}

@end
