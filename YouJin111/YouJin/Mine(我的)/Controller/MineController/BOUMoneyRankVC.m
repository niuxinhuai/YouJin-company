//
//  BOUMoneyRankVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOUMoneyRankVC.h"
#import "BOUMoneyRankCell.h"
#import "UMoneyRankMeItem.h"
#import "UMoneyUserRankItem.h"
static NSString *const ID = @"cell";
@interface BOUMoneyRankVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *bottomTableView;
@property (nonatomic, retain) UILabel *tableFootLable;

@property (nonatomic, weak) AFHTTPSessionManager *mgr;

/**头像的imageView*/
@property (nonatomic, weak) UIImageView *iconImageV;

/**我的排名*/
@property (nonatomic, weak) UILabel *rankNumLabel;

/**累计U币数量的label*/
@property (nonatomic, weak) UILabel *sumNumLabel;

/**用户昵称的label*/
@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, strong) UMoneyRankMeItem *meItem;

/**记录排名的可变数组*/
@property (nonatomic, strong) NSMutableArray *dataArrayM;
@end

@implementation BOUMoneyRankVC
#pragma mark - 网络请求对象
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}
- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        _dataArrayM = [NSMutableArray array];
    }
    return _dataArrayM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BOColor(244, 245, 247);
    [self loadNetData];
    // 设置底部的tableView
    [self setupBottomTableView];
    // 设置上部的View
    [self setupTopView];
    [self configureTableFootLabel];
    
    // 注册cell
    [self.bottomTableView registerClass:[BOUMoneyRankCell class] forCellReuseIdentifier:ID];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:0.01] WithAlpha:1];
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
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"U币排行榜"];
    self.navigationItem.titleView = titleView;
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}

// 添加上部的View
- (void)setupTopView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 205 * BOHeightRate)];
    topView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topView];
    // 添加背景imageView
    UIImageView *backImageV = [[UIImageView alloc] initWithFrame:topView.bounds];
    backImageV.image = [UIImage imageNamed:@"img_ubphbg"];
    [topView addSubview:backImageV];
    // 添加头像imageView
    CGFloat iconX = (BOScreenW - 70 * BOWidthRate) * 0.5;
    CGFloat iconY = 76 * BOHeightRate;
    CGFloat iconWH = 70 * BOWidthRate;
    UIImageView *iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconWH, iconWH)];
    self.iconImageV = iconImageV;
    iconImageV.backgroundColor = [UIColor clearColor];
    iconImageV.image = [UIImage imageNamed:@"pic_touxiang"];
    iconImageV.layer.cornerRadius = 35 * BOWidthRate;
    iconImageV.layer.masksToBounds = YES;
    iconImageV.layer.borderColor = [UIColor whiteColor].CGColor;
    iconImageV.layer.borderWidth = 2;
    [topView addSubview:iconImageV];
    // 添加名称label
    CGFloat nameX = 0;
    CGFloat nameY = CGRectGetMaxY(iconImageV.frame) + 15 * BOHeightRate;
    CGFloat nameW = BOScreenW;
    CGFloat nameH = 15 * BOHeightRate;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
    self.nameLabel = nameLabel;
    nameLabel.text = @"黄金大梨子";
    nameLabel.textColor = [UIColor colorWithHexString:@"#FEFEFE" alpha:1];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [nameLabel setFont:[UIFont systemFontOfSize:13]];
    [topView addSubview:nameLabel];
    
    // 添加我的排名label
    CGFloat rankX = 0;
    CGFloat rankY = 93 * BOHeightRate;
    CGFloat rankW = iconX;
    CGFloat rankH = 15 * BOHeightRate;
    UILabel *rankLabel= [[UILabel alloc] initWithFrame:CGRectMake(rankX, rankY, rankW, rankH)];
    rankLabel.text = @"我的排名";
    rankLabel.textColor = [UIColor colorWithHexString:@"#C2D8F2" alpha:1];
    rankLabel.textAlignment = NSTextAlignmentCenter;
    [rankLabel setFont:[UIFont systemFontOfSize:13]];
    [topView addSubview:rankLabel];
    // 添加我的排名数字label
    CGFloat rankNumX = 0;
    CGFloat rankNumY = CGRectGetMaxY(rankLabel.frame) + 13 * BOHeightRate;
    CGFloat rankNumW = iconX;
    CGFloat rankNumH = 20 * BOHeightRate;
    UILabel *rankNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(rankNumX, rankNumY, rankNumW, rankNumH)];
    self.rankNumLabel = rankNumLabel;
    rankNumLabel.text = @"300000";
    rankNumLabel.textColor = [UIColor colorWithHexString:@"#FEFEFE" alpha:1];
    rankNumLabel.textAlignment = NSTextAlignmentCenter;
    [rankNumLabel setFont:[UIFont systemFontOfSize:20]];
    [topView addSubview:rankNumLabel];
    // 添加累计U币的label
    CGFloat sumX = CGRectGetMaxX(iconImageV.frame);
    CGFloat sumY = rankY;
    CGFloat sumW = iconX;
    CGFloat sumH = 15 * BOHeightRate;
    UILabel *sumLabel = [[UILabel alloc] initWithFrame:CGRectMake(sumX, sumY, sumW, sumH)];
    sumLabel.text = @"累计U币";
    sumLabel.textColor = [UIColor colorWithHexString:@"#C2D8F2" alpha:1];
    sumLabel.textAlignment = NSTextAlignmentCenter;
    [sumLabel setFont:[UIFont systemFontOfSize:13]];
    [topView addSubview:sumLabel];
    // 添加累计U币数量的label
    CGFloat sumNumX = sumX;
    CGFloat sumNumY = CGRectGetMaxY(sumLabel.frame) + 13 * BOHeightRate;
    CGFloat sumNumW = iconX;
    CGFloat sumNUmH = 20 *  BOHeightRate;
    UILabel *sumNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(sumNumX, sumNumY, sumNumW, sumNUmH)];
    self.sumNumLabel = sumNumLabel;
    sumNumLabel.text = @"1000万";
    sumNumLabel.textColor = [UIColor colorWithHexString:@"#FEFEFE" alpha:1];
    sumNumLabel.textAlignment = NSTextAlignmentCenter;
    [sumNumLabel setFont:[UIFont systemFontOfSize:20]];
    [topView addSubview:sumNumLabel];
}

- (void)configureTableFootLabel {
    self.tableFootLable = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen screenWidth], 30)];
        label.text = @"排行榜只统计前30名用户";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithIntRed:51 green:51 blue:51 alpha:1];
        label.font = [UIFont systemFontOfSize:14];
        label;
    });
    self.bottomTableView.tableFooterView = self.tableFootLable;
}

#pragma mark - 设置底部的tableView
- (void)setupBottomTableView {
    CGFloat bottomX = 0;
    CGFloat bottomY = 166.5 * BOHeightRate;
    CGFloat bottomH = BOScreenH - 166.5 * BOHeightRate;
    CGFloat bottomW = BOScreenW;
    UITableView *bottomTableView = [[UITableView alloc] initWithFrame:CGRectMake(bottomX, bottomY, bottomW, bottomH) style:UITableViewStylePlain];
    bottomTableView.contentInset = UIEdgeInsetsMake(-38.5 * BOHeightRate, 0, 0, 0);
    bottomTableView.dataSource = self;
    bottomTableView.delegate = self;
    bottomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.bottomTableView = bottomTableView;
    bottomTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:bottomTableView];
}
#pragma mark - UitableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrayM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOUMoneyRankCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.rankNumLabel.hidden = YES;
        cell.rankIcon.hidden = NO;
        cell.rankIcon.image = [UIImage imageNamed:@"icon_first"];
    }else if (indexPath.row == 1) {
        cell.rankNumLabel.hidden = YES;
        cell.rankIcon.hidden = NO;
        cell.rankIcon.image = [UIImage imageNamed:@"icon_second"];
    }else if (indexPath.row == 2) {
        cell.rankNumLabel.hidden = YES;
        cell.rankIcon.hidden = NO;
        cell.rankIcon.image = [UIImage imageNamed:@"icon_third"];
    }else {
        cell.rankNumLabel.hidden = NO;
        cell.rankIcon.hidden = YES;
        cell.rankNumLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row + 1];
    }

    UMoneyUserRankItem *item = self.dataArrayM[indexPath.row];
    cell.item = item;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65 * BOHeightRate;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 49;
//}
//
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    return self.tableFootLable;
//}
#pragma mark - 加载最新数据
- (void)loadNetData {
    NSString *url = [NSString stringWithFormat:@"%@Ucenter/getUbiBillboard",BASEURL];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"at"] = tokenString;
    dictionary[@"sid"] = USERSid;
    dictionary[@"uid"] = USERUID;
    dictionary[@"start"] = @"0";
    dictionary[@"limit"] = @"30";
    [self.mgr POST:url parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.meItem = [UMoneyRankMeItem mj_objectWithKeyValues:responseObject[@"me"]];
        self.dataArrayM = [UMoneyUserRankItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.bottomTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 加载更多数据
- (void)loadMoreData {
    
}

#pragma mark - 重写meItem的set方法
- (void)setMeItem:(UMoneyRankMeItem *)meItem {
    _meItem = meItem;
    if (meItem.head_image == nil) {
        self.iconImageV.image = [UIImage imageNamed:@"pic_touxiang"];
    }else {
       [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:meItem.head_image] placeholderImage:[UIImage imageNamed:@"pic_touxiang"]];
    }
    
    self.nameLabel.text = meItem.uname;
    self.rankNumLabel.text = meItem.paiming;
    if ([meItem.v_tot_get_ubi floatValue] / 10000 > 1) {
        self.sumNumLabel.text = [NSString stringWithFormat:@"%.2f万",[meItem.v_tot_get_ubi floatValue] / 10000];
    }else {
        self.sumNumLabel.text = [NSString stringWithFormat:@"%d",[meItem.v_tot_get_ubi intValue]];
    }
    
}
@end
