//
//  FocusOnMoreViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "FocusOnMoreViewController.h"
#import "FocusOnMoreTableViewCell.h"

@interface FocusOnMoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UIView *defaultView;//默认排序和全部类型显示的背景view
@property (nonatomic ,strong)UIView *whiView;//默认排序的白色view
@property (nonatomic ,strong)UIView *whiteView;//全部类型的白色view
@end

@implementation FocusOnMoreViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"有金号"];
//    // 设置leftButtonItem
//    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
//    self.navigationItem.leftBarButtonItem = btnItem;
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    UITableView *onlyTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64) style:UITableViewStylePlain];
    onlyTableview.delegate = self;
    onlyTableview.dataSource  = self;
    onlyTableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:onlyTableview];
    //默认排序 全部类型的view
    [self TheDefaultSortAndTypeView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellString = @"cell";
    FocusOnMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[FocusOnMoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.separatorInset = UIEdgeInsetsMake(0, 20*BOScreenW/750, 0, 0);//设置cell的分割线位置
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140*BOScreenH/1334;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80*BOScreenH/1334;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 80*BOScreenH/1334)];
    bgView.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[@"默认排序",@"全部类型"];
    for (int i = 0; i < 2; i++)
    {
        UIButton *secHeadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        secHeadButton.frame = CGRectMake(i*(BOScreenW/2), 0, BOScreenW/2, 80*BOScreenH/1334);
        secHeadButton.tag = 100+i;
        [secHeadButton setTitle:arr[i] forState:UIControlStateNormal];
        [secHeadButton setTitleColor:[UIColor colorWithHexString:@"#333333" alpha:1] forState:UIControlStateNormal];
        secHeadButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [secHeadButton addTarget:self action:@selector(secHeadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:secHeadButton];
        [secHeadButton setImage:[UIImage imageNamed:@"common_icon_xiala"] forState:UIControlStateNormal];
        secHeadButton.imageEdgeInsets = UIEdgeInsetsMake(0, secHeadButton.frame.size.width - secHeadButton.imageView.frame.origin.x - secHeadButton.imageView.frame.size.width - 0*BOScreenW/750, 0, 0);
        secHeadButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(secHeadButton.frame.size.width - secHeadButton.imageView.frame.size.width ) + 330*BOScreenW/750, 0, 0);
        if (iPhone6P)
        {
            secHeadButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(secHeadButton.frame.size.width - secHeadButton.imageView.frame.size.width ) + 360*BOScreenW/750, 0, 0);
        }
    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(BOScreenW/2, 15*BOScreenH/1334, 1*BOScreenW/750, 50*BOScreenH/1334)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe2e6" alpha:1];
    [bgView addSubview:lineView];
    
    UIView *endView = [[UIView alloc]initWithFrame:CGRectMake(0, 79*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
    endView.backgroundColor = [UIColor colorWithHexString:@"#dfe2e6" alpha:1];
    [bgView addSubview:endView];
    
    return bgView;
}
#pragma mark---默认排序 全部类型的点击事件---
- (void)secHeadButtonClick:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 100:
        {
            _defaultView.hidden = NO;
            _whiView.hidden = NO;
            _whiteView.hidden = YES;
            break;
        }
            
        case 101:
        {
            _defaultView.hidden = NO;
            _whiView.hidden = YES;
            _whiteView.hidden = NO;
            break;
        }
            
        default:
            break;
    }
}
#pragma mark---点击默认排序显示的view---
- (void)TheDefaultSortAndTypeView
{
    //排序：默认排序  发帖最多 粉丝最多
    //背景view
    _defaultView = [[UIView alloc]initWithFrame:CGRectMake(0, 80*BOScreenH/1334, BOScreenW, BOScreenH - 80*BOScreenH/1334)];
    _defaultView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.35];
    [self.view addSubview:_defaultView];
    //添加手势单击事件
    UITapGestureRecognizer *Ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GesClick:)];
    Ges.numberOfTapsRequired = 1;
    [_defaultView addGestureRecognizer:Ges];
    //白色view
    _whiView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 270*BOScreenH/1334)];
    _whiView.backgroundColor = [UIColor colorWithHexString:@"#ffffff" alpha:1];
    [_defaultView addSubview:_whiView];
   
    NSArray *arr = @[@"默认排序",@"发帖最多",@"粉丝最多"];
    for (int i = 0; i < 3; i ++)
    {
        UILabel *defaultLabel = [[UILabel alloc]initWithFrame:CGRectMake(50*BOScreenW/750, 30*BOScreenH/1334 + i*(90*BOScreenH/1334), 120*BOScreenW/750, 30*BOScreenH/1334)];
        defaultLabel.text = arr[i];
        defaultLabel.font = [UIFont systemFontOfSize:14];
        defaultLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [_whiView addSubview:defaultLabel];
        //默认排序  发帖最多 粉丝最多的button按钮
        UIButton *defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        defaultButton.frame = CGRectMake(0, i*(90*BOScreenH/1334), BOScreenW, 90*BOScreenH/1334);
        [_whiView addSubview:defaultButton];
    }
    for (int i = 0; i < 2; i ++)
    {
        //细线
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 89*BOScreenH/1334 + i*(90*BOScreenH/1334), BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#e9edf0" alpha:1];
        [_whiView addSubview:lineView];
    }

    //类型：全部类型   自媒体  企业
    //白色view
    _whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 270*BOScreenH/1334)];
    _whiteView.backgroundColor = [UIColor colorWithHexString:@"#ffffff" alpha:1];
    [_defaultView addSubview:_whiteView];
    NSArray *array = @[@"全部类型",@"自媒体",@"企业"];
    for (int i = 0; i < 3; i ++)
    {
        UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(50*BOScreenW/750, 30*BOScreenH/1334 + i*(90*BOScreenH/1334), 120*BOScreenW/750, 30*BOScreenH/1334)];
        typeLabel.text = array[i];
        typeLabel.font = [UIFont systemFontOfSize:14];
        typeLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [_whiteView addSubview:typeLabel];
        //全部类型   自媒体  企业的button按钮
        UIButton *typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        typeButton.frame = CGRectMake(0, i*(90*BOScreenH/1334), BOScreenW, 90*BOScreenH/1334);
        [_whiteView addSubview:typeButton];
    }
    for (int i = 0; i < 2; i ++)
    {
        //细线
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 89*BOScreenH/1334 + i*(90*BOScreenH/1334), BOScreenW-30*BOScreenW/750, 1*BOScreenH/1334)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#e9edf0" alpha:1];
        [_whiteView addSubview:lineView];
    }
    _defaultView.hidden = YES;
    _whiView.hidden = YES;
    _whiteView.hidden = YES;
}
#pragma mark---单击手势事件---
- (void)GesClick:(UITapGestureRecognizer *)sender
{
    _defaultView.hidden = YES;
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
