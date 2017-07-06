//
//  InformationPlatformViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "InformationPlatformViewController.h"
#import "IntroductionPlatformView.h"
#import "SecuritySystemView.h"
#import "OperationsTeamTableViewCell.h"
#import "PlatformDetailsModel.h"

#import "OperationsTeamModel.h"
#import "ShareholderFamilyViewController.h"



@interface InformationPlatformViewController ()<UITableViewDelegate,UITableViewDataSource,OperationsTeamTableViewCellDelegate>
@property (nonatomic ,strong)UIScrollView *baseScrView;//承载滑动的scrView
@property (nonatomic ,strong)IntroductionPlatformView *introductionPView;//平台简介view
@property (nonatomic ,strong)SecuritySystemView *securitySyView;//安全体系 工商信息 股东结构 备案信息 运营团队view
@property (nonatomic ,strong)UITableView *operatingTable;//运营团队的tableview

@property (nonatomic ,strong)NSMutableArray *resultArr;//接受运营团队的数据
@property (nonatomic ,strong)ShareholderFamilyViewController *shareholdVc;//股东族谱
@property (nonatomic ,copy)NSString *ptidString;//接受model里的ptid股东族谱需要用
@property (nonatomic ,copy)NSString *nameString;//接受model里的name股东族谱需要用
@property (nonatomic ,copy)NSString *imageurlString;//接受model里的logourl股东族谱需要用

@end

@implementation InformationPlatformViewController
-(NSMutableArray *)resultArr
{
    if (_resultArr == nil)
    {
        _resultArr = [NSMutableArray array];
    }
    return _resultArr;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:self.titleViewString];
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    [self PlatformForDetailsData];//详情接口
    
    //底部滑动的scr
    _baseScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    _baseScrView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _baseScrView.showsVerticalScrollIndicator = NO;
    _baseScrView.contentSize = CGSizeMake(BOScreenW, 2343*BOScreenH/1334+64);
    [self.view addSubview:_baseScrView];
    
    //平台简介View
    _introductionPView = [[IntroductionPlatformView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 365*BOScreenH/1334)];
    [_introductionPView.allButton addTarget:self action:@selector(allButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_baseScrView addSubview:_introductionPView];
    
    //安全体系 工商信息 股东结构 备案信息 运营团队
    _securitySyView = [[SecuritySystemView alloc]initWithFrame:CGRectMake(0, 381*BOScreenH/1334, BOScreenW, 1392*BOScreenH/1334)];
    //查看股东族谱的按钮
    [_securitySyView.familyTreeButton addTarget:self action:@selector(familyTreeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_baseScrView addSubview:_securitySyView];
    
    //运营团队的tableview
    _operatingTable = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_securitySyView.frame), BOScreenW, 570*BOScreenH/1334) style:UITableViewStyleGrouped];
    _operatingTable.delegate = self;
    _operatingTable.dataSource = self;
   // _operatingTable.scrollEnabled = NO;
    [_baseScrView addSubview:_operatingTable];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellString = @"cell";
    OperationsTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[OperationsTeamTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.item = self.resultArr[indexPath.row];
    cell.senderTag = indexPath.row;
    return cell;
}
#pragma mark - OperationsTeamTableViewCellDelegate
-(void)userDidSelectTableViewCell:(OperationsTeamTableViewCell *)cells{
    [_operatingTable reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OperationsTeamModel * customModel = self.resultArr[indexPath.row];
    if (customModel.is_opend) {
        CGFloat H = [customModel.desc sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}].height;
        return 190*BOScreenH/1334+120;

    }else{
        return 190*BOScreenH/1334;

    }
    
    return 0;
}
#pragma amrk---查看股东族谱的按钮的点击事件---
- (void)familyTreeButtonClick
{
    NSLog(@"查看股东族谱的按钮的点击事件");
    _shareholdVc = [[ShareholderFamilyViewController alloc] init];
    _shareholdVc.ptidString = _ptidString;
    _shareholdVc.namestr = _nameString;
    _shareholdVc.imageUrlstr = _imageurlString;
    [self.navigationController pushViewController:_shareholdVc animated:YES];
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark---数据接口----
- (void)PlatformForDetailsData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"ptid"] = self.ptid;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@WdApi/getWdPtInfo",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            PlatformDetailsModel *model = [PlatformDetailsModel mj_objectWithKeyValues:responseObject[@"main_data"]];
            _introductionPView.item = model;
            _securitySyView.item = model;
            //股东族谱网页需要的ptid
            _ptidString = model.ptid;
            _nameString = model.name;
            _imageurlString = model.logo;
            
            //运营团队的数据
            self.resultArr = [OperationsTeamModel mj_objectArrayWithKeyValuesArray:responseObject[@"manage_list"]];
            [_operatingTable reloadData];
            //设置tableview高度和contensize滑动范围
            _operatingTable.frame = CGRectMake(0, 1773*BOScreenH/1334, BOScreenW, 190*BOScreenH/1334*_resultArr.count);
            _baseScrView.contentSize = CGSizeMake(BOScreenW, 365*BOScreenH/1334 + 16*BOScreenH/1334 + 1392*BOScreenH/1334 +190*BOScreenH/1334*_resultArr.count + 64);
            
            //平台简介详情
            _introductionPView.detailIntLabel.text = model.pt_desc;
            //设置行高
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: _introductionPView.detailIntLabel.text];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:6];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_introductionPView.detailIntLabel.text length])];
            _introductionPView.detailIntLabel.attributedText = attributedString;
            [_introductionPView.detailIntLabel sizeToFit];
            _introductionPView.detailIntLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            
            _heights = [self boundingRectWithString:_introductionPView.detailIntLabel.text];
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
#pragma mark---全文的点击事件---
- (void)allButtonClick
{
    if (_onAndoff)
    {

        //设置字体详情的frame
        _introductionPView.detailIntLabel.numberOfLines = 4;
        _introductionPView.detailIntLabel.frame = CGRectMake(30*BOScreenW/750, 120*BOScreenH/1334, BOScreenW - 70*BOScreenW/750, 170*BOScreenH/1334);
        [_introductionPView.detailIntLabel sizeToFit];
        //设置平台简介view的高度
        _introductionPView.frame = CGRectMake(0, 0, BOScreenW, 365*BOScreenH/1334);
        //全文按钮的高度frame
        _introductionPView.allButton.frame = CGRectMake(30*BOScreenW/750, 300*BOScreenH/1334, 70*BOScreenW/750, 40*BOScreenH/1334);
        [_introductionPView.allButton setTitle:@"全文" forState:UIControlStateNormal];

        _securitySyView.frame = CGRectMake(0, 381*BOScreenH/1334, BOScreenW, 1392*BOScreenH/1334);
        _operatingTable.frame = CGRectMake(0, 1773*BOScreenH/1334, BOScreenW, 190*BOScreenH/1334*_resultArr.count);
        _baseScrView.contentSize = CGSizeMake(BOScreenW, 365*BOScreenH/1334 + 16*BOScreenH/1334 + 1392*BOScreenH/1334 +190*BOScreenH/1334*_resultArr.count + 64);
        _onAndoff = NO;
    }else
    {

        //设置字体详情的frame
        _introductionPView.detailIntLabel.numberOfLines = 0;
        _introductionPView.detailIntLabel.frame = CGRectMake(30*BOScreenW/750, 120*BOScreenH/1334, BOScreenW - 70*BOScreenW/750, _heights);
        [_introductionPView.detailIntLabel sizeToFit];
        
        //全文按钮的高度frame
        _introductionPView.allButton.frame = CGRectMake(30*BOScreenW/750, 120*BOScreenH/1334 + _heights + 10*BOScreenH/1334, 70*BOScreenW/750, 40*BOScreenH/1334);
        [_introductionPView.allButton setTitle:@"收起" forState:UIControlStateNormal];
        
        //设置平台简介view的高度
        _introductionPView.frame = CGRectMake(0, 0, BOScreenW, 195*BOScreenH/1334 + _heights);
        CGFloat kkk = 195*BOScreenH/1334 + _heights - 365*BOScreenH/1334;
        _securitySyView.frame = CGRectMake(0, 381*BOScreenH/1334+kkk, BOScreenW, 1392*BOScreenH/1334);

        _operatingTable.frame = CGRectMake(0, 1773*BOScreenH/1334+kkk, BOScreenW, 190*BOScreenH/1334*_resultArr.count);
        _baseScrView.contentSize = CGSizeMake(BOScreenW, 195*BOScreenH/1334 + _heights + 16*BOScreenH/1334 + 1392*BOScreenH/1334 +190*BOScreenH/1334*_resultArr.count + 64);

//        _operatingTable.frame = CGRectMake(0, 1773*BOScreenH/1334+kkk, BOScreenW, 570*BOScreenH/1334);
        
        _onAndoff = YES;
    }
}
//计算label高度
- (CGFloat)boundingRectWithString:(NSString *)string
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 6;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, paragraph, NSParagraphStyleAttributeName, nil];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(BOScreenW - 70*BOScreenW/750, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:nil];
    return  rect.size.height;
}
@end
