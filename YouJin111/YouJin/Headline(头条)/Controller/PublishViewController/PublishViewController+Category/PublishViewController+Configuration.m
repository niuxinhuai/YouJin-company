//
//  PublishViewController+Configuration.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PublishViewController+Configuration.h"
#import "PublishViewController+Delegate.h"

@implementation PublishViewController (Configuration)

- (void)configureViews {
    [self configureTableView];
    [self configurePlatePickView];
    [self configureGesture];
    self.plateView.hidden = YES;
    self.headerView = [PublishTableHeaderView create];
    self.headerView.delegate = self;
    [self.originalButton makeCornerBorderWithWidth:.5 cornerRadius:5 borderColor:[UIColor colorWithIntRed:143 green:195 blue:31 alpha:1]];
}



- (void)configureTableView {
    [self configureDatasource];
    self.tableView.dataSource = self.datasource;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ContentPartCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([ContentPartCell class])];
}

- (void)configurePlatePickView {
    self.platePickView.delegate = self;
    self.platePickView.dataSource = self;
}


- (void)configureDatasource {
    self.datasource = [[PublishDatasource alloc]init];
    __weak typeof(self) weakSelf = self;
    self.datasource.configureContentPartCell = ^(ContentPartCell *cell, NSIndexPath *indexPath) {
        cell.delegate = weakSelf;
    };
    [self.datasource.contents addObject:[self.datasource createCardContentToolWithType:ContentPartTypeText image:nil text:@""]];
    self.datasource.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
}


- (void)configureGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.plateView addGestureRecognizer:tap];
}


#pragma mark - helpMethod


- (void)platePickviewShow:(BOOL)show {
    self.plateView.hidden = NO;
    [UIView animateWithDuration:.3 animations:^{
        self.platePickBottomToSuperBottom.constant = show ? 0 : -200;
        [self.plateView layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.plateView.hidden = !show;
    }];
}


- (void)tap:(UIGestureRecognizer *)sender {
    [self platePickviewShow:NO];
}



@end
