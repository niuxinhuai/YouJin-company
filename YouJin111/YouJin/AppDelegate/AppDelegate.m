//
//  AppDelegate.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/4.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "AppDelegate.h"
#import "BOTabBarController.h"
#import "VersionModel.h"
#import "ScreeScrModel.h"
#import "AdvertisingWebViewController.h"
#import "HotdetailsViewController.h"
#import <MobLink/MobLink.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <SMS_SDK/SMSSDK.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <XHLaunchAd.h>//启动的广告图
#import "WXApi.h"//微信SDK头文件
#import "WeiboSDK.h"//新浪微博SDK头文件
#import "UMMobClick/MobClick.h"//导入友盟
#import "AppDelegate+Notification.h"
#import <IQKeyboardManager.h>
#import "ShareManager.h"
#import "LocationManager.h"
#import "BannerModel.h"
@interface AppDelegate ()
@property (nonatomic, weak) AFHTTPSessionManager *mgr;
@property (nonatomic ,strong)UIScrollView *startPageScrollView;//引导页的scr
@property (nonatomic ,strong)UIImageView *startPageimg;//引导页的ima
@property (nonatomic ,copy)NSString *strone;//闪屏接口提供的平台名称
@property (nonatomic, strong) BannerModel *bannerModel;
@end

@implementation AppDelegate
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"app_id"] = @"2";
        parameters[@"secret"] = @"2e1eec48cae70a2c3bd8b1f2f2e177ea";
        NSString *url = [NSString stringWithFormat:@"%@Auth/accessToken",BASEURL];
        [self.mgr POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"at"] forKey:@"access_token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
       
            
    }
    return self;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[IQKeyboardManager sharedManager]setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    // 初始化友盟
    [[LocationManager sharedLocationManagerWithDelegate:nil]start];
    [self startMobClick];
    // 初始化网易七鱼SDK
    [self configureNotification];
    [MobLink registerApp:@"1e76e0f1cc53c"];
    //初始化应用，appKey和appSecret从后台申请得
    [SMSSDK registerApp:@"1c3e95da50dc8" withSecret:@"7698bd38028fca0c28a419d120dba5e9"];
    [[ShareManager shareManagerStandardWithDelegate:nil] registShareSDK];
    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 2.创建跟控制器并设置成根控制器
    BOTabBarController *tabBarVC = [[BOTabBarController alloc] init];
    self.window.rootViewController = tabBarVC;
    //引导页
    BOOL isHasFile = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirst"] boolValue];
    if (isHasFile)
    {
        //设置数据等待时间
        [XHLaunchAd setWaitDataDuration:3];
        [self theSplashScreenFigureData];//闪屏图的接口
    }else
    {
        [self makeLaunchView];//为假表示没有文件，没有进入过主页
    }
    //3.显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark--引导页---
-(void)makeLaunchView
{
    NSArray *arr=[NSArray arrayWithObjects:@"guide_01.png",@"guide_02.png",@"guide_03.png", nil];
    if (_startPageScrollView == nil) {
        _startPageScrollView = [[UIScrollView alloc] initWithFrame:self.window.bounds];
    }
    _startPageScrollView.contentSize=CGSizeMake(self.window.frame.size.width*arr.count, self.window.frame.size.height);
    _startPageScrollView.pagingEnabled = YES;
    _startPageScrollView.showsHorizontalScrollIndicator = NO;
    _startPageScrollView.bounces = NO;
    [self.window.rootViewController.view addSubview:_startPageScrollView];

    for (int i=0; i<arr.count; i++)
    {
        _startPageimg = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.window.frame.size.width, 0, self.window.frame.size.width, self.window.frame.size.height)];
        _startPageimg.image=[UIImage imageNamed:arr[i]];
        _startPageimg.userInteractionEnabled = YES;
        [_startPageScrollView addSubview:_startPageimg];
    }
    UIButton *starButton = [UIButton buttonWithType:UIButtonTypeCustom];
    starButton.frame  =CGRectMake(190*BOScreenW/750, 1038*BOScreenH/1334, 370*BOScreenW/750, 80*BOScreenH/1334);
    [starButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_startPageimg addSubview:starButton];
}
- (void)startButtonClick
{
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isFirst"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_startPageScrollView  removeFromSuperview];//将scrollView移除
    _startPageScrollView = nil;
}
#pragma mark---闪屏图(广告图)接口---
- (void)theSplashScreenFigureData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    [manager POST:[NSString stringWithFormat:@"%@Common/openImage",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"] && ![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            self.bannerModel = [BannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]].firstObject;
            XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration defaultConfiguration];
            imageAdconfiguration.duration = 5;
            //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
            imageAdconfiguration.imageNameOrURLString = self.bannerModel.img_url;
            imageAdconfiguration.openURLString = self.bannerModel.url;
            [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
}

//广告点击事件 回调
- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenURLString:(NSString *)openURLString;
{
    if (openURLString) {
        if ([self.bannerModel.go_type integerValue] == 1) {
            
        }else if ([self.bannerModel.go_type integerValue] == 2){
            AdvertisingWebViewController *VC = [[AdvertisingWebViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            NSArray *newArray = [self.bannerModel.url componentsSeparatedByString:@"|"];
            if (newArray.count == 2) {
                VC.name = newArray[0];
                VC.URLString = newArray[1];
            }else {
                VC.URLString = self.bannerModel.url;
            }
            BOTabBarController *tabVc = (BOTabBarController *)self.window.rootViewController;
            UINavigationController *nav = tabVc.childViewControllers[0];
            [nav pushViewController:VC animated:NO];
        }else if ([self.bannerModel.go_type integerValue] == 3) {
            HotdetailsViewController *hotVc = [[HotdetailsViewController alloc]init];
            hotVc.hidesBottomBarWhenPushed = YES;
            hotVc.ptid = self.bannerModel.ID;
            BOTabBarController *tabVc = (BOTabBarController *)self.window.rootViewController;
            UINavigationController *nav = tabVc.childViewControllers[0];
            [nav pushViewController:hotVc animated:NO];
        }
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self setBadgeNumberWhenEnterBackground];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark---闪屏图接口---
//#pragma mark---版本接口---
//- (void)versionOfTheInterfaceData
//{
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"at"] = tokenString;
//    parameters[@"app_id"] = @"99a86007530e83034a5c3bc07d8e23b8";
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager POST:[NSString stringWithFormat:@"%@App/version",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if ([responseObject[@"r"] integerValue] == 1)
//        {
//           VersionModel *model = [VersionModel mj_objectWithKeyValues:responseObject[@"data"]];
//        }
//        else
//        {
//            NSLog(@"信息描述%@",responseObject[@"msg"]);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"请求失败%@",error);
//    }];
//}

- (void)startMobClick {
    UMConfigInstance.appKey = @"58a52b1a677baa50b80023c3";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    [MobClick setEncryptEnabled:YES];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
}

#pragma mark - reget

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager bo_manager];
    }
    return _manager;
}

- (void)requireQNToken {
    [self.manager POST:QNTokenUrl parameters:[NSDictionary dictionary] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"token"]) {
            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"token"] forKey:@"QNToken"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


@end
