//
//  BOSettingVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOSettingVC.h"
#import "BONoteVerifyLogiin.h"
#import "BOSelfDataCell.h"
#import "ResetLoginPasswordVC.h"
#import "SettingCorrelationUsVC.h"
#import "BOFileManager.h"
#import "SetPayPasswordViewController.h"
#import <QYSDK.h>
#import "FileManager.h"
#import "NSString+Utilities.h"
#import "ShareManager.h"
#import "NSMutableDictionary+Utilities.h"
#import "UserSetInfoModel.h"

static NSString *const ID = @"cell";
@interface BOSettingVC ()<UITableViewDelegate, UITableViewDataSource,ShareManagerDelegate>
@property (nonatomic, weak) UIButton *notLoginBtn;

@property (nonatomic, weak) UITableView *settingTableView;

@property (nonatomic, weak) AFHTTPSessionManager *mgr;
@property (nonatomic, copy) NSString *cacheSize;
@property (nonatomic, retain) MineHomePageModel *userModel;
@property (nonatomic, retain) ShareManager *shareManager;
@property (nonatomic, retain) UserSetInfoModel *userSetInfo;

@end

@implementation BOSettingVC
- (void)dealloc {
    NSLog(@"BOSettingVC");
}


+ (instancetype)createWithUserModel:(MineHomePageModel *)model {
    BOSettingVC *vc = [[BOSettingVC alloc]init];
    vc.userModel = model;
    return vc;
}

- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _cacheSize = [NSString cacheSize:[[FileManager shareFileManager] readCacheSize]];
    
//    [BOFileManager directorySizeString:CachePath completion:^(NSString *str) {
//        
//        _cacheSize = str;
//        NSLog(@"%@", _cacheSize);
//        
//        [self.settingTableView reloadData];
//        
//    }];

    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    // 添加tableView
    [self setupTableView];
    // 添加底部的退出登录按钮
    [self setupBottomNotLoginBtn];
    
    // 注册cell
    [self.settingTableView registerClass:[BOSelfDataCell class] forCellReuseIdentifier:ID];
    if (USERSid) [self requireUserSetInfo];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // 隐藏底部的tabbar
//    self.tabBarController.tabBar.hidden = YES;
    
    // 设置navigationItem的左边按钮
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    //    self.navigationItem.leftBarButtonItem = btnItem;
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];

    
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"设置"];
    self.navigationItem.titleView = titleView;
}

#pragma mark - require

- (void)requireUserSetInfo {
    NSString *urlString = [NSString stringWithFormat:@"%@Ucenter/userSetInfo", BASEURL];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setNewObject:tokenString forKey:@"at"];
    [param setNewObject:USERSid forKey:@"sid"];
    [param setNewObject:USERUID forKey:@"uid"];
    [self.mgr POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            self.userSetInfo = [UserSetInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self.settingTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


#pragma mark - reget

- (ShareManager *)shareManager {
    if (!_shareManager) {
        _shareManager = [ShareManager shareManagerStandardWithDelegate:self];
    }
    return _shareManager;
}

#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 设置tableView
- (void)setupTableView {
    UITableView *settingTableView = [[UITableView alloc] init];
    self.settingTableView = settingTableView;
    settingTableView.dataSource = self;
    settingTableView.delegate = self;
    settingTableView.scrollEnabled = NO;
    if (USERSid) {
        settingTableView.frame = CGRectMake(0, 8 * BOHeightRate, BOScreenW, 331 * BOHeightRate);
    }else {
        settingTableView.frame = CGRectMake(0, 8 * BOHeightRate, BOScreenW, 106 * BOHeightRate);
    }
    [self.view addSubview:settingTableView];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (USERSid) {
        return 2;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (USERSid) {
        if (section == 0) {
            return 4;
        }
        else if (section == 1) {
            return 3;
        }
    }else {
        return 2;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOSelfDataCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (USERSid) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"手机号";
                cell.subTitleLabel.text = USERMobile;
            }
            else if (indexPath.row == 1) {
                cell.titleLabel.text = @"登录密码";
            }
            else if (indexPath.row == 2) {
                cell.titleLabel.text = @"支付密码";
            }
            else if (indexPath.row == 3) {
                cell.titleLabel.text = @"绑定微信";
                cell.subTitleLabel.text = (self.userSetInfo.nickname && self.userSetInfo.nickname.length > 0) ? self.userSetInfo.nickname : @"去绑定";
            }
        }
        else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"新消息通知";
                cell.subTitleLabel.text = [self getNotificationStatus];
            }
            else if (indexPath.row == 1) {
                cell.titleLabel.text = @"清理缓存";
                cell.subTitleLabel.text = _cacheSize;
            }
            else if (indexPath.row == 2) {
                cell.titleLabel.text = @"关于我们";
            }

        }
    }else {
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"清理缓存";
            cell.subTitleLabel.text = _cacheSize;
        }
        else if (indexPath.row == 1) {
            cell.titleLabel.text = @"关于我们";
        }

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (USERSid) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
               
            }
            else if (indexPath.row == 1) {
                if (firstChange == nil) {
                    // 请求网贷页其他数据
                    NSString *loadString = [NSString stringWithFormat:@"%@Ucenter/isSetPass",BASEURL];
                    NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
                    parameters1[@"at"] = tokenString;
                    parameters1[@"sid"] = USERSid;
                    parameters1[@"uid"] = USERUID;
                    parameters1[@"type"] = @"login";
                    [self.mgr POST:loadString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        if ([responseObject[@"msg"] intValue] == 1) {
                            ResetLoginPasswordVC *resetLoginPasswordVC = [[ResetLoginPasswordVC alloc] init];
                            resetLoginPasswordVC.titleString = @"重置登录密码";
                            resetLoginPasswordVC.flag = 0;
                            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"firstChange"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            [self.navigationController pushViewController:resetLoginPasswordVC animated:YES];
                            
                        }else {
                            ResetLoginPasswordVC *resetLoginPasswordVC = [[ResetLoginPasswordVC alloc] init];
                            resetLoginPasswordVC.titleString = @"设置登录密码";
                            resetLoginPasswordVC.flag = 0;
                            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"firstChange"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            [self.navigationController pushViewController:resetLoginPasswordVC animated:YES];
                        }
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        
                    }];
                    
                    
                }
                else {
                    if ([firstChange intValue] == 0) {
                        ResetLoginPasswordVC *resetLoginPasswordVC = [[ResetLoginPasswordVC alloc] init];
                        resetLoginPasswordVC.titleString = @"设置登录密码";
                        resetLoginPasswordVC.flag = 0;
                        [self.navigationController pushViewController:resetLoginPasswordVC animated:YES];
                    }else if ([firstChange intValue] == 1) {
                        ResetLoginPasswordVC *resetLoginPasswordVC = [[ResetLoginPasswordVC alloc] init];
                        resetLoginPasswordVC.titleString = @"重置登录密码";
                        resetLoginPasswordVC.flag = 0;
                        [self.navigationController pushViewController:resetLoginPasswordVC animated:YES];
                    }
                }

            }
            else if (indexPath.row == 2) {
                if (twoChange == nil) {
                    // 请求数据
                    NSString *loadString = [NSString stringWithFormat:@"%@Ucenter/isSetPass",BASEURL];
                    NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
                    parameters1[@"at"] = tokenString;
                    parameters1[@"sid"] = USERSid;
                    parameters1[@"uid"] = USERUID;
                    parameters1[@"type"] = @"pay";
                    [self.mgr POST:loadString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        if ([responseObject[@"msg"] intValue] == 1) {
                            ResetLoginPasswordVC *resetLoginPasswordVC = [[ResetLoginPasswordVC alloc] init];
                            resetLoginPasswordVC.titleString = @"重置支付密码";
                            resetLoginPasswordVC.flag = 1;
                            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"twoChange"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            [self.navigationController pushViewController:resetLoginPasswordVC animated:YES];
                            
                        }else {
                            ResetLoginPasswordVC *resetLoginPasswordVC = [[ResetLoginPasswordVC alloc] init];
                            resetLoginPasswordVC.titleString = @"设置支付密码";
                            resetLoginPasswordVC.flag = 1;
                            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"twoChange"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            [self.navigationController pushViewController:resetLoginPasswordVC animated:YES];
                        }
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        
                    }];
                    
                    
                }
                else {
                    if ([twoChange intValue] == 0) {
                        ResetLoginPasswordVC *resetLoginPasswordVC = [[ResetLoginPasswordVC alloc] init];
                        resetLoginPasswordVC.titleString = @"设置支付密码";
                        resetLoginPasswordVC.flag = 1;
                        [self.navigationController pushViewController:resetLoginPasswordVC animated:YES];
                    }else if ([twoChange intValue] == 1) {
                        ResetLoginPasswordVC *resetLoginPasswordVC = [[ResetLoginPasswordVC alloc] init];
                        resetLoginPasswordVC.titleString = @"重置支付密码";
                        resetLoginPasswordVC.flag = 1;
                        [self.navigationController pushViewController:resetLoginPasswordVC animated:YES];
                    }
                }

            }
            else if (indexPath.row == 3) {
                if (!self.userSetInfo.nickname || self.userSetInfo.nickname.length == 0) {
                    [self.shareManager loginWithPlatformType:SSDKPlatformTypeWechat];
                }
            }
        }
        else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                NSURL * url = [NSURL URLWithString:@"App-Prefs:root=NOTIFICATIONS_ID&path=com.youJinkeji360.youJin"];
                [[UIApplication sharedApplication]openURL:url];
            }
            else if (indexPath.row == 1) {
                [[SDImageCache sharedImageCache]clearMemory];
                [[FileManager shareFileManager] clearFile];
                [BOFileManager removeDirectoryPath:CachePath];
                [self toast:@"清理成功" complete:nil];
                _cacheSize = @"0k";
                [self.settingTableView reloadData];
            }
            else if (indexPath.row == 2) {
                SettingCorrelationUsVC *settingCorrelationUsVC = [[SettingCorrelationUsVC alloc] init];
                [self.navigationController pushViewController:settingCorrelationUsVC animated:YES];
            }
        }

    }else {
        if (indexPath.row == 0) {
            [BOFileManager removeDirectoryPath:CachePath];
            [self toast:@"清理成功" complete:nil];
            _cacheSize = @"0k";
            [self.settingTableView reloadData];
        }
        else if (indexPath.row == 1) {
            SettingCorrelationUsVC *settingCorrelationUsVC = [[SettingCorrelationUsVC alloc] init];
            [self.navigationController pushViewController:settingCorrelationUsVC animated:YES];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45 * BOHeightRate;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section  {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 8 * BOHeightRate)];
    view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8 * BOHeightRate;
}
#pragma mark - 设置底部的退出登录按钮
- (void)setupBottomNotLoginBtn {
    CGFloat backY;
    if (USERSid) {
        backY = 339 * BOHeightRate;
    }else {
        backY = 106 * BOHeightRate;
    }
    // 添加按钮的背景View
    CGFloat backX = 0;
    CGFloat backW = BOScreenW;
    CGFloat backH = 45 * BOHeightRate;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(backX, backY, backW, backH)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    // 添加退出登录按钮
    CGFloat notLoginX = 0;
    CGFloat notLoginY = 0;
    CGFloat notLoginW = BOScreenW;
    CGFloat notLoginH = 45 * BOHeightRate;
    UIButton *notLoginBtn = [[UIButton alloc] initWithFrame:CGRectMake(notLoginX, notLoginY, notLoginW, notLoginH)];
    self.notLoginBtn = notLoginBtn;
    if (USERSid) {
       [notLoginBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    }else {
       [notLoginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    }
    
    [notLoginBtn setTitleColor:[UIColor colorWithHexString:@"#E63240" alpha:1] forState:UIControlStateNormal];
    [notLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [notLoginBtn addTarget:self action:@selector(notLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:notLoginBtn];
}
#pragma mark - 退出登录按钮的点击事件
- (void)notLoginBtnClick: (UIButton *)btn {
    if (USERSid) {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"退出登录" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
        alertV.tag = 10;
        [alertV show];
       
    }else {
        // 创建登录的控制器
        [self pushToLoginViewController];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10) {
        if (buttonIndex == 0) {
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"uid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"un"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"mobile"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"sid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"type"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.navigationController popViewControllerAnimated:YES];
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"head_image"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [[QYSDK sharedSDK] logout:nil];

    }
}



#pragma mark - pushToOtherController

- (void)pushToLoginViewController {
    BONoteVerifyLogiin *noteVerifyLoginVC = [[BONoteVerifyLogiin alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:noteVerifyLoginVC];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - <ShareManagerDelegate>
- (void)shareManager:(ShareManager *)manager loginSuccessWithResponse:(SSDKUser *)user platform:(SSDKPlatformType)platform {
    [self requireBindingStatusWithUserInfo:user platform:platform];
}
- (void)shareManager:(ShareManager *)manager loginFailWithError:(NSError *)error platform:(SSDKPlatformType)platform {
    [self toast:@"授权失败" complete:nil];
}

- (void)requireBindingStatusWithUserInfo:(SSDKUser *)user platform:(SSDKPlatformType) platform {
    NSString *url = [NSString stringWithFormat:@"%@Common/othersLoginCallback",BASEURL];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"at"] = tokenString;
    [dictionary setNewObject:@"weixin" forKey:@"way"];
    NSDictionary *weixinDic = [self.shareManager keyValuesWithUserInfo:user platform:SSDKPlatformTypeWechat];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:weixinDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    dictionary[@"weixin_array"] = jsonString;
    [self.mgr POST:url parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"status"] && ![responseObject[@"status"] isKindOfClass:[NSNull class]]) {
           if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]){
               self.userSetInfo.nickname = user.nickname;
               [self.settingTableView reloadData];
               [self toast:@"绑定成功" complete:nil];
           }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



#pragma mark - helpMethod


- (NSString *)getNotificationStatus {
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    return UIUserNotificationTypeNone == setting.types ? @"推送已关闭" : @"推送已打开";
}

- (void)userStorageWithMessage:(NSDictionary *)message {
    [[NSUserDefaults standardUserDefaults] setObject:message[@"uid"] forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults] setObject:message[@"uname"] forKey:@"uname"];
    [[NSUserDefaults standardUserDefaults] setObject:message[@"mobile"] forKey:@"mobile"];
    [[NSUserDefaults standardUserDefaults] setObject:message[@"sid"] forKey:@"sid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
