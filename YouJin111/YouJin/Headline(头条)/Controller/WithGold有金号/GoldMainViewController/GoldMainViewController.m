//
//  GoldMainViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "GoldMainViewController.h"
#import "GoldMainViewController+Configures.h"


@interface GoldMainViewController ()

@end

@implementation GoldMainViewController


+ (instancetype)createWithHasApplyForVip:(BOOL)hasApplyForVip {
    GoldMainViewController *vc  = [GoldMainViewController create];
    vc.hasApplyForVip = hasApplyForVip;
    return vc;
}

+ (instancetype)create {
    GoldMainViewController *vc = [[GoldMainViewController alloc]initWithNibName:@"GoldMainViewController"  bundle:nil];
    return vc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    [self lackViewHidden:YES];
    [self requireCanApplyGoldStatus];
    [self requireGoldAccountFoucsListWithStartCount:0 limitCount:20];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - actionMethod


- (void)returnAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)applyAction:(UIButton *)button {
    self.applyView.hidden = NO;
}



#pragma mark - reget 

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager bo_manager];
    }
    return _manager;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)setHasApplyForVip:(BOOL)hasApplyForVip {
    if (_hasApplyForVip != hasApplyForVip) {
        _hasApplyForVip = hasApplyForVip;
        self.applyButton.hidden = hasApplyForVip;
    }
}

#pragma mark - helpMethod

- (void)lackViewHidden:(BOOL)hidden {
    self.lackView.hidden = hidden;
    self.tableView.hidden = !hidden;
}

- (void)goldFoucsTopRefreshing {
    if (self.isRefreshing) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireGoldAccountFoucsListWithStartCount:0 limitCount:20];
}

- (void)goldFoucsBottomRefreshing {
    if (self.isNoMoreData || self.isRefreshing) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireGoldAccountFoucsListWithStartCount:self.dataArray.count limitCount:20];
}

- (void)tableViewEndRefreshing {
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
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
