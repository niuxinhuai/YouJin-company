//
//  BOMineCollectTableVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOMineCollectTableVC.h"
#import "UIImage+UIColor.h"
#import "BOMineCollectCell.h"
#import "BOMineCollectNoIconCell.h"
static NSString *const ID = @"cell";
static NSString *const NOIcon = @"NOIconCell";
@interface BOMineCollectTableVC ()
@property (nonatomic, weak) UITableViewCell *cell;
@end

@implementation BOMineCollectTableVC
- (void)dealloc {
    NSLog(@"BOMineCollectTableVC");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册cell
    [self.tableView registerClass:[BOMineCollectCell class] forCellReuseIdentifier:ID];
    [self.tableView registerClass:[BOMineCollectNoIconCell class] forCellReuseIdentifier:NOIcon];
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
    
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"收藏"];
    self.navigationItem.titleView = titleView;
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        BOMineCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
        cell.iconImageV.image = [UIImage imageNamed:@"icon_gfxx"];
        NSString *nameString = @"昵称ID";
        cell.titleLabel.text = @"蚂蚁金服胡滔：一年来网贷业累计停业。。";
        cell.subTitleLabel.attributedText = [self uesrName:nameString];
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85 * BOHeightRate;
}
- (NSMutableAttributedString *)uesrName:(NSString *)name {
    NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys: [UIFont systemFontOfSize:12],NSFontAttributeName,[UIColor colorWithHexString:@"#5184C2" alpha:1],NSForegroundColorAttributeName, nil];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName, [UIColor blackColor],NSForegroundColorAttributeName, nil];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 发表于2016-06-08", name]];
    [attributeString setAttributes:dict1 range:NSMakeRange(0, name.length)];
    [attributeString setAttributes:dict2 range:NSMakeRange(name.length + 1, 13)];
    return attributeString;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    // 刷新表格
//    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}
// 修改默认的Delete的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

@end
