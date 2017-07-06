//
//  HeadLineDetailViewController+Configuration.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/19.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineDetailViewController+Configuration.h"
#import "HeadLineDetailViewController+Delegate.h"
#import "HeadLineDetailViewController+LogicalFlow.h"

@implementation HeadLineDetailViewController (Configuration)


- (void)configureViews {
    [self configureContentDetailView];
    [self configureTableView];
    [self configureFootLabel];
    [self configureInputView];
    [self configureSectionHeaderView];
    self.commentTextField.delegate = self;
    [self.commentView makeShadowWithShadowColor:[UIColor placeholderColor] shadowOffset:CGSizeMake(0, -1) shadowRadius:.5 shadowOpacity:.8 shadowPath:[UIBezierPath bezierPathWithRect:self.commentView.bounds].CGPath];
    [self.commentCountView makeCornerWithCornerRadius:self.commentCountView.height / 2.0];
    self.commentCountView.hidden = YES;
}

- (void)configureContentDetailView {
    self.contentDetailView = [TopContentDetailCell create];
    self.contentDetailView.frame = CGRectMake(0, 0, [UIScreen screenWidth], 400);
    self.contentDetailView.delegate = self;
}


- (void)configureTableView {
    [self configureDatasource];
    self.tableView.tableHeaderView = self.contentDetailView;
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, [UIScreen screenWidth], 500);
    self.tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self.datasource;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TopCommentCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([TopCommentCell class])];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    MJRefreshFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(bottomRefreshing)];
    self.tableView.mj_footer = footer;
}

- (void)configureSectionHeaderView {
    self.sectionHeadView = ({
        UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor colorWithIntRed:244 green:245 blue:251 alpha:1];
        view;
    });
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor colorWithIntRed:112 green:112 blue:112 alpha:1];
    label.font = [UIFont systemFontOfSize:12];
    [self.sectionHeadView addSubview:label];
    label.text = @"全部评论";
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        make.bottom.equalTo(@0);
    }];
}


- (void)configureFootLabel {
    self.footLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithIntRed:179 green:179 blue:179 alpha:1];
        label.font = [UIFont systemFontOfSize:13];
        label.text = @"聪明如你，快来发表评论吧~";
        label;
    });
}

- (void)configureInputView {
    self.messageInputView = ({
        MessageInputView *view = [MessageInputView create];
        view.initialBottomViewBottomConstant = - 100;
        view.hidden = YES;
        view.delegate = self;
        [self.view addSubview:view];
        view;
    });
    
    [self.messageInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
    }];
}


- (void)configureDatasource {
    self.datasource = [[HeadLineDetailCommentDatasource alloc]init];
    __weak typeof(self) weakSelf = self;
    self.datasource.topCommentCellConfiguration = ^(TopCommentCell *cell, NSIndexPath *indexPath){
        cell.delegate = weakSelf;
        if (indexPath.row == weakSelf.datasource.comments.count - 5) {
            [weakSelf bottomRefreshing];
        }
    };
    
}


#pragma mark - helpMethod

- (void)tableViewEndRefreshing {
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}


- (void)bottomRefreshing {
    if (self.isRefreshing || self.isNoMoreData) {
        [self tableViewEndRefreshing];
        return;
    }
    [self requireForCommentWithStartCount:self.datasource.comments.count];
}

- (void)updateInputViewPlaceholder:(NSString *)placeholder {
    [self.messageInputView updatePlaceholder:placeholder];
}

- (void)updateInputViewPlaceholderWithName:(NSString *)name {
    NSString *placeholder = [NSString stringWithFormat:@"@%@",name];
    [self.messageInputView updatePlaceholder:placeholder];
}



- (void)pushToLoginViewController {
    BONoteVerifyLogiin *noteVerifyLoginVC = [[BONoteVerifyLogiin alloc] init];
    noteVerifyLoginVC.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:noteVerifyLoginVC];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:nil];
}



@end
