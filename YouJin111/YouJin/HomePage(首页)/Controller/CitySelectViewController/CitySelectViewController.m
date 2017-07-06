//
//  CitySelectViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CitySelectViewController.h"
#import "CitySelectViewController+Configuration.h"

@interface CitySelectViewController ()

@end

@implementation CitySelectViewController

-(void)dealloc {
    
}

+ (instancetype)create {
    CitySelectViewController *vc = [[CitySelectViewController alloc]initWithNibName:@"CitySelectViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTools];
    [self configureViews];
    [self requireCityList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actionMethod

- (IBAction)returnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - reget 


- (NSMutableArray *)sectionIndexArray {
    if (!_sectionIndexArray) {
        _sectionIndexArray = [NSMutableArray arrayWithObjects:@"!", @"$", nil];
    }
    return _sectionIndexArray;
}


@end
