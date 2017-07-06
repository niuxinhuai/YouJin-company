//
//  BOMineViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/4.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOMineViewController.h"
#import "UIImage+UIColor.h"
#import "BOCollectView.h"
#import "BOConsumeBtn.h"
#import "BONoteVerifyLogiin.h"
#import "BOSettingVC.h"
#import "BOMessageTableVC.h"
#import "BOMineCollectTableVC.h"
#import "BOMineFansTableVC.h"
#import "BOMineAttentionTableVC.h"
#import "SignInViewController.h"
#import "BOConnectionUsTableVC.h"
#import "BOSelfDataVC.h"
#import "BOUMoneyHomepageVC.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "MineHomePageModel.h"
#import "TheDailyTaskViewController.h"
#import "ShareViewController.h"
#import "IntegralShareViewController.h"
#import "QYSDK.h"
#import "BONotFansVC.h"
#import "MineInfomationViewController.h"
#import "MineHomePageViewController.h"
#import "SubsribeViewController.h"
#import "HeadLineMainViewController.h"
#import "CollectListViewController.h"
#import "HeadView.h"
@interface BOMineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UIImageView *backImageV;
@property (nonatomic, weak) UIVisualEffectView *effectView;
@property (nonatomic, weak) UIView *coverView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *formLabel;
@property (nonatomic, weak) UIButton *settingBtn;
@property (nonatomic, weak) UIButton *informBtn;
@property (nonatomic, weak) UIButton *signInBtn;
@property (nonatomic, weak) BOCollectView *collectView;
@property (nonatomic, retain) HeadView *headView;

@property (nonatomic, weak) AFHTTPSessionManager *mgr;

@property (nonatomic, weak) MineHomePageModel *item;

@end

@implementation BOMineViewController
- (void)dealloc {
    NSLog(@"BOMineViewController");
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //02 封装任务并把任务添加到队列
        dispatch_async(queue, ^{
            NSData *imageData = UIImagePNGRepresentation(self.headView.headImageView.image);
            [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"head_image"];
            [[NSUserDefaults standardUserDefaults] synchronize];

        });
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
}

#pragma mark - 网络请求对象
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BOColor(244, 245, 247);
    self.numberSt = @"wode";
    // 设置顶部信息View
    [self setupTopMessageView];

    // 设置U币，收藏，关注，粉丝
    [self setCollectView];
    // 设置底部的tableView
    [self setupBottomTableView];

}
#pragma mark - 设置navogationBar背景图片
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self assignmentObject];
    // 加载网络数据
    [self requstNetData];
    [self.view endEditing:YES];
    
    // 设置抢红包，值得投，我的基金，我的保险
    //    [self setupConsumeMoneyView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
#pragma mark - 请求网络数据
- (void)requstNetData {
    NSString *loadString = [NSString stringWithFormat:@"%@Ucenter/userHomeInfo", BASEURL];
    NSMutableDictionary *parameters1 = [NSMutableDictionary dictionary];
    parameters1[@"sid"] = USERSid;
    parameters1[@"uid"] = USERUID;
    parameters1[@"at"] = tokenString;
    [self.mgr POST:loadString parameters:parameters1 progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] intValue] == 1) {
            MineHomePageModel *item = [MineHomePageModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self updateMessageWithItem:item];

        }else {
            self.collectView.item = nil;
            [self updateMessageWithItem:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
#pragma mark - 拿到网络数据之后，给对应的头像，名称，赋值
- (void)assignmentObject {
    if (USERSid) {
        self.nameLabel.text = USERName;
        self.signInBtn.hidden = NO;
        if (USERType) {
            self.formLabel.text = USERType;
        }
        if (USERImage) {
            UIImage *image = [UIImage imageWithData:USERImage];
            self.headView.headImageView.image = image;
        }
    }else {
        [self.headView.headImageView setImage:[UIImage imageNamed:@"img_weidenglu"]];
        self.nameLabel.text = @"立即登录";
        self.formLabel.text = @"登录后可使用更多功能";
        self.signInBtn.hidden = YES;
    }
    
    
}
#pragma mark - 设置顶部信息View
- (void)setupTopMessageView {
    UIView *topMessageView = [[UIView alloc] init];
    topMessageView.frame = CGRectMake(0, 0, BOScreenW, 158 * BOScreenH / BOPictureH);
    topMessageView.clipsToBounds = YES;
    [self.view addSubview:topMessageView];
    // 创建底部的背景图片View
    UIImageView *backImageV = [[UIImageView alloc] init];
    backImageV.contentMode = UIViewContentModeScaleAspectFill;
    _backImageV = backImageV;
    // 创建底部的毛玻璃View
    /*
     毛玻璃的样式(枚举)
     UIBlurEffectStyleExtraLight,
     UIBlurEffectStyleLight,
     UIBlurEffectStyleDark
     */
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark
                            ];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.backgroundColor = [UIColor grayColor];
    effectView.alpha = 0.3;
    _effectView = effectView;
    // 创建遮盖View
    UIView *view = [[UIView alloc] init];
    _coverView = view;
    // 创建用户的头像图片
    self.headView = [[HeadView alloc]initWithFrame:CGRectZero];
    self.headView.showBackgroundView = YES;
    [self.headView updateCompanyStatusViewHeight:13 personHeight:17];
    [self.headView updateHeadStatus:kNormal];
    // 创建用户名称的btn
    
    UILabel *nameLabel = [[UILabel alloc] init];

    _nameLabel = nameLabel;
    
    // 创建投资者类型的label
    UILabel *formLabel = [[UILabel alloc] init];
    _formLabel = formLabel;
    // 创建设置按钮
    UIButton *settingBtn = [[UIButton alloc] init];
    _settingBtn = settingBtn;
    // 创建通知btn
    UIButton *informBtn = [[UIButton alloc] init];
    _informBtn = informBtn;
    
    // 创建签到按钮
    UIButton *signInBtn = [[UIButton alloc] init];
    _signInBtn = signInBtn;
    // 设置背景图片的frame
    CGFloat backX = 0;
    CGFloat backY = 0;
    CGFloat backW = BOScreenW;
    CGFloat bockH = 158 * BOScreenH / BOPictureH;
    _backImageV.frame = CGRectMake(backX, backY, backW, bockH);
    _backImageV.backgroundColor = [UIColor colorWithIntRed:58 green:142 blue:245 alpha:1];
    // 设置毛玻璃的frame
    _effectView.frame = topMessageView.bounds;
    // 设置遮盖View
    _coverView.frame = topMessageView.bounds;
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0.1;
    // 设置头像的frame
    CGFloat pictureX = 19 * BOScreenW / BOPictureW;
    CGFloat pictureY = 65 * BOScreenH / BOPictureH;
    CGFloat pictureWH = 62 * BOScreenW / BOPictureW;
    self.headView.frame = CGRectMake(pictureX, pictureY, pictureWH, pictureWH);
    self.headView.headImageView.image = [UIImage imageNamed:@"img_weidenglu"];
    self.headView.headImageView.highlightedImage = [UIImage imageNamed:@"pic_touxiang"];
    
    // 设置名称btn的frame
    CGFloat nameX = 93 * BOScreenW / BOPictureW;
    CGFloat nameY = 77 * BOScreenH / BOPictureH;
    CGFloat nameW = 200 * BOScreenW / BOPictureW;
    CGFloat nameH = 20 * BOScreenH / BOPictureH;
    self.nameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
    self.nameLabel.textColor = [UIColor whiteColor];
    [self.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    
    // 设置投资者类型的label的frame
    CGFloat formX = 93 * BOScreenW / BOPictureW;
    CGFloat formY = 105 * BOScreenH / BOPictureH;
    CGFloat formW = 190 * BOScreenW / BOPictureW;
    CGFloat formH = 15 * BOScreenH / BOPictureH;
    _formLabel.frame = CGRectMake(formX, formY, formW, formH);
    [_formLabel setFont:[UIFont systemFontOfSize:12]];
    _formLabel.textColor = [UIColor whiteColor];
    
    // 设置设置按钮的frame
    CGFloat settingX = 300 * BOScreenW / BOPictureW;
    CGFloat settingY = 30 * BOScreenH / BOPictureH;
    CGFloat settingWH = 30 * BOScreenW / BOPictureW;
    _settingBtn.frame = CGRectMake(settingX, settingY, settingWH, settingWH);
    [_settingBtn addTarget:self action:@selector(pushSettingVC) forControlEvents:UIControlEventTouchUpInside];
    [_settingBtn setImage:[UIImage imageNamed:@"user_icon_shezhi"] forState:UIControlStateNormal];
    // 设置通知按钮的label
    CGFloat informX = 335 * BOScreenW / BOPictureW;
    CGFloat informY = 30 * BOScreenH / BOPictureH;
    CGFloat informWH = 30 * BOScreenW / BOPictureW;
    _informBtn.frame = CGRectMake(informX, informY, informWH, informWH);
    [self.informBtn addTarget:self action:@selector(lookMessageClick:) forControlEvents:UIControlEventTouchUpInside];
    [_informBtn setImage:[UIImage imageNamed:@"user_icon_tongzhi"] forState:UIControlStateNormal];
    // 设置签到按钮的frame
    CGFloat signInBtnX = 310 * BOScreenW / BOPictureW;
    CGFloat signInBtnY = 88 * BOScreenH / BOPictureH;
    CGFloat signInBtnW = 60 * BOPictureW / BOPictureW;
    CGFloat signInBtnH = 25 * BOScreenH / BOPictureH;
    _signInBtn.frame = CGRectMake(signInBtnX, signInBtnY, signInBtnW, signInBtnH);
//    _signInBtn.layer.cornerRadius = 11;
//    _signInBtn.layer.masksToBounds = YES;
//    _signInBtn.layer.borderWidth = 1;
//    _signInBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    if (USERSid) {
        _signInBtn.hidden = YES;
    }else {
        _signInBtn.hidden = NO;
    }
    [_signInBtn setImage:[UIImage imageNamed:@"user_btn_qiandao"] forState:UIControlStateNormal];
    [_signInBtn addTarget:self action:@selector(signInBtnClick) forControlEvents:UIControlEventTouchUpInside];
    // 添加用户头像,登录按钮上面盖着的Button
    UIButton *coverBtn = [[UIButton alloc] initWithFrame:CGRectMake(pictureX, 0, 250 * BOWidthRate, 158 * BOHeightRate)];
    coverBtn.layer.cornerRadius = 31 * BOWidthRate;
    coverBtn.layer.masksToBounds = YES;
    [coverBtn addTarget:self action:@selector(coverBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [topMessageView addSubview:backImageV];
 //   [topMessageView addSubview:effectView];
    [topMessageView addSubview:view];
    [topMessageView addSubview:self.headView];
    [topMessageView addSubview:nameLabel];
    [topMessageView addSubview:formLabel];
    [topMessageView addSubview:signInBtn];
    [topMessageView addSubview:informBtn];
    [topMessageView addSubview:settingBtn];
    [topMessageView addSubview:coverBtn];


}
#pragma mark - 覆盖在头像image上面按钮的点击事件
- (void)coverBtnClick {
    if (USERSid) {
        MineInfomationViewController *vc = [MineInfomationViewController create];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (!USERSid) {
        // 创建登录的控制器
        [self pushToLoginViewController];
    }
}
#pragma mark - 点击未登录按钮
- (void)ClickLogin:(UIButton *)btn {
   
}
#pragma mark - 点击设置按钮
- (void)pushSettingVC {
//    HeadLineMainViewController *vc = [HeadLineMainViewController create];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    BOSettingVC *settingVC = [[BOSettingVC alloc] init];
    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVC animated:YES];
}
#pragma mark - 点击查看消息的按钮
- (void)lookMessageClick: (UIButton *)btn {
    if (USERSid) {
        BOMessageTableVC *messageTableVC = [[BOMessageTableVC alloc] init];
        messageTableVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:messageTableVC animated:YES];
    }else {
        // 创建登录的控制器
        [self pushToLoginViewController];
    }
    
}
#pragma mark - 设置U币，收藏，关注，粉丝
- (void)setCollectView {
    BOCollectView *collectView = [[BOCollectView alloc] init];
    collectView.frame = CGRectMake(0, 158 * BOScreenH / BOPictureH, BOScreenW, 55 * BOScreenH / BOPictureH);
    collectView.backgroundColor = [UIColor whiteColor];
    self.collectView = collectView;
    [self.view addSubview:collectView];
    
    // 在collectVew上面添加四个按钮
    CGFloat btnX = 0.25 * BOScreenW;
    for (int i = 0; i < 4; i++) {
        CGFloat btnW = 0.25 * BOScreenW;
        CGFloat btnH = collectView.height;
        CGFloat btnY = 0;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * btnX, btnY, btnW, btnH)];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [collectView addSubview:btn];
    }
}
#pragma mark - U币，收藏，关注，粉丝的点击事件
-(void)btnClick:(UIButton *)btn {
    if (btn.tag == 0) {
        if (USERSid) {
            BOUMoneyHomepageVC *uMoneyHomepage = [[BOUMoneyHomepageVC alloc] init];
            uMoneyHomepage.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:uMoneyHomepage animated:YES];
        }else {
            // 创建登录的控制器
            [self pushToLoginViewController];
        }
        
    }else if (btn.tag == 1) {
        if (USERSid) {
//            BOMineCollectTableVC *mineCollectTableVC = [[BOMineCollectTableVC alloc] init];
//            mineCollectTableVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:mineCollectTableVC animated:YES];
            [self jumpPageWhenNot:@"收藏"];
        }else {
            // 创建登录的控制器
            [self pushToLoginViewController];
        }
       
    }else if (btn.tag == 3) {
        if (USERSid) {
//            BOMineFansTableVC *mineFansTableVC = [[BOMineFansTableVC alloc] init];
//            mineFansTableVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:mineFansTableVC animated:YES];
            [self pushToSubscribeViewController:NO];
        }else {
            // 创建登录的控制器
            [self pushToLoginViewController];
        }
        
    }else if (btn.tag == 2) {
        if (USERSid) {
             [self pushToSubscribeViewController:YES];
        }else {
            // 创建登录的控制器
            [self pushToLoginViewController];
        }
    }
}

#pragma mark - 未关注，没有粉丝时候跳转的界面
- (void)jumpPageWhenNot:(NSString *)titleString {
    CollectListViewController *notVC = [CollectListViewController create];
    [self.navigationController pushViewController:notVC animated:YES];
}

- (void)pushToSubscribeViewController:(BOOL)isMySubscribe {
    SubsribeViewController *vc = [SubsribeViewController createWithMySubscribe:isMySubscribe];
    [self.navigationController pushViewController:vc animated:YES];
}
//#pragma mark - 设置抢红包，值得投，我的基金，我的保险
//- (void)setupConsumeMoneyView {
//    // 创建容器View
//    UIView * consumeView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectView.frame) + 4, BOScreenW, 75 * BOScreenH / BOPictureH)];
//    consumeView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:consumeView];
//    // 添加抢红包button
//    BOConsumeBtn *redPacketBtn = [[BOConsumeBtn alloc] initWithFrame:CGRectMake(0, 0, 0.25 * BOScreenW, consumeView.height)];
//    [redPacketBtn setImage:[UIImage imageNamed:@"user_icon_qhb"] forState:UIControlStateNormal];
//    [redPacketBtn setTitle:@"抢红包" forState:UIControlStateNormal];
//    [consumeView addSubview:redPacketBtn];
//    // 添加值得投button
//    BOConsumeBtn *investmentBtn = [[BOConsumeBtn alloc] initWithFrame:CGRectMake(0.25 * BOScreenW, 0, 0.25 * BOScreenW, consumeView.height)];
//    [investmentBtn setImage:[UIImage imageNamed:@"user_icon_zdt"] forState:UIControlStateNormal];
//    [investmentBtn setTitle:@"值得投" forState:UIControlStateNormal];
//    [consumeView addSubview:investmentBtn];
//    // 添加我的基金button
//    BOConsumeBtn *fundBtn = [[BOConsumeBtn alloc] initWithFrame:CGRectMake(0.5 * BOScreenW, 0, 0.25 * BOScreenW, consumeView.height)];
//    [fundBtn setImage:[UIImage imageNamed:@"user_icon_wdjj"] forState:UIControlStateNormal];
//    [fundBtn setTitle:@"我的基金" forState:UIControlStateNormal];
//    [consumeView addSubview:fundBtn];
//    // 添加我的保险button
//    BOConsumeBtn *insuranceBtn = [[BOConsumeBtn alloc] initWithFrame:CGRectMake(0.75 * BOScreenW, 0, 0.25 * BOScreenW, consumeView.height)];
//    [insuranceBtn setImage:[UIImage imageNamed:@"user_icon_wdbx"] forState:UIControlStateNormal];
//    [insuranceBtn setTitle:@"我的保险" forState:UIControlStateNormal];
//    [consumeView addSubview:insuranceBtn];
//}
//
#pragma mark - 设置底部的tableView
- (void)setupBottomTableView {
    UITableView *bottomTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 219 * BOScreenH / BOPictureH, BOScreenW, 191 * BOScreenH / BOPictureH) style:UITableViewStylePlain];
    bottomTabView.delegate = self;
    bottomTabView.dataSource = self;
    bottomTabView.scrollEnabled = NO;
    [self.view addSubview:bottomTabView];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:return 1;
        case 1:return 3;
        default:
            break;
    }
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    // 设置cell右边的指示样式
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"个人主页";
            cell.imageView.image = [UIImage imageNamed:@"user_icon_grzy"];
        }
        
//        } else if (indexPath.row == 1) {
//            cell.textLabel.text = @"每日任务";
//            cell.imageView.image = [UIImage imageNamed:@"user_icon_mrrw"];
//        } else if (indexPath.row == 2) {
//            cell.textLabel.text = @"U币商城";
//            cell.imageView.image = [UIImage imageNamed:@"user_icon_ubsc"];
//        }

    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"联系我们";
            cell.imageView.image = [UIImage imageNamed:@"user_icon_lxwm"];
            
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"分享有金";
            cell.imageView.image = [UIImage imageNamed:@"user_icon_fxyj"];
        }  else if (indexPath.row == 2) {
            cell.textLabel.text = @"在线客服";
            cell.imageView.image = [UIImage imageNamed:@"user_icon_yjfk"];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45 * BOScreenH / BOPictureH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 6 * BOHeightRate;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 6)];
    view.backgroundColor = BOColor(244, 245, 247);
    return view;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (USERSid) {
                [self pusnMyHomePageViewController];
            }else {
                // 创建登录的控制器
                [self pushToLoginViewController];
            }
            
        }
//        else if (indexPath.row == 1){
//            if (USERSid) {
//                TheDailyTaskViewController *thedaVc = [[TheDailyTaskViewController alloc]init];
//                thedaVc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:thedaVc animated:YES];
//
//            }else {
//                // 创建登录的控制器
//                [self pushToLoginViewController];
//            }
//        }
//        else if (indexPath.row == 2) {
//            if (USERSid) {
//                IntegralShareViewController *integralVC = [[IntegralShareViewController alloc] init];
//                integralVC.hidesBottomBarWhenPushed = YES;
//                integralVC.urlString = [NSString stringWithFormat:@"%@mobile/page/integralMall.html?uid=%@&currency=%d", BASEWEBURl,USERUID,[_item.balance intValue]];
//                integralVC.titleString = @"U币商城";
//                [self.navigationController pushViewController:integralVC animated:YES];
//                
//            }else {
//                // 创建登录的控制器
//                [self pushToLoginViewController];
//            }
//
//        }
        
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            BOConnectionUsTableVC *connectionUsTableVC = [[BOConnectionUsTableVC alloc] init];
            connectionUsTableVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:connectionUsTableVC animated:YES];
        }else if (indexPath.row == 1) {
            if (USERSid) {

                ShareViewController *shareVC = [[ShareViewController alloc] init];
                shareVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:shareVC animated:YES];
            }else {
                // 创建登录的控制器
                [self pushToLoginViewController];
            }
            
        }
        else if (indexPath.row == 2) {
            [self pushToServiceController];
        }
    }
}

#pragma mark - 在线客服中返回我的
- (void)backMine {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark---签到按钮的点击事件---
- (void)signInBtnClick
{
    if (USERSid) {
        SignInViewController *signVc = [[SignInViewController alloc]init];
        signVc.hidesBottomBarWhenPushed = YES;
        signVc.numberString = self.numberSt;
        [self.navigationController pushViewController:signVc animated:YES];
    }else {
        // 创建登录的控制器
        [self pushToLoginViewController];
    }
    
}

#pragma mark - helpMethod

- (void)pushToLoginViewController {
    BONoteVerifyLogiin *noteVerifyLoginVC = [[BONoteVerifyLogiin alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:noteVerifyLoginVC];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)pusnMyHomePageViewController {
    MineHomePageViewController *vc = [MineHomePageViewController create];
    vc.uid = [USERUID intValue];
    vc.hidesBottomBarWhenPushed = YES;
    vc.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushToServiceController {
    QYSource *source = [[QYSource alloc] init];
    source.title =  @"我的";
    source.urlString = @"https://8.163.com/";
    QYSessionViewController *sessionViewController = [[QYSDK sharedSDK] sessionViewController];
    sessionViewController.sessionTitle = @"在线客服";
    sessionViewController.source = source;
    sessionViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(backMine)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    sessionViewController.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController pushViewController:sessionViewController animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
   // [self presentViewController:nav animated:YES completion:nil];
}

- (void)updateMessageWithItem:(MineHomePageModel *)item {
    if (!item) {
        [self.headView updateHeadStatus:kNormal];
        return;
    }
    if (USERType == nil && USERSid != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:item.type forKey:@"type"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.formLabel.text = item.type;
    }
    if ([item.head_image isEqualToString:@""]) {
        self.headView.headImageView.image = [UIImage imageNamed:@"pic_touxiang"];
    }else {
        [self.headView updateImageUrlString:item.head_image];
    }
    self.nameLabel.text = item.uname ? item.uname : @"立即登录";
    self.collectView.item = item;
    [self.headView updateImageUrlString:item.head_image];
    if ([item.company_vip boolValue]) {
        [self.headView updateHeadStatus:kCompanyVip];
    }else if ([item.person_vip boolValue]) {
        [self.headView updateHeadStatus:kPersonVip];
    }else {
        [self.headView updateHeadStatus:kNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
