//
//  FundDetailsViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/25.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "FundDetailsViewController.h"
#import "InvestmentGuideView.h"
#import "LogTableViewCell.h"

@interface FundDetailsViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UIScrollView *baseScrView;
@property (nonatomic ,strong)UIButton *logButton;
@property (nonatomic ,strong)UIView *wireView;
@property (nonatomic, strong)UIScrollView *detailScr;
@property (nonatomic ,strong)NSMutableArray *buttonArray;

@end

@implementation FundDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"民代天下示范基金";
    
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    self.navigationItem.leftBarButtonItem = btnItem;
    
    //设置titleView
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor clearColor];
    contentView.frame = CGRectMake(0, 0, 400*BOScreenW/750, 60*BOScreenH/1334);
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 400*BOScreenW/750, 30*BOScreenH/1334)];
    topLabel.text = @"民贷天下示范基金";
    topLabel.textColor = [UIColor whiteColor];
    [topLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    topLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:topLabel];
    UILabel *belowLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40*BOScreenH/1334, 400*BOScreenW/750, 20*BOScreenH/1334)];
    belowLabel.text = @"2016.11.17更新";
    belowLabel.textColor = [UIColor colorWithHexString:@"#ffffff" alpha:0.8];
    [belowLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    belowLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:belowLabel];
    self.navigationItem.titleView = contentView;
    
    _buttonArray = [[NSMutableArray alloc]init];
    
    //底部滑动的scr
    _baseScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    _baseScrView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _baseScrView.showsVerticalScrollIndicator = NO;
    _baseScrView.contentSize = CGSizeMake(BOScreenW, 1397*BOScreenH/1334+15);
    [self.view addSubview:_baseScrView];
    //平台详情
    [self fundDetailsView];
    //投资日志 投资指南
    [self investmentView];
    //投资日志 投资指南 详情
    [self investmentDetailView];
}
#pragma mark---平台的详情---
- (void)fundDetailsView
{
    UIView *detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 291*BOScreenH/1334)];
    detailView.backgroundColor = [UIColor whiteColor];
    [_baseScrView addSubview:detailView];
    //图片
    UIImageView *logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 40*BOScreenH/1334, 130*BOScreenW/750, 60*BOScreenH/1334)];
    logoImage.image = [UIImage imageNamed:@"img_loadinga"];
    logoImage.layer.cornerRadius = 3;
    logoImage.layer.masksToBounds = YES;
    [detailView addSubview:logoImage];
    //关注人数
    CGFloat logoImageX = CGRectGetMaxX(logoImage.frame) + 30*BOScreenW/1334;
    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(logoImageX, 40*BOScreenH/1334, 200*BOScreenW/750, 60*BOScreenH/1334)];
    numberLabel.text = @"关注人数 1043";
    numberLabel.font = [UIFont systemFontOfSize:12];
    numberLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    [detailView addSubview:numberLabel];
    //关注
    UIButton *attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    attentionButton.frame = CGRectMake(BOScreenW- 288*BOScreenW/750, 44*BOScreenH/1334, 124*BOScreenW/750, 52*BOScreenH/1334);
    [attentionButton setBackgroundImage:[UIImage imageNamed:@"common_btn_guanzhu_nor"] forState:UIControlStateNormal];
    [detailView addSubview:attentionButton];
    //关注
    UIButton *visitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    visitButton.frame = CGRectMake(BOScreenW - 144*BOScreenW/750, 44*BOScreenH/1334, 124*BOScreenW/750, 52*BOScreenH/1334);
    [visitButton setBackgroundColor:[UIColor colorWithHexString:@"#8fc31f" alpha:1]];
    [visitButton setTitle:@"访问平台" forState:UIControlStateNormal];
    visitButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [visitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    visitButton.layer.cornerRadius = 3;
    visitButton.layer.masksToBounds = YES;
    [detailView addSubview:visitButton];
    //分割线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 140*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.1];
    [detailView addSubview:lineView];
    //综合利润 代收总额 到期日期
    for (int i = 0; i < 3; i ++)
    {
        UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(20*BOScreenW/750 + i*(200*BOScreenW/750+55*BOScreenW/750), 170*BOScreenH/1334, 200*BOScreenW/750, 40*BOScreenH/1334)];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.font = [UIFont systemFontOfSize:13];
        dateLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
        [detailView addSubview:dateLabel];
        if (i == 0)
        {
            dateLabel.text = @"综合利润";
        }
        if (i == 1)
        {
            dateLabel.text = @"代收总额";
        }
        if (i == 2)
        {
            dateLabel.text = @"到期日期";
        }
    }
    for (int i = 0; i < 3; i ++)
    {
        UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(15*BOScreenW/750 + i*(210*BOScreenW/750+45*BOScreenW/750), 220*BOScreenH/1334, 210*BOScreenW/750, 40*BOScreenH/1334)];
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        moneyLabel.font = [UIFont systemFontOfSize:15];
        moneyLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [detailView addSubview:moneyLabel];
        if (i == 0)
        {
            moneyLabel.text = @"8.93%";
        }
        if (i == 1)
        {
            moneyLabel.text = @"2,316,892.01";
        }
        if (i == 2)
        {
            moneyLabel.text = @"2017.03.09";
        }
    }
}
#pragma mark---投资日志 投资指南---
- (void)investmentView
{
    UIView *investmentview = [[UIView alloc]initWithFrame:CGRectMake(0, 307*BOScreenH/1334, BOScreenW, 80*BOScreenH/1334)];
    investmentview.backgroundColor = [UIColor whiteColor];
    [_baseScrView addSubview:investmentview];
    
    for (int i = 0; i < 2; i ++)
    {
        _logButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _logButton.frame = CGRectMake(110*BOScreenW/750 + i*(150*BOScreenW/750 + 230*BOScreenW/750), 10*BOScreenH/1334, 150*BOScreenW/750, 60*BOScreenH/1334);
        if (i==0)
        {
            [_logButton setTitle:@"投资日志" forState:UIControlStateNormal];
            [_logButton setTitleColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] forState:UIControlStateNormal];
        }
        if (i==1)
        {
            [_logButton setTitle:@"投资指南" forState:UIControlStateNormal];
            [_logButton setTitleColor:[UIColor colorWithHexString:@"333333" alpha:1] forState:UIControlStateNormal];
        }
        _logButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _logButton.tag = 100+i;
        [_logButton addTarget:self action:@selector(logButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [investmentview addSubview:_logButton];
        [_buttonArray addObject:_logButton];
    }
    //小view（线）
    _wireView = [[UIView alloc]initWithFrame:CGRectMake(self.logButton.frame.origin.x + 30*BOScreenW/750 - 150*BOScreenW/750 - 230*BOScreenW/750, 76*BOScreenH/1334, 90*BOScreenW/750, 4*BOScreenH/1334)];
    _wireView.backgroundColor = [UIColor colorWithHexString:@"#2d84f2" alpha:1];
    _wireView.layer.cornerRadius = 1;
    _wireView.layer.masksToBounds = YES;
    [investmentview addSubview:_wireView];
    
    //分割线
    UIView *linView = [[UIView alloc]initWithFrame:CGRectMake(0, 79*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
    linView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.1];
    [investmentview addSubview:linView];
}
#pragma mark---投资日志 投资指南的详情---
- (void)investmentDetailView
{
    //底部滑动的scr
    _detailScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 387*BOScreenH/1334, BOScreenW, 1010*BOScreenH/1334)];
    _detailScr.delegate = self;
    _detailScr.backgroundColor = [UIColor whiteColor];
    _detailScr.showsHorizontalScrollIndicator = NO;
    _detailScr.bounces = NO;
    _detailScr.pagingEnabled = YES;
    _detailScr.contentSize = CGSizeMake(2*BOScreenW, 0);
    [_baseScrView addSubview:_detailScr];
    //投资日志详情
    UITableView *logTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 1010*BOScreenH/1334) style:UITableViewStylePlain];
    logTableView.delegate = self;
    logTableView.dataSource = self;
    logTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    logTableView.showsVerticalScrollIndicator = NO;
    logTableView.scrollEnabled = NO;
    [_detailScr addSubview:logTableView];
    //投资指南详情
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"InvestmentGuideView" owner:nil options:nil];
    UIView *guideView = [nibContents lastObject];
    guideView.frame = CGRectMake(BOScreenW, 0, BOScreenW, 1010*BOScreenH/1334);
    [_detailScr addSubview:guideView];
}
#pragma mark---投资日志 投资指南的点击事件---
- (void)logButtonClick:(UIButton *)sender
{
    for (int i = 0; i < 2; i ++)
    {
        UIButton *btn = (UIButton *)[self.view viewWithTag:100+i];
        if (sender.tag - 100 == i)
        {
            [btn setTitleColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                _wireView.frame = CGRectMake(self.logButton.frame.origin.x + 30*BOScreenW/750, 76*BOScreenH/1334, 90*BOScreenW/750, 4*BOScreenH/1334);
            }];
            [_detailScr setContentOffset:CGPointMake(BOScreenW, 0) animated:NO];
        }else
        {
            [btn setTitleColor:[UIColor colorWithHexString:@"#333333" alpha:1]  forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                _wireView.frame = CGRectMake(self.logButton.frame.origin.x + 30*BOScreenW/750 - 150*BOScreenW/750 - 230*BOScreenW/750, 76*BOScreenH/1334, 90*BOScreenW/750, 4*BOScreenH/1334);
            }];
            [_detailScr setContentOffset:CGPointMake(0, 0) animated:NO];
        }
    }
}
#pragma mark---scrollView的代理---
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取滚动x方向的偏移量
    CGFloat offsetX = _detailScr.contentOffset.x;
    offsetX = offsetX + _detailScr.frame.size.width*0.5;
    //用x方向的偏移量除以view的宽度取商获取索引
    NSInteger ii = offsetX/_detailScr.frame.size.width;
    //修改选中跟没选中的Button字体颜色
    for (int i=0; i<_buttonArray.count; i++)
    {
        if (i==ii)
        {
            [_buttonArray[ii] setTitleColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                _wireView.frame = CGRectMake(self.logButton.frame.origin.x + 30*BOScreenW/750, 76*BOScreenH/1334, 90*BOScreenW/750, 4*BOScreenH/1334);
            }];
        }
        else
        {
            [_buttonArray[i] setTitleColor:[UIColor colorWithHexString:@"#333333" alpha:1]  forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                _wireView.frame = CGRectMake(self.logButton.frame.origin.x + 30*BOScreenW/750 - 150*BOScreenW/750 - 230*BOScreenW/750, 76*BOScreenH/1334, 90*BOScreenW/750, 4*BOScreenH/1334);
            }];
        }
    }
}
#pragma mark---tableView的数据源和代理---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellString = @"cell";
    UINib *nib = [UINib nibWithNibName:@"LogTableViewCell" bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:cellString];
    
    LogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[LogTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240*BOScreenH/1334;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50*BOScreenH/1334;
}
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 50*BOScreenH/1334)];
    bgView.backgroundColor = [UIColor whiteColor];
    return bgView;
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
