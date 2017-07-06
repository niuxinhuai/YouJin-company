//
//  BOTabBarController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/4.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOTabBarController.h"
#import "BOHomePageViewController.h"
#import "BOMineViewController.h"
#import "BODynamicViewController.h"
#import "BODepletionViewController.h"
#import "BONavigationController.h"
#import "BOMiddleButton.h"
#import "UIImage+UIColor.h"
#import "HeadLineMainViewController.h"
@interface BOTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, weak) BOMiddleButton *middleButton;
@end

@implementation BOTabBarController

// 创建中间的按钮
- (BOMiddleButton *)middleButton
{
    if (_middleButton == nil) {
        // 创建加号按钮
        BOMiddleButton *btn = [BOMiddleButton buttonWithType:UIButtonTypeCustom];
        _middleButton = btn;
        [btn setImage:[UIImage imageNamed:@"tabbar_renwu_nor"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_renwu_nor-1"] forState:UIControlStateSelected];
        // 自适应
        [btn sizeToFit];
        [btn addTarget:self action:@selector(middleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:btn];
    }
    return _middleButton;
}
- (void)middleBtnClick {
    self.middleButton.selected = YES;
    self.selectedViewController = self.childViewControllers[2];
}
// 启动时只会调用一次
+ (void)load {
    
    // 获取所有UITabBarItem的样式
    UITabBarItem *item = [UITabBarItem appearance];
    // 在刚启动类时设置文字的大小
    NSMutableDictionary *arr = [[NSMutableDictionary alloc] init];
    arr[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [item setTitleTextAttributes:arr forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
            // 添加所有的子控制器
    [self addAllChildViewController];
    // 设置所有的TabBarButton
    [self setUpAllTabBarButton];
    // 设置tabBar的毛玻璃
    [self setupBlurEffect];
}

// view即将显示的时候调用
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    if (self.selectedViewController != self.childViewControllers[2]) {
        self.middleButton.selected = NO;
    }
    self.middleButton.frame = CGRectMake(0, 0, self.tabBar.frame.size.width / 5, self.tabBar.frame.size.height);
    self.middleButton.center = CGPointMake(self.tabBar.frame.size.width * 0.5, self.tabBar.frame.size.height * 0.5);
}
#pragma mark - 设置tabBar的毛玻璃
- (void)setupBlurEffect {
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha = 0.3;
    effectView.frame = CGRectMake(0, BOScreenH - 49, BOScreenW, 49);
    effectView.userInteractionEnabled = NO;
    self.tabBar.backgroundColor = [UIColor clearColor];
    [self.tabBar addSubview:effectView];
}
#pragma mark - 添加所有的子控制器
- (void)addAllChildViewController {
    
    // 1.添加首页控制器
    BOHomePageViewController *homePageVC = [[BOHomePageViewController alloc] init];
    BONavigationController *homepageNav = [[BONavigationController alloc] initWithRootViewController:homePageVC];
    [self addChildViewController:homepageNav];
    
    // 2.添加头条控制器
    HeadLineMainViewController *headlineVC = [HeadLineMainViewController create];
    BONavigationController *headlineNav = [[BONavigationController alloc] initWithRootViewController:headlineVC];
    [self addChildViewController:headlineNav];
    // 3.添加取金控制器
    BODepletionViewController *depletionVC = [[BODepletionViewController alloc] init];
    BONavigationController *depletionNav = [[BONavigationController alloc] initWithRootViewController:depletionVC];
    [self addChildViewController:depletionNav];
    
    // 4.添加动态控制器
    BODynamicViewController *dynamicVC = [[BODynamicViewController alloc] init];
    BONavigationController *dynamicNav = [[BONavigationController alloc] initWithRootViewController:dynamicVC];
    [self addChildViewController:dynamicNav];
    
    // 5.添加我的控制器
    BOMineViewController *mineVC = [[BOMineViewController alloc] init];
    BONavigationController *minaNav = [[BONavigationController alloc] initWithRootViewController:mineVC];
    [self addChildViewController:minaNav];
}

#pragma mark - 添加所有的按钮
- (void)setUpAllTabBarButton {
    // 1.设置按钮1
    BONavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"首页";
    nav.tabBarItem.image = [UIImage imageNamed:@"tabbar_home_nor"];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_pre"];
    // 2.设置按钮2
    BONavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"头条";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabbar_toutiao_nor"];
    nav1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_toutiao_pre"];
    // 3.设置按钮3
    BONavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.enabled = NO;
//    nav2.tabBarItem.image = [UIImage imageNamed:@"tabbar_renwu_nor"];
//    nav2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_renwu_nor-1"];
    // 4.设置按钮4
    BONavigationController *nav3 = self.childViewControllers[3];
    nav3.tabBarItem.title = @"动态";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabbar_dongtai_nor"];
    nav3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_dongtai_pre"];
    // 4.添加按钮5
    BONavigationController *nav4 = self.childViewControllers[4];
    nav4.tabBarItem.title = @"我的";
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabbar_user_nor"];
    nav4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_user_pre"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (viewController != self.childViewControllers[2]) {
        self.middleButton.selected = NO;
    }
}
@end
