//
//  HeadLineDetailViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/19.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseViewController.h"
#import "TopContentModel.h"
#import "HeadLineDetailCommentDatasource.h"
#import "MessageInputView.h"
#import "MineHomePageModel.h"
#import "RewardView.h"

@class TopContentDetailCell;

@interface HeadLineDetailViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UIImageView *preImageView;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (nonatomic, weak) RewardView *rewardView;
@property (weak, nonatomic) IBOutlet UIView *commentCountView;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;


@property (nonatomic, retain) TopContentDetailCell *contentDetailView;
@property (nonatomic, retain) UILabel *footLabel;
@property (nonatomic, retain) MessageInputView *messageInputView;
@property (nonatomic, retain) UIView *sectionHeadView;

@property (nonatomic, retain) NSNumber *tid;
@property (nonatomic, retain) AFHTTPSessionManager *manager;
@property (nonatomic, retain) TopContentModel *content;
@property (nonatomic, retain) HeadLineDetailCommentDatasource *datasource;
@property (nonatomic, assign) BOOL isNoMoreData;
@property (nonatomic, assign) BOOL isRefreshing;

@property (nonatomic, retain) HuifuModel *selectedModel;
@property (nonatomic, retain) MineHomePageModel *userInfo;
@property (nonatomic, assign) BOOL isCommentToContent;

+ (instancetype)headLineDetailViewControllerWithTid:(NSNumber *)tid;



@end
