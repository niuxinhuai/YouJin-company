//
//  GoldMainViewController+Configures.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "GoldMainViewController+Configures.h"


@implementation GoldMainViewController (Configures)



- (void)configureViews {
    [self configureApplyButton];
    [self configureNavgationBar];
    [self addApplyView];
    [self configureTableView];
    [self.lackView updateImage:@"img_a" lackText:@"您还没有关注的有金号"];
}

- (void)configureApplyButton {
    self.applyButton = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame= CGRectMake(0, 0, 130*BOScreenW/750, 40*BOScreenH/1334);
        [btn setTitle:@"申请" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(applyAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.hidden = self.hasApplyForVip;
        btn;
    });
    

}

- (void)configureTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(goldFoucsTopRefreshing)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    MJRefreshFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(goldFoucsBottomRefreshing)];
    self.tableView.mj_footer = footer;
    [self.tableView registerNib:[UINib nibWithNibName:@"HaveGoldCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([HaveGoldCell class])];
}


- (void)configureNavgationBar {
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"有金号"];
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(returnAction:)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:self.applyButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -14;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];
}


- (void)addApplyView {
    self.applyView = ({
        ToApplyForView *view = [[ToApplyForView alloc]initWithFrame:CGRectZero];
        view.delegate = self;
        view.hidden = YES;
        [self.view addSubview:view];
        view;
    });
    
    [self.applyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(-64));
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
    }];
}


- (void)endRefreshing {
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}




@end
