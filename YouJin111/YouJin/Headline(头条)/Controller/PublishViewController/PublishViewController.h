//
//  PublishViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseViewController.h"
#import "PublishDatasource.h"
#import "ContentPublishModel.h"
#import "ImageUploadManager.h"

@class PublishTableHeaderView;

@interface PublishViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *keyBoardBar;
@property (weak, nonatomic) IBOutlet UIButton *originalButton;
@property (weak, nonatomic) IBOutlet UIPickerView *platePickView;
@property (weak, nonatomic) IBOutlet UIView *plateView;
@property (weak, nonatomic) IBOutlet UIButton *complishButton;

@property (strong, nonatomic) PublishTableHeaderView *headerView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyBoardBottomToSuperBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *platePickBottomToSuperBottom;


@property (nonatomic, retain) PublishDatasource *datasource;
@property (nonatomic, retain) NSArray *plates;
@property (nonatomic, retain) ContentPublishModel *contentModel;
@property (nonatomic, retain) AFHTTPSessionManager *manager;
@property (nonatomic, retain) ImageUploadManager *imageUploadManager;

@end
