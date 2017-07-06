//
//  NewIndustryDataViewController+Configuration.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NewIndustryDataViewController+Configuration.h"
#import "NSDate+Utilities.h"

@implementation NewIndustryDataViewController (Configuration)

- (void)configureViews {
    self.timeKey = @"yesterday";
    [self configureNav];
    [self configureTopBar];
    [self configureSectionBar];
    [self addBaseScrollView];
    [self addLeftTableView];
    [self addRightScrollView];
    [self addRightTableView];
}

- (void)addBaseScrollView {
    self.baseScrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 95, [UIScreen screenWidth], [UIScreen screenHeight] - 159)];
        scrollView.backgroundColor = [UIColor colorWithIntRed:245 green:245 blue:247 alpha:1];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.contentSize = CGSizeMake([UIScreen screenWidth], [UIScreen screenHeight] - 159);
        scrollView.delegate = self;
        [self.view insertSubview:scrollView belowSubview:self.sectionContainer];
        scrollView;
    });
    [self configureBaseScrollViewRefresh];
    [self configureBaseScrollViewLoadMore];
}

- (void)configureBaseScrollViewRefresh {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(topRefreshing)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    header.automaticallyChangeAlpha = YES;
    self.baseScrollView.mj_header = header;
}

- (void)configureBaseScrollViewLoadMore {
    MJRefreshFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(bottomRefreshing)];
    self.baseScrollView.mj_footer = footer;
}


- (void)addRightScrollView {
    self.rightScrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(85, 0, [UIScreen screenWidth] - 85, [UIScreen screenHeight] - 159)];
        scrollView.backgroundColor = [UIColor colorWithIntRed:245 green:245 blue:247 alpha:1];
        scrollView.bounces = NO;
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.contentSize = CGSizeMake(480, [UIScreen screenHeight] - 159);
        [self.baseScrollView addSubview:scrollView];
        scrollView;
    });
}

- (void)addLeftTableView {
    self.leftTableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.frame = CGRectMake(0, 0, 85, [UIScreen screenHeight] - 159);
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.clipsToBounds = NO;
        tableView.scrollEnabled = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerNib:[UINib nibWithNibName:@"DayDataTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([DayDataTableViewCell class])];
        [self.baseScrollView addSubview:tableView];
        tableView;
    });
}

- (void)addRightTableView {
    self.rightTableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.frame = CGRectMake(0, 0, 480, [UIScreen screenHeight] - 159);
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.clipsToBounds = NO;
        tableView.scrollEnabled = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerNib:[UINib nibWithNibName:@"RightDayDataTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([RightDayDataTableViewCell class])];
        [self.rightScrollView addSubview:tableView];
        tableView;
    });
}


- (void)configureTopBar {
    [self.topBar updateLineViewWidth:90];
    [self.topBar updateTitles:@[@"昨日数据", @"7日数据", @"30日数据"]];
    self.topBar.delegate = self;
    [self.view bringSubviewToFront:self.topBar];
    [self.topBar makeShadowWithShadowColor:[UIColor colorWithIntRed:223 green:227 blue:230 alpha:1] shadowOffset:CGSizeMake(0, 1) shadowRadius:1 shadowOpacity:1 shadowPath:[UIBezierPath bezierPathWithRect:self.topBar.bounds].CGPath];
}

- (void)configureSectionBar {
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"平台" isCanSelected:NO]];
    self.leftSectionBar.layout.itemSize = CGSizeMake(85, 45);
    [self.leftSectionBar updateTitles:array];
    [self.sectionContainer bringSubviewToFront:self.leftSectionBar];
    self.rightSectionBar.layout.itemSize = CGSizeMake(80, 45);
    [self.rightSectionBar updateTitles:[self rightSectionTitles]];
}


- (void)configureNav {
    
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    //设置titleView
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor clearColor];
    contentView.frame = CGRectMake(0, 0, 400*BOScreenW/750, 60*BOScreenH/1334);
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 400*BOScreenW/750, 30*BOScreenH/1334)];
    topLabel.text = @"行业数据";
    topLabel.textColor = [UIColor whiteColor];
    [topLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    topLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:topLabel];
    UILabel *belowLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40*BOScreenH/1334, 400*BOScreenW/750, 20*BOScreenH/1334)];
    belowLabel.text = [[NSDate dateDescriotion] stringByAppendingString:@"更新"];
    belowLabel.textColor = [UIColor colorWithHexString:@"#ffffff" alpha:0.8];
    [belowLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    belowLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:belowLabel];
    self.navigationItem.titleView = contentView;
}

- (NSArray *)rightSectionTitles {
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"综合利率" isCanSelected:YES]];
    [array addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"资金净流入" isCanSelected:YES]];
    [array addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"投资人数" isCanSelected:YES]];
    [array addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"借款人数" isCanSelected:YES]];
    [array addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"成交额" isCanSelected:YES]];
    [array addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"累计贷款余额" isCanSelected:YES]];
    return array;
}

#pragma mark - reloadData

- (void)tableViewReloadData {
    self.leftTableView.height = 50 * self.dataArray.count;
    self.rightTableView.height = 50 * self.dataArray.count;
    self.rightScrollView.height = 50 * self.dataArray.count;
    self.rightScrollView.contentSize = CGSizeMake(self.rightScrollView.contentSize.width, 50 * self.dataArray.count);
    CGFloat contentHeight = 50 * self.dataArray.count > ([UIScreen screenHeight] - 114) ? 50 * self.dataArray.count : [UIScreen screenHeight] - 159;
    self.baseScrollView.contentSize = CGSizeMake(self.baseScrollView.contentSize.width, contentHeight);
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}

- (void)endRefreshing {
    [self.baseScrollView.mj_header endRefreshing];
    [self.baseScrollView.mj_footer endRefreshing];
}

- (void)bottomRefreshing {
    if (self.isRefreshing || self.isNoMoreData) {
        [self endRefreshing];
        return;
    }
    [self requireIndustryDataWithStart:self.dataArray.count timeKey:self.timeKey];
}

- (void)topRefreshing {
    if (self.isRefreshing) {
        [self endRefreshing];
        return;
    }
    [self requireIndustryDataWithStart:0 timeKey:self.timeKey];
}

#pragma mark - actionMethod
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
