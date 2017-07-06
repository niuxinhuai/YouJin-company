//
//  NetCreditRatingViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NetCreditRatingViewController.h"
#import "NetCreditRatingTableViewCell.h"
#import "EnvelopeZoneViewController.h"
#import "YjRatingModel.h"
#import "ShareManager.h"

@interface NetCreditRatingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *ratingTableView;
@property (nonatomic ,strong)NSMutableArray *buttonArray;
@property (nonatomic ,strong)NSMutableArray *medalImageArray;
@property (nonatomic ,strong)UIButton *redEnvelopeButton;
@property (nonatomic ,strong)NSTimer *myTimer;
@property (nonatomic ,strong)NSTimer *myTimers;

@property (nonatomic ,strong)NSMutableArray *resultArr;//tableview的结果数组
@property (nonatomic ,strong)NSDateComponents *comp;//获取当前的时间
@property (nonatomic ,assign)int intNumber;//记录当前的数据条数
@property (nonatomic ,strong)NSMutableArray *timeArr;//存放时间的arr
@property (nonatomic ,strong)UILabel *belowLabel;//时间
@end

@implementation NetCreditRatingViewController

- (NSMutableArray *)resultArr
{
    if (_resultArr==nil)
    {
        _resultArr = [NSMutableArray array];
    }
    return _resultArr;
}
////一进来就让自动刷新
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.ratingTableView.mj_header beginRefreshing];
//    _redEnvelopeButton.frame = CGRectMake(BOScreenW - 174*BOScreenW/750, BOScreenH - 310*BOScreenH/1334, 130*BOScreenW/750, 130*BOScreenW/750);
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _timeArr = [NSMutableArray array];
    //设置navigationItem
    [self TheRatingdata];
//    [self getsTheCurrentDate];//获取当前年月日
    [self setNavigationItem];
    
    _buttonArray = [[NSMutableArray alloc]initWithObjects:@"排名",@"平台",@"平均利率",@"平台背景",@"等级", nil];
    _medalImageArray = [[NSMutableArray alloc]initWithObjects:@"icon_jinpai",@"icon_yinpai",@"icon_tongpai", nil];
    
    //创建tableview
    _ratingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 0) style:UITableViewStylePlain];
    _ratingTableView.delegate = self;
    _ratingTableView.dataSource = self;
    _ratingTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_ratingTableView];
    //调整view边距
    // 1.调整(iOS7以上)表格分隔线边距
    if ([_ratingTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        _ratingTableView.separatorInset = UIEdgeInsetsZero;
    }
    // 2.调整(iOS8以上)view边距(或者在cell中设置preservesSuperviewLayoutMargins,二者等效)
    if ([_ratingTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        _ratingTableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    //创建红包图片按钮
    _redEnvelopeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _redEnvelopeButton.frame = CGRectMake(BOScreenW - 174*BOScreenW/750, BOScreenH - 310*BOScreenH/1334, 130*BOScreenW/750, 130*BOScreenW/750);
    [_redEnvelopeButton setImage:[UIImage imageNamed:@"img_hongbao"] forState:UIControlStateNormal];
    [_redEnvelopeButton addTarget:self action:@selector(ClickredEnvelopeButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_redEnvelopeButton];
    
    //
    //    _ratingTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    // 隐藏时间
    //    header.lastUpdatedTimeLabel.hidden = YES;
    [self mjRefreshTheLoad];
}

- (void)mjRefreshTheLoad
{
    //下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    // 根据拖拽，自动显示下拉控件
    header.automaticallyChangeAlpha = YES;
    // 设置颜色
    header.stateLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    header.lastUpdatedTimeLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    self.ratingTableView.mj_header = header;
    
    // 上拉加载
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 自动根据有无数据，判断上拉控件是否完全显示
    footer.automaticallyHidden = YES;
    footer.stateLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    self.ratingTableView.mj_footer = footer;
    
}
#pragma mark---设置navigationItem---
- (void)setNavigationItem
{
//    // 设置leftButtonItem
//    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
//    self.navigationItem.leftBarButtonItem = btnItem;
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    //设置titleView
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor clearColor];
    contentView.frame = CGRectMake(0, 0, 400*BOScreenW/750, 60*BOScreenH/1334);
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 400*BOScreenW/750, 30*BOScreenH/1334)];
    topLabel.text = @"有金评级";
    topLabel.textColor = [UIColor whiteColor];
    [topLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    topLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:topLabel];
    _belowLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40*BOScreenH/1334, 400*BOScreenW/750, 20*BOScreenH/1334)];
//    if (iPhone6P)
//    {
//        topLabel.frame = CGRectMake(0, 0, 375*BOScreenW/750, 30*BOScreenH/1334);
//        _belowLabel.frame = CGRectMake(0, 40*BOScreenH/1334, 379*BOScreenW/750, 20*BOScreenH/1334);
//    }
//    if (iPhone5)
//    {
//        topLabel.frame = CGRectMake(0, 0, 278*BOScreenW/750, 30*BOScreenH/1334);
//        _belowLabel.frame = CGRectMake(0, 40*BOScreenH/1334, 282*BOScreenW/750, 20*BOScreenH/1334);
//    }
//    belowLabel.text = [NSString stringWithFormat:@"%ld.%ld.%ld更新",(long)_comp.year,(long)_comp.month,(long)_comp.day];
    _belowLabel.textColor = [UIColor colorWithHexString:@"#d0dffb" alpha:1];
    [_belowLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:11]];
    _belowLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:_belowLabel];
    self.navigationItem.titleView = contentView;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"icon_fenxiang"] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 80, 44);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -30;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, rightItem, nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellString = @"cell";
    UINib *nib = [UINib nibWithNibName:@"NetCreditRatingTableViewCell" bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:cellString];
    
    NetCreditRatingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[NetCreditRatingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    //设置奖牌榜
    //    cell.numberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    if (indexPath.row > 2)
    {
        cell.medalImage.hidden = YES;
        cell.numberLabel.hidden = NO;
    }
    if (indexPath.row < 3)
    {
        cell.numberLabel.hidden = YES;
        cell.medalImage.hidden = NO;
        cell.medalImage.image = [UIImage imageNamed:_medalImageArray[indexPath.row]];
    }
    cell.item = self.resultArr[indexPath.row];
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*BOScreenH/1334;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80*BOScreenH/1334;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 80*BOScreenH/1334)];
    sectionView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 5; i++)
    {
        UIButton *rankingButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        rankingButton.frame = CGRectMake(i*150*BOScreenW/750, 20*BOScreenH/1334, 150*BOScreenW/750, 40*BOScreenH/1334);
        if (i == 0)
        {
            rankingButton.frame = CGRectMake(0, 20*BOScreenH/1334, 120*BOScreenW/750, 40*BOScreenH/1334);
        }
        if (i == 1)
        {
            rankingButton.frame = CGRectMake(108*BOScreenW/750, 20*BOScreenH/1334, 150*BOScreenW/750, 40*BOScreenH/1334);
        }
        if (i == 2)
        {
            rankingButton.frame = CGRectMake(270*BOScreenW/750, 20*BOScreenH/1334, 150*BOScreenW/750, 40*BOScreenH/1334);
        }
        if (i == 3)
        {
            rankingButton.frame = CGRectMake(451*BOScreenW/750, 20*BOScreenH/1334, 150*BOScreenW/750, 40*BOScreenH/1334);
        }
        if (i == 4)
        {
            rankingButton.frame = CGRectMake(617*BOScreenW/750, 20*BOScreenH/1334, 150*BOScreenW/750, 40*BOScreenH/1334);
        }
//        if (i == 0)
//        {
//            rankingButton.frame = CGRectMake(24*BOScreenW/750, 20*BOScreenH/1334, 84*BOScreenW/750, 40*BOScreenH/1334);
//            [rankingButton setImage:[UIImage imageNamed:@"common_icon_paixu_nor"] forState:UIControlStateNormal];
//            rankingButton.imageEdgeInsets = UIEdgeInsetsMake(0, rankingButton.frame.size.width - rankingButton.imageView.frame.origin.x - rankingButton.imageView.frame.size.width + 20*BOScreenW/750, 0, 0);
//            rankingButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(rankingButton.frame.size.width - rankingButton.imageView.frame.size.width ) + 30*BOScreenW/750, 0, 0);
//        }
//        if (i == 1)
//        {
//            rankingButton.frame = CGRectMake(0*BOScreenW/750 + i*(110*BOScreenW/750 +2*BOScreenW/750), 20*BOScreenH/1334, 140*BOScreenW/750, 40*BOScreenH/1334);
//        }
//        if (i == 2)
//        {
//            rankingButton.frame = CGRectMake(308*BOScreenW/750, 20*BOScreenH/1334, 120*BOScreenW/750, 40*BOScreenH/1334);
//            [rankingButton setImage:[UIImage imageNamed:@"common_icon_paixu_nor"] forState:UIControlStateNormal];
//            rankingButton.imageEdgeInsets = UIEdgeInsetsMake(0, rankingButton.frame.size.width - rankingButton.imageView.frame.origin.x - rankingButton.imageView.frame.size.width + 30*BOScreenW/750, 0, 0);
//            rankingButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(rankingButton.frame.size.width - rankingButton.imageView.frame.size.width ) + 30*BOScreenW/750, 0, 0);
//            if (iPhone5)
//            {
//                rankingButton.imageEdgeInsets = UIEdgeInsetsMake(0, rankingButton.frame.size.width - rankingButton.imageView.frame.origin.x - rankingButton.imageView.frame.size.width + 77*BOScreenW/750, 0, 0);
//            }
//        }
//        if (i == 3)
//        {
//            rankingButton.frame = CGRectMake(458*BOScreenW/750, 20*BOScreenH/1334, 140*BOScreenW/750, 40*BOScreenH/1334);
//        }
//        if (i == 4)
//        {
//            rankingButton.frame = CGRectMake(650*BOScreenW/750, 20*BOScreenH/1334, 84*BOScreenW/750, 40*BOScreenH/1334);
//        }
        
        [rankingButton setTitle:_buttonArray[i] forState:UIControlStateNormal];
        rankingButton.titleLabel.font = [UIFont systemFontOfSize:13];
        rankingButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [rankingButton setTitleColor:[UIColor colorWithHexString:@"#737373" alpha:1] forState:UIControlStateNormal];
        [sectionView addSubview:rankingButton];
    }
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 79*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.2];
    [sectionView addSubview:lineView];
    return sectionView;
}
#pragma mark---按钮做的动画效果---
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.5 animations:^{
        _redEnvelopeButton.frame = CGRectMake(BOScreenW - 65*BOScreenW/750, BOScreenH - 310*BOScreenH/1334, 130*BOScreenW/750, 130*BOScreenW/750);
        _redEnvelopeButton.alpha = 0.4;
    }];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _myTimers = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(scrollTimer) userInfo:nil repeats:NO];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate)
    {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(scrollTimer) userInfo:nil repeats:NO];
    }
}
- (void)scrollTimer
{
    [UIView animateWithDuration:0.5 animations:^{
        _redEnvelopeButton.frame = CGRectMake(BOScreenW - 174*BOScreenW/750, BOScreenH - 310*BOScreenH/1334, 130*BOScreenW/750, 130*BOScreenW/750);
        _redEnvelopeButton.alpha = 1;
    }];
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - actionMethod

- (void)shareAction:(UIButton *)sender {
    UIImage *image = [UIImage shareImageWithView:self.navigationController.view];
    [[ShareManager shareManagerStandardWithDelegate:nil] shareInView:self.view text:@"有金评级" image:image url:nil title:@"有金评级" objid:@4];
}

#pragma mark---红包图片按钮的点击事件---
- (void)ClickredEnvelopeButton
{
    EnvelopeZoneViewController *envVc= [[EnvelopeZoneViewController alloc]init];
    [self.navigationController pushViewController:envVc animated:YES];
}
- (void)TheRatingdata
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = @"20";
    [manager POST:[NSString stringWithFormat:@"%@WdApi/wangdaiPj",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            self.resultArr = [YjRatingModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            _ratingTableView.frame = CGRectMake(0, 0, BOScreenW, BOScreenH-64);
            [_ratingTableView reloadData];
            //存放得到的时间
            for (YjRatingModel *model in self.resultArr)
            {
                [_timeArr addObject:model.time_end];
            }
            //分隔字符串
            NSArray *newArray = [_timeArr[0] componentsSeparatedByString:@" "];
            _belowLabel.text = [NSString stringWithFormat:@"%@更新",newArray[0]];
        }else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
//#pragma mark---获取当前的年月日---
//- (void)getsTheCurrentDate
//{
//    // 获取代表公历的NSCalendar对象
//    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    // 获取当前日期
//    NSDate* dt = [NSDate date];
//    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
//    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
//    // 获取不同时间字段的信息
//    _comp = [gregorian components: unitFlags fromDate:dt];
//}
//下拉刷新
- (void)refresh
{
    [self TheRatingdata];
    [self.ratingTableView.mj_header endRefreshing];
}
//上拉加载
- (void)loadMoreData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = [NSString stringWithFormat:@"%zd",self.intNumber + 40];
    self.intNumber += 20;
    [manager POST:[NSString stringWithFormat:@"%@WdApi/wangdaiPj",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.ratingTableView.mj_footer endRefreshing];
        if ([responseObject[@"r"] integerValue] == 1)
        {
            self.resultArr = [YjRatingModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            _ratingTableView.frame = CGRectMake(0, 0, BOScreenW, BOScreenH-64);
            [_ratingTableView reloadData];
        }else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
@end
