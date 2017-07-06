//
//  BODynamicDetailsVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BODynamicDetailsVC.h"

@interface BODynamicDetailsVC ()

@end

@implementation BODynamicDetailsVC

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.view.frame = CGRectMake(0, 0, BOScreenW, BOScreenH);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.tabBarController.tabBar.hidden = YES;
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
