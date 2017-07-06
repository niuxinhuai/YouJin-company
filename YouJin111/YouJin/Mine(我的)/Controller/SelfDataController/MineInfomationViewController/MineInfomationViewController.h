//
//  MineInfomationViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/8.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseViewController.h"
#import "SelfDataItem.h"
#import <QiniuSDK.h>

@interface MineInfomationViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *placeholdLabel;
@property (weak, nonatomic) IBOutlet UITextView *flagTextView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@property (nonatomic, strong) AFHTTPSessionManager *mgr;
@property (nonatomic, strong) QNUploadManager *upManager;
@property (nonatomic, strong) SelfDataItem *item;
@property (nonatomic, strong) SelfDataItem *oldItem;


+ (instancetype)create;



@end
