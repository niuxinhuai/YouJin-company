//
//  DemonstrationOfFundViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/24.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "DemonstrationOfFundViewController.h"
#import "DemonstrationOFTableViewCell.h"
#import "SectionHeadView.h"
#import "NextDemonsOFTableViewCellTableViewCell.h"
#import "NextSectionHead.h"
#import "FundDetailsViewController.h"
#import "InvestmentInPuzzleViewController.h"

@interface DemonstrationOfFundViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *announcementTableView;//唯一的tableview
@end

@implementation DemonstrationOfFundViewController
- (void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    //    self.title = @"示范基金";
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"示范基金"];
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    self.navigationItem.leftBarButtonItem = btnItem;
    //设置rightBarButtonItem
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,150*BOScreenW/750,50*BOScreenH/1334)];
    [rightButton setTitle:@"投资饼图" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //顶部图片
    [self topImageView];
    
    //上面的一个tableview
    _announcementTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 360*BOScreenH/1334, BOScreenW, BOScreenH - 360*BOScreenH/1334-64-80*BOScreenH/1334) style:UITableViewStylePlain];
    _announcementTableView.delegate = self;
    _announcementTableView.dataSource = self;
    _announcementTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_announcementTableView];
    
    //底部的白色view
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, BOScreenH-80*BOScreenH/1334-64, BOScreenW, 80*BOScreenH/1334)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    //底部的文字声明
    UILabel *baseLabel = [[UILabel alloc]initWithFrame:CGRectMake(20*BOScreenW/750, 9*BOScreenH/1334, BOScreenW-40*BOScreenW/750, 80*BOScreenH/1334)];
    baseLabel.text = @"以上平台均为有金真实投资，当平台数据不符投资决策时，有金会进行撤资。撤资后，各展现都会取消，请各位投友知悉。";
    baseLabel.font = [UIFont systemFontOfSize:11];
    if (iPhone5)
    {
        baseLabel.font = [UIFont systemFontOfSize:10];
    }
    baseLabel.textColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1];
    baseLabel.numberOfLines = 0;
    [whiteView addSubview:baseLabel];
    //调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:baseLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [baseLabel.text length])];
    baseLabel.attributedText = attributedString;
    [baseLabel sizeToFit];
}
#pragma mark---顶部图片---
- (void)topImageView
{
    //底部图片
    UIImageView *bigBackgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 280*BOScreenH/1334)];
    bigBackgroundImage.image = [UIImage imageNamed:@"img_shifanjijin"];
    bigBackgroundImage.userInteractionEnabled = YES;
    [self.view addSubview:bigBackgroundImage];
    //六个label
    for (int i = 0; i < 6; i ++)
    {
        NSInteger index = i % 3;
        NSInteger page = i / 3;
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(index*(170*BOScreenW/750 + 100*BOScreenW/750) + 50*BOScreenW/750, page*(30*BOScreenH/1334 + 18*BOScreenH/1334) + 34 *BOScreenH/1334, 200*BOScreenW/750, 30*BOScreenH/1334)];
        numberLabel.text = @"总投资金额(元)";
        numberLabel.font = [UIFont systemFontOfSize:11];
        numberLabel.textColor = [UIColor colorWithHexString:@"#ffffff" alpha:0.6];
        [bigBackgroundImage addSubview:numberLabel];
        if (i > 2)
        {
            numberLabel.text = @"968326.35";
            numberLabel.textColor = [UIColor colorWithHexString:@"#ffffff" alpha:1];
            [numberLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        }
        if (i == 1)
        {
            numberLabel.text = @"投资平台";
        }
        if (i == 2)
        {
            numberLabel.text = @"综合收益率";
            numberLabel.frame = CGRectMake(index*(170*BOScreenW/750 + 80*BOScreenW/750) + 50*BOScreenW/750, page*(30*BOScreenH/1334 + 18*BOScreenH/1334) + 34 *BOScreenH/1334, 200*BOScreenW/750, 30*BOScreenH/1334);
        }
        if (i == 4)
        {
            numberLabel.text = @"36";
        }
        if (i == 5)
        {
            numberLabel.text = @"12%";
            numberLabel.frame = CGRectMake(index*(170*BOScreenW/750 + 80*BOScreenW/750) + 50*BOScreenW/750, page*(30*BOScreenH/1334 + 18*BOScreenH/1334) + 34 *BOScreenH/1334, 200*BOScreenW/750, 30*BOScreenH/1334);
        }
    }
    //详情介绍
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(35*BOScreenW/750, 140*BOScreenH/1334, BOScreenW-70*BOScreenW/750, 75*BOScreenH/1334)];
    detailLabel.text = @"有金网贷基金更好的服务于社会我们致力于为你提供更加贴心的服务有金网贷基金更好的服务于社会我们致力于为你提供更加贴心的服务有金网贷基金更好的服务于社会我们致力于为你提供更加贴心的服务";
    detailLabel.font = [UIFont systemFontOfSize:13];
    [detailLabel setTextColor:[UIColor whiteColor]];
    detailLabel.numberOfLines = 0;
    [bigBackgroundImage addSubview:detailLabel];
    
    //展开的箭头
    CGFloat detailLabelY = CGRectGetMaxY(detailLabel.frame) + 25*BOScreenH/1334;
    UIButton *spreadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    spreadBtn.frame = CGRectMake(BOScreenW/2 - 15*BOScreenW/750, detailLabelY, 30*BOScreenW/750, 15*BOScreenH/1334);
    [spreadBtn setBackgroundImage:[UIImage imageNamed:@"common_arrow_address"] forState:UIControlStateNormal];
    [spreadBtn addTarget:self action:@selector(spreadBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bigBackgroundImage addSubview:spreadBtn];
    
    //近期公告
    [self theRecentAnnouncementView];
}
#pragma mark---近期公告的View---
- (void)theRecentAnnouncementView
{
    UIView *announcementView = [[UIView alloc]initWithFrame:CGRectMake(0, 280*BOScreenH/1334, BOScreenW, 80*BOScreenH/1334)];
    announcementView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:announcementView];
    
    //图片
    UIImageView *frontImage = [[UIImageView alloc]initWithFrame:CGRectMake(20*BOScreenW/750, 26*BOScreenH/1334, 32*BOScreenW/750, 28*BOScreenH/1334)];
    frontImage.image = [UIImage imageNamed:@"icon_gonggao"];
    [announcementView addSubview:frontImage];
    //近期公告
    CGFloat frontImageX = CGRectGetMaxX(frontImage.frame) + 14*BOScreenW/750;
    UILabel *announcementLabl = [[UILabel alloc]initWithFrame:CGRectMake(frontImageX, 15*BOScreenH/1334, 130*BOScreenW/750, 50*BOScreenH/1334)];
    announcementLabl.text = @"近期公告";
    announcementLabl.font = [UIFont systemFontOfSize:13];
    announcementLabl.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    [announcementView addSubview:announcementLabl];
    //详情
    CGFloat announcementLablX = CGRectGetMaxX(announcementLabl.frame) + 40*BOScreenW/750;
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(announcementLablX, 15*BOScreenH/1334, BOScreenW-20*BOScreenW/750-announcementLablX, 50*BOScreenH/1334)];
    detailLabel.text = @"示范基金近期撤资房金所";
    detailLabel.font = [UIFont systemFontOfSize:13];
    detailLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    [announcementView addSubview:detailLabel];
}

#pragma mark---tableview的代理---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1)
    {
        return 3;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString *cellString = @"cell";
        UINib *nib = [UINib nibWithNibName:@"DemonstrationOFTableViewCell" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:cellString];
        
        DemonstrationOFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
        if (cell == nil)
        {
            cell = [[DemonstrationOFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
        //点击后的阴影效果
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    static NSString *cellString = @"cell";
    UINib *nib = [UINib nibWithNibName:@"NextDemonsOFTableViewCellTableViewCell" bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:cellString];
    
    NextDemonsOFTableViewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[NextDemonsOFTableViewCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*BOScreenH/1334;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"SectionHeadView" owner:nil options:nil];
        UIView *plainView = [nibContents lastObject];
        return plainView;
    }
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"NextSectionHead" owner:nil options:nil];
    UIView *plainView = [nibContents lastObject];
    //    NextSectionHead *nextView = [[NextSectionHead alloc]init];
    //    nextView.castPlatformLabel.text = @"撤资平台";
    return plainView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 126*BOScreenH/1334;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FundDetailsViewController *FundDetailsVC = [[FundDetailsViewController alloc]init];
    [self.navigationController pushViewController:FundDetailsVC animated:YES];
}
#pragma mark---展开的箭头---
- (void)spreadBtnClick
{
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark----rightButtonClick----
- (void)rightButtonClick
{
    InvestmentInPuzzleViewController *inves = [[InvestmentInPuzzleViewController alloc]init];
    [self.navigationController pushViewController:inves animated:YES];
}

@end
