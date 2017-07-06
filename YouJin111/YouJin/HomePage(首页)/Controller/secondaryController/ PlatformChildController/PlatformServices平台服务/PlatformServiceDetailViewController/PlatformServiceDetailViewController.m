//
//  PlatformServiceDetailViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformServiceDetailViewController.h"
#import "PlatformServiceDetailViewController+Configuration.h"
#import "WriteCommentsOnViewController.h"
#import "ShareManager.h"

@interface PlatformServiceDetailViewController ()

@end

@implementation PlatformServiceDetailViewController

+ (instancetype)createWithSvid:(NSNumber *)svid {
    PlatformServiceDetailViewController *vc = [PlatformServiceDetailViewController create];
    vc.svid = svid;
    return vc;
}

+ (instancetype)create {
    PlatformServiceDetailViewController *vc = [[PlatformServiceDetailViewController alloc]initWithNibName:@"PlatformServiceDetailViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    [self requireForPlatSeviceDetailWithSvid:self.svid];
    [self requireForPlatSeviceDetailCommentList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - reget

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager bo_manager];
    }
    return _manager;
}

#pragma mark - actionMethod

- (IBAction)returnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//- (IBAction)writeCommentAction:(UIButton *)sender {
//    if (USERUID) {
//        [self pushToWriteCommentsOnViewController];
//    } else {
//        [self pushToLoginViewController];
//    }
//}

- (IBAction)shareAction:(UIButton *)sender {
    NSString *titleString = [NSString stringWithFormat:@"%@欢迎你!",self.seviceDetail.pname];
    NSString *detailString = [NSString stringWithFormat:@"%@入驻有金！带来丰厚的新手福利，更全更新的平台档案就在有金APP。",self.seviceDetail.pname];
    ShareManager *manager = [ShareManager shareManagerStandardWithDelegate:nil];
    [manager shareInView:self.view text:detailString image:[UIImage shareImageWithUrl:self.seviceDetail.logo] url:[NSString stringWithFormat:@"%@mobile/page/platformDetail.html?ptid=%@",BASEWEBURl,self.seviceDetail.svid] title:titleString objid:nil];
}

#pragma mark - helpMethod




@end
