//
//  HotTopicViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HotTopicDatasource;

@interface HotTopicViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@property (nonatomic, retain) HotTopicDatasource *datasource;
@property (nonatomic, strong) AFHTTPSessionManager *mgr;



+ (instancetype)create;


@end
