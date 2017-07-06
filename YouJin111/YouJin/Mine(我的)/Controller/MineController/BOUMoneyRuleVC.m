//
//  BOUMoneyRuleVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOUMoneyRuleVC.h"
#import "BOUMoneyRuleCell.h"

static NSString *const ID = @"cell";
@interface BOUMoneyRuleVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation BOUMoneyRuleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BOColor(244, 245, 247);

    // 设置顶部的View
    [self setupTopView];
    // 设置tableView
    [self setupTableView];
    [self.tableView registerClass:[BOUMoneyRuleCell class] forCellReuseIdentifier:ID];
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
    
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"U币规则"];
    self.navigationItem.titleView = titleView;
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 添加上部的View
- (void)setupTopView {
    // 添加上部的View
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topW = BOScreenW;
    CGFloat topH = 40 * BOHeightRate;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(topX, topY, topW, topH)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    // 添加编号label
    CGFloat numberX = 15 * BOWidthRate;
    CGFloat numberY = 12.5 * BOHeightRate;
    CGFloat numberW = 30 * BOWidthRate;
    CGFloat numberH = 15 * BOHeightRate;
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(numberX, numberY, numberW, numberH)];
    numberLabel.text = @"编号";
    [numberLabel setFont:[UIFont systemFontOfSize:14]];
    [numberLabel setTextColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
    [topView addSubview:numberLabel];
    // 添加项目的label
    CGFloat projectX = 75 * BOWidthRate;
    CGFloat projectY = numberY;
    CGFloat projectW = numberW;
    CGFloat projectH = numberH;
    UILabel *projectLabel = [[UILabel alloc] initWithFrame:CGRectMake(projectX, projectY, projectW, projectH)];
    projectLabel.text = @"项目";
    [projectLabel setFont:[UIFont systemFontOfSize:14]];
    [projectLabel setTextColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
    [topView addSubview:projectLabel];
    // 添加U币数的label
    CGFloat uMoneyX = 210 * BOWidthRate;
    CGFloat uMoneyY = numberY;
    CGFloat uMoneyW = 50 * BOWidthRate;
    CGFloat uMoneyH = numberH;
    UILabel *uMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(uMoneyX, uMoneyY, uMoneyW, uMoneyH)];
    uMoneyLabel.text = @"U币数";
    [uMoneyLabel setFont:[UIFont systemFontOfSize:14]];
    [uMoneyLabel setTextColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
    [topView addSubview:uMoneyLabel];
    // 添加每日上限的label
    CGFloat limitX = 300 * BOWidthRate;
    CGFloat limitY = numberY;
    CGFloat limitW = 60 * BOWidthRate;
    CGFloat limitH = numberH;
    UILabel *limitLabel = [[UILabel alloc] initWithFrame:CGRectMake(limitX, limitY, limitW, limitH)];
    limitLabel.text = @"每日上限";
    [limitLabel setFont:[UIFont systemFontOfSize:14]];
    [limitLabel setTextColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
    [topView addSubview:limitLabel];
}
#pragma mark - 添加tableView
- (void)setupTableView {
    CGFloat tableX = 0;
    CGFloat tableY = 40 * BOHeightRate;
    CGFloat tableW = BOScreenW;
    CGFloat tableH = self.view.height - 40 * BOHeightRate;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableX, tableY, tableW, tableH) style:UITableViewStylePlain];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
}
#pragma mark - uitableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        return 2;
    }else if (section == 2) {
        return 7;
    }else if (section == 3) {
        return 5;
    }else if (section == 4) {
        return 2;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOUMoneyRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.numberLabel.text = @"1";
            cell.projectLabel.text = @"注册账号";
            cell.uMoneyLabel.text = @"100";
            cell.limitLabel.text = @"仅一次";
        }else if (indexPath.row == 1) {
            cell.numberLabel.text = @"2";
            cell.projectLabel.text = @"上传头像";
            cell.uMoneyLabel.text = @"10";
            cell.limitLabel.text = @"仅一次";
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.numberLabel.text = @"3";
            cell.projectLabel.text = @"每日签到";
            cell.uMoneyLabel.text = @"50-300";
            cell.limitLabel.text = @"300";
        }else if (indexPath.row == 1) {
            cell.numberLabel.text = @"4";
            cell.projectLabel.text = @"阅读签到";
            cell.uMoneyLabel.text = @"不限";
            cell.limitLabel.text = @"不限";
        }
    }
    else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.numberLabel.text = @"5";
            cell.projectLabel.text = @"发表点评";
            cell.uMoneyLabel.text = @"100";
            cell.limitLabel.text = @"500";
        }else if (indexPath.row == 1) {
            cell.numberLabel.text = @"6";
            cell.projectLabel.text = @"发表头条";
            cell.uMoneyLabel.text = @"500";
            cell.limitLabel.text = @"500";
        }else if (indexPath.row == 2) {
            cell.numberLabel.text = @"7";
            cell.projectLabel.text = @"发表动态";
            cell.uMoneyLabel.text = @"100";
            cell.limitLabel.text = @"100";
        }else if (indexPath.row == 3) {
            cell.numberLabel.text = @"8";
            cell.projectLabel.text = @"发表评论";
            cell.uMoneyLabel.text = @"20";
            cell.limitLabel.text = @"100";
        }else if (indexPath.row == 4) {
            cell.numberLabel.text = @"9";
            cell.projectLabel.text = @"点评精华";
            cell.uMoneyLabel.text = @"200";
            cell.limitLabel.text = @"不限";
        }else if (indexPath.row == 5) {
            cell.numberLabel.text = @"10";
            cell.projectLabel.text = @"头条被置顶";
            cell.uMoneyLabel.text = @"200";
            cell.limitLabel.text = @"不限";
        }else if (indexPath.row == 6) {
            cell.uMoneyLabel.text = @"";
            cell.numberLabel.text = @"";
            cell.projectLabel.text = @"";
            cell.limitLabel.text = @"";
            cell.textLabel.text = @"注意事项:删除帖子,所获U币将被扣除";
            [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
            cell.textLabel.textColor = [UIColor colorWithHexString:@"#F35833" alpha:1];
        }
    }
    else if (indexPath.section == 3 ) {
        if (indexPath.row == 0) {
            cell.numberLabel.text = @"11";
            cell.projectLabel.text = @"分享头条";
            cell.uMoneyLabel.text = @"10";
            cell.limitLabel.text = @"10";
        }
        else if (indexPath.row == 1) {
            cell.numberLabel.text = @"12";
            cell.projectLabel.text = @"分享车贷排行榜";
            cell.uMoneyLabel.text = @"10";
            cell.limitLabel.text = @"10";
        }
        else if (indexPath.row == 2) {
            cell.numberLabel.text = @"13";
            cell.projectLabel.text = @"分享活期排行榜";
            cell.uMoneyLabel.text = @"10";
            cell.limitLabel.text = @"10";
        }
        else if (indexPath.row == 3) {
            cell.numberLabel.text = @"14";
            cell.projectLabel.text = @"分享有金评级";
            cell.uMoneyLabel.text = @"10";
            cell.limitLabel.text = @"10";
        }
        else if (indexPath.row == 4) {
            cell.numberLabel.text = @"15";
            cell.projectLabel.text = @"分享示范基金";
            cell.uMoneyLabel.text = @"10";
            cell.limitLabel.text = @"10";
        }
        
    }
    else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            cell.numberLabel.text = @"16";
            cell.projectLabel.text = @"邀请好友";
            cell.uMoneyLabel.text = @"1000";
            cell.limitLabel.text = @"不限";
        }else if (indexPath.row == 1) {
            cell.numberLabel.text = @"17";
            cell.projectLabel.text = @"取金活动";
            cell.uMoneyLabel.text = @"不限";
            cell.limitLabel.text = @"不限";
        }
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 35 * BOHeightRate)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15 * BOWidthRate, 10 * BOHeightRate, 100 * BOWidthRate, 15 * BOHeightRate)];
    label.textColor = [UIColor colorWithHexString:@"#4697FB" alpha:1];
    [label setFont:[UIFont systemFontOfSize:14]];
    if(section == 0) {
        label.text = @"完善个人信息";
    }else if (section == 1) {
        label.text = @"签到赚u币";
    }else if (section == 2) {
        label.text = @"帖子相关";
    }else if (section == 3) {
        label.text = @"分享相关";
    }else if (section == 4) {
        label.text = @"其他活动";
    }
    headView.backgroundColor = BOColor(244, 245, 247);
    [headView addSubview:label];
    return headView;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35 * BOHeightRate;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40 * BOHeightRate;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
@end
