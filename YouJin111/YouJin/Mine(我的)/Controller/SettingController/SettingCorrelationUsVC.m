//
//  SettingCorrelationUsVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "SettingCorrelationUsVC.h"
#import "NSString+Utilities.h"
#import "HelpViewController.h"
#import "BannerWebViewViewController.h"


static NSString *const ID = @"cell";
@interface SettingCorrelationUsVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *bottomTableView;

@end

@implementation SettingCorrelationUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BOColor(244, 245, 247);

    // 设置上部的View
    [self setupTopView];
    // 设置底部的tableView
    [self setupBottomTableView];
    
    [self setupBestBottomLabel];
    // 注册cell
    [self.bottomTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
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

    
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"关于我们"];
    self.navigationItem.titleView = titleView;
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 设置上部的View
- (void)setupTopView {
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topW = BOScreenW;
    CGFloat topH = 276 * BOHeightRate;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(topX, topY, topW, topH)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    // 添加图片imageView
    CGFloat pictureX = (BOScreenW - 75 * BOWidthRate) * 0.5;
    CGFloat pictureY = 81 * BOHeightRate;
    CGFloat picturew = 75 * BOWidthRate;
    CGFloat pictureH = 114 * BOHeightRate;
    UIImageView *pictureImageV = [[UIImageView alloc] initWithFrame:CGRectMake(pictureX, pictureY, picturew, pictureH)];
    pictureImageV.image = [UIImage imageNamed:@"img_youjin"];
    [topView addSubview:pictureImageV];
    // 添加label
    CGFloat versionX = 0;
    CGFloat versionY = CGRectGetMaxY(pictureImageV.frame) + 30 * BOHeightRate;
    CGFloat versionW = BOScreenW;
    CGFloat versionH = 15 * BOHeightRate;
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(versionX, versionY, versionW, versionH)];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [versionLabel setFont:[UIFont systemFontOfSize:13]];
    versionLabel.text = [NSString version];
    [topView addSubview:versionLabel];
}
#pragma mark - 设置底部的tableView
- (void)setupBottomTableView {
    CGFloat bottomX = 0;
    CGFloat bottomY = 284 * BOHeightRate;
    CGFloat bottomW = BOScreenW;
    CGFloat bottomH = 134 * BOHeightRate;
    UITableView *bottomTableView = [[UITableView alloc] initWithFrame:CGRectMake(bottomX, bottomY, bottomW, bottomH)];
    bottomTableView.dataSource = self;
    bottomTableView.delegate = self;
    bottomTableView.bounces = NO;
    self.bottomTableView = bottomTableView;
    [self.view addSubview:bottomTableView];
}

#pragma mark - 设置最底部的公司介绍label
- (void)setupBestBottomLabel {
    UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, BOScreenH - 45 * BOHeightRate - 64, BOScreenW, 15 * BOHeightRate)];
    firstLabel.text = @"copyright © 2016.All Rightis Reserved.";
    [self setupLabel:firstLabel textColor:BOColor(180, 181, 181) textfFont:12 textAligment:NSTextAlignmentCenter];
    [self.view addSubview:firstLabel];
    
    UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(firstLabel.frame), BOScreenW, 15 * BOHeightRate)];
    secondLabel.text = @"杭州柚今科技有限公司";
    [self setupLabel:secondLabel textColor:[UIColor colorWithHexString:@"#B3B3B3" alpha:1] textfFont:12 textAligment:NSTextAlignmentCenter];
    [self.view addSubview:secondLabel];
}
- (void)setupLabel:(UILabel *)label textColor:(UIColor *)textColor textfFont:(CGFloat)fontFloat textAligment:(NSInteger)textAlifnment {
    [label setFont:[UIFont systemFontOfSize:fontFloat]];
    label.textColor = textColor;
    label.textAlignment = textAlifnment;
}
#pragma mark - uitableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"去评分";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"帮助";
    }else if (indexPath.row == 2) {
        cell.textLabel.text = @"免责和隐私声明";
    }
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_goto"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45 * BOHeightRate;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@&pageNumber=0&sortOrdering=2&mt=8", APP_ID];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlStr]];
    }else if (indexPath.row == 1) {
        [self pushToHelpViewController];
    }else if (indexPath.row == 2) {
        [self pushToStatementViewController];
    }
}

#pragma mark - helpMethod

- (void)pushToHelpViewController {
    HelpViewController *helpvc = [[HelpViewController alloc] init];
    [self.navigationController pushViewController:helpvc animated:YES];
}

- (void)pushToStatementViewController {
    BannerWebViewViewController *vc = [[BannerWebViewViewController alloc]init];
    vc.url = StatementUrl;
    vc.name = @"免责和隐私声明";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
