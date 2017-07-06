//
//  IndustryDataViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "IndustryDataViewController.h"
#import "DayDataTableViewCell.h"
#import "RightDayDataTableViewCell.h"
#import "IndustryDataModel.h"
#import "EnvelopeZoneViewController.h"
#import "ConditionSelectedBar.h"

@interface IndustryDataViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic ,strong)NSMutableArray *buttonArray;
@property (nonatomic ,strong)UIButton *dataButton;
@property (nonatomic ,strong)UIView * wireView;
@property (nonatomic ,strong)UIScrollView *baseScrView;
@property (nonatomic ,strong)UITableView *leftTableView;
@property (nonatomic ,strong)UITableView *rightTableView;
@property (nonatomic, strong) ConditionSelectedBar *leftBar;
@property (nonatomic, strong) ConditionSelectedBar *rightBar;
@property (nonatomic ,strong)NSMutableArray *rightButtonArray;
@property (nonatomic ,strong)UIScrollView *rightScr;
@property (nonatomic ,assign)float numberX;
@property (nonatomic ,strong)UIView *dataView;
@property (nonatomic ,strong)UIButton *redEnvelopeButton;
@property (nonatomic ,strong)NSTimer *myTimer;
@property (nonatomic ,strong)NSTimer *myTimers;

@property (nonatomic ,strong)NSMutableArray *resultArr;//tableview的结果数组
@property (nonatomic ,copy)NSString *aFewDaysstr;
@property (nonatomic ,strong)NSDateComponents *comp;//获取当前的时间
@end

@implementation IndustryDataViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getsTheCurrentDate];//获取当前年月日
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
    topLabel.text = @"行业数据";
    topLabel.textColor = [UIColor whiteColor];
    [topLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    topLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:topLabel];
    UILabel *belowLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40*BOScreenH/1334, 400*BOScreenW/750, 20*BOScreenH/1334)];
    belowLabel.text = [NSString stringWithFormat:@"%ld-%ld-%ld更新",(long)_comp.year,(long)_comp.month,(long)_comp.day];
    belowLabel.textColor = [UIColor colorWithHexString:@"#ffffff" alpha:0.8];
    [belowLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    belowLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:belowLabel];
    self.navigationItem.titleView = contentView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTools];

    _aFewDaysstr = @"yesterday";
    _buttonArray = [[NSMutableArray alloc]initWithObjects:@"昨日数据",@"7日数据",@"30日数据", nil];
    
    //底部滑动的scr
    _baseScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 80*BOScreenH/1334, BOScreenW, BOScreenH)];
    _baseScrView.delegate = self;
    _baseScrView.tag = 200;
    _baseScrView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _baseScrView.showsVerticalScrollIndicator = NO;
   // _baseScrView.bounces = NO;
    _baseScrView.contentSize = CGSizeMake(BOScreenW, 100*BOScreenH/1334*20+80*BOScreenH/1334);
    [self.view addSubview:_baseScrView];
    [self configureSectionBar];
    //几日数据
    [self numberDayData];
    //行业数据
    [self detailData];
    [self tableViewData];//tableview的数据接口

    //创建红包图片按钮
    _redEnvelopeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _redEnvelopeButton.frame = CGRectMake(BOScreenW - 174*BOScreenW/750, BOScreenH - 310*BOScreenH/1334, 130*BOScreenW/750, 130*BOScreenW/750);
    [_redEnvelopeButton setImage:[UIImage imageNamed:@"img_hongbao"] forState:UIControlStateNormal];
    [_redEnvelopeButton addTarget:self action:@selector(redEnvelopeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_redEnvelopeButton];
}

- (void)dealloc {
    
}

- (void)detailData
{
    //创建左边平台tableview
    _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 170*BOScreenW/750, 100*BOScreenH/1334*20 + 80*BOScreenH/1334) style:UITableViewStyleGrouped];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.scrollEnabled = NO;
    _leftTableView.showsVerticalScrollIndicator = NO;
    [_baseScrView addSubview:_leftTableView];
    //调整view边距
    // 1.调整(iOS7以上)表格分隔线边距
    if ([_leftTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        _leftTableView.separatorInset = UIEdgeInsetsZero;
    }
    // 2.调整(iOS8以上)view边距(或者在cell中设置preservesSuperviewLayoutMargins,二者等效)
    if ([_leftTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        _leftTableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    //创建右边可滑动的scrView
    _rightScr = [[UIScrollView alloc]initWithFrame:CGRectMake(170*BOScreenW/750, 0, BOScreenW, 100*BOScreenH/1334*20 + 80*BOScreenH/1334)];
    _rightScr.delegate = self;
    _rightScr.tag = 201;
    _rightScr.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _rightScr.showsHorizontalScrollIndicator = NO;
    _rightScr.bounces = NO;
    _rightScr.contentSize = CGSizeMake(1100*BOScreenW/750+150*BOScreenW/750, 100*BOScreenH/1334*20 + 80*BOScreenH/1334);
    [_baseScrView addSubview:_rightScr];
    
    //创建右边的tableview
    _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 1100*BOScreenW/750, 100*BOScreenH/1334*20 + 80*BOScreenH/1334) style:UITableViewStyleGrouped];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.scrollEnabled = NO;
    _rightTableView.showsHorizontalScrollIndicator = NO;
    [_rightScr addSubview:_rightTableView];
    //调整view边距
    // 1.调整(iOS7以上)表格分隔线边距
    if ([_rightTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        _rightTableView.separatorInset = UIEdgeInsetsZero;
    }
    // 2.调整(iOS8以上)view边距(或者在cell中设置preservesSuperviewLayoutMargins,二者等效)
    if ([_rightTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        _rightTableView.layoutMargins = UIEdgeInsetsZero;
    }
}


- (void)configureTools {
    [self.rightButtonArray addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"综合利率" isCanSelected:YES]];
    [self.rightButtonArray addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"资金净流入" isCanSelected:YES]];
    [self.rightButtonArray addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"投资人数" isCanSelected:YES]];
    [self.rightButtonArray addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"借款人数" isCanSelected:YES]];
    [self.rightButtonArray addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"成交额" isCanSelected:YES]];
    [self.rightButtonArray addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"累计贷款余额" isCanSelected:YES]];
}


- (void)configureSectionBar {
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[ConditionSelectedModel conditionSelectedModelWithTitle:@"平台" isCanSelected:NO]];
    self.leftBar = ({
        ConditionSelectedBar *view = [[ConditionSelectedBar alloc]init];
        [view updateTitles:array];
        view;
    });
    
    self.rightBar = ({
        ConditionSelectedBar *view = [[ConditionSelectedBar alloc]init];
        view.layout.itemSize = CGSizeMake((170*BOScreenW/750), 45);
        [view updateTitles:self.rightButtonArray];
        view.delegate = self;
        view;
    });
    
}

#pragma mark ---几日数据---
- (void)numberDayData
{
    _dataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 80*BOScreenH/1334)];
    _dataView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_dataView];
    _dataView.layer.shadowColor=[[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
    _dataView.layer.shadowOffset=CGSizeMake(0,0);
    _dataView.layer.shadowOpacity=0.5;
    _dataView.layer.shadowRadius=3;
    
    for (int i = 0; i < 3; i ++)
    {
        _dataButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _dataButton.frame = CGRectMake(20*BOScreenW/750 + i*(200*BOScreenW/750+55*BOScreenW/750), 20*BOScreenH/1334, 200*BOScreenW/750, 40*BOScreenH/1334);
        [_dataButton setTitle:_buttonArray[i] forState:UIControlStateNormal];
        [_dataButton setTitleColor:[UIColor colorWithHexString:@"#333333" alpha:1] forState:UIControlStateNormal];
        _dataButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _dataButton.tag = 100 + i;
        [_dataButton addTarget:self action:@selector(dataButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_dataView addSubview:_dataButton];
        if (i == 0)
        {
            [_dataButton setTitleColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] forState:UIControlStateNormal];
        }
    }
    //小view（线）
    _wireView = [[UIView alloc]initWithFrame:CGRectMake(75*BOScreenW/750, 76*BOScreenH/1334, 90*BOScreenW/750, 4*BOScreenH/1334)];
    _wireView.backgroundColor = [UIColor colorWithHexString:@"#2d84f2" alpha:1];
    _wireView.layer.cornerRadius = 1;
    _wireView.layer.masksToBounds = YES;
    [_dataView addSubview:_wireView];
}
#pragma mark---几日数据的点击事件----
- (void)dataButtonClick:(UIButton *)sender
{
    for (int i = 0; i < 3; i ++)
    {
        UIButton *btn = (UIButton *)[self.view viewWithTag:100+i];
        if (sender.tag - 100 == i)
        {
            [btn setTitleColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] forState:UIControlStateNormal];
            if (sender.tag == 100)
            {
                [UIView animateWithDuration:0.3 animations:^{
                    _wireView.frame = CGRectMake(75*BOScreenW/750, 76*BOScreenH/1334, 90*BOScreenW/750, 4*BOScreenH/1334);
                }];
                _aFewDaysstr = @"yesterday";
                [self tableViewData];
            }
            if (sender.tag == 101)
            {
                [UIView animateWithDuration:0.3 animations:^{
                    _wireView.frame = CGRectMake(330*BOScreenW/750, 76*BOScreenH/1334, 90*BOScreenW/750, 4*BOScreenH/1334);
                }];
                
                _aFewDaysstr = @"week";
                [self tableViewData];
            }
            if (sender.tag == 102)
            {
                [UIView animateWithDuration:0.3 animations:^{
                    _wireView.frame = CGRectMake(585*BOScreenW/750, 76*BOScreenH/1334, 90*BOScreenW/750, 4*BOScreenH/1334);
                }];
                _aFewDaysstr = @"month";
                [self tableViewData];
        }
        }else
        {
            [btn setTitleColor:[UIColor colorWithHexString:@"#333333" alpha:1]  forState:UIControlStateNormal];
        }
    }
}
#pragma mark---tableview的数据源和代理---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTableView)
    {
        static NSString *cellString = @"cell";
        UINib *nib = [UINib nibWithNibName:@"DayDataTableViewCell" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:cellString];
        
        DayDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
        if (cell == nil)
        {
            cell = [[DayDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
        cell.items = self.resultArr[indexPath.row];
        //点击后的阴影效果
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    static NSString *cellString = @"cell";
    UINib *nib = [UINib nibWithNibName:@"RightDayDataTableViewCell" bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:cellString];
    
    RightDayDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[RightDayDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.item = self.resultArr[indexPath.row];
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*BOScreenH/1334;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _leftTableView) {
        return self.leftBar;
    }
    return self.rightBar;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80*BOScreenH/1334;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //按钮的动画效果
    [UIView animateWithDuration:0.5 animations:^{
        _redEnvelopeButton.frame = CGRectMake(BOScreenW - 65*BOScreenW/750, BOScreenH - 310*BOScreenH/1334, 130*BOScreenW/750, 130*BOScreenW/750);
        _redEnvelopeButton.alpha = 0.4;
    }];
    if (scrollView == _baseScrView)
    {
        if (_baseScrView.contentOffset.y > 0)
        {
            [self.view bringSubviewToFront:_dataView];
        }
    }
    
    if (scrollView == _rightScr)
    {
        if (_rightScr.contentOffset.x >= 0)
        {
            _numberX  = _rightScr.contentOffset.x;
            //防止阴影被遮挡
            [self.view bringSubviewToFront:_dataView];
        }
    }
}
#pragma mark---按钮做的动画效果---
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
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    //设置区头的位置
//    _rightView.frame = CGRectMake(170*BOScreenW/750, 80*BOScreenH/1334,1100*BOScreenW/750, 80*BOScreenH/1334);
//}
#pragma mark---tableView的数据接口----
- (void)tableViewData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = @"20";
    parameters[@"ty"] = _aFewDaysstr;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@WdApi/wangdaiData",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            self.resultArr = [IndustryDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [_leftTableView reloadData];
                [_rightTableView reloadData];
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
#pragma mark---获取当前的年月日---
- (void)getsTheCurrentDate
{
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    // 获取不同时间字段的信息
    _comp = [gregorian components: unitFlags fromDate:dt];
}
#pragma mark---红包的点击事件---
- (void)redEnvelopeButtonClick
{
    EnvelopeZoneViewController *envVc= [[EnvelopeZoneViewController alloc]init];
    [self.navigationController pushViewController:envVc animated:YES];
}

#pragma mark - reget
-(NSMutableArray *)resultArr
{
    if (_resultArr == nil)
    {
        _resultArr = [NSMutableArray array];
    }
    return _resultArr;
}

- (NSMutableArray *)rightButtonArray {
    if (!_rightButtonArray) {
        _rightButtonArray = [NSMutableArray array];
    }
    return _rightButtonArray;
}

@end
