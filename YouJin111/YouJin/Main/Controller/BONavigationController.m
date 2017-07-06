//
//  BONavigationController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/4.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BONavigationController.h"

@interface BONavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BONavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
