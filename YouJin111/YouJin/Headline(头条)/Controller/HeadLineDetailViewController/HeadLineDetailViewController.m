//
//  HeadLineDetailViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/19.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineDetailViewController.h"
#import "HeadLineDetailViewController+Configuration.h"
#import "HeadLineDetailViewController+LogicalFlow.h"
#import "UIImage+UIColor.h"
#import <MobLink/UIViewController+MLSDKRestore.h>
#import <MobLink/MLSDKScene.h>
#import <MobLink/MobLink.h>

@interface HeadLineDetailViewController ()

@property (nonatomic, strong) MLSDKScene *scene;
@property (nonatomic, strong) NSString *mobid;

@end

@implementation HeadLineDetailViewController

+ (instancetype)headLineDetailViewControllerWithTid:(NSNumber *)tid {
    HeadLineDetailViewController *vc = [HeadLineDetailViewController create];
    vc.tid = tid;
    return vc;
}

+ (instancetype)create {
    HeadLineDetailViewController *vc = [[HeadLineDetailViewController alloc]initWithNibName:@"HeadLineDetailViewController" bundle:nil];
    return vc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    if (USERSid) [self requireForUserInfo];
    [self requireForContentDetailWithTid:self.tid];
    [self requireForCommentWithStartCount:0];
    [self requireForOutType];
    [self requireForStarType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - actionMethod

- (IBAction)returnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)shareAction:(UIButton *)sender {
    ShareManager *manager = [ShareManager shareManagerStandardWithDelegate:nil];
    [manager shareInView:self.view text:self.content.no_tag image:[UIImage shareImageWithUrl:@""] url:[TopDetailShareUrl stringByAppendingString:[NSString stringWithFormat:@"tid=%@",self.content.tid]] title:self.content.title objid:@1];
}
- (IBAction)collectIAction:(UIButton *)sender {
    sender.enabled = NO;
    [self collectContent:sender.selected];
}
- (IBAction)commentAction:(UIButton *)sender {
    if (self.datasource.comments.count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}


#pragma mark - reget

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager bo_manager];
    }
    return _manager;
}



#pragma mark - moblink

+ (NSString *)MLSDKPath {
    return @"/headLineDetail";
}

- (instancetype)initWithMobLinkScene:(MLSDKScene *)scene
{
    if (self = [super initWithNibName:@"HeadLineDetailViewController" bundle:nil])
    {
        self.scene = scene;
    }
    return self;
}

- (void)getMobId
{
    // 构造自定义参数（可选）
    NSMutableDictionary *customParams = [NSMutableDictionary dictionary];
    customParams[@"key1"] = @"value1";
    customParams[@"key2"] = @"value2";
    // 根据路径、来源以及自定义参数构造scene
    MLSDKScene *scene = [[MLSDKScene alloc] initWithMLSDKPath:@"/headLineDetail" source:@"HeadLineDetailViewController" params:customParams];
    // 请求MobId
    __weak typeof(self) weakSelf = self;
    [MobLink getMobId:scene result:^(NSString *mobId) {
        weakSelf.mobid = mobId;
        NSString *msg = mobId == nil ? @"获取Mobid失败" : @"获取Mobid成功";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

@end
