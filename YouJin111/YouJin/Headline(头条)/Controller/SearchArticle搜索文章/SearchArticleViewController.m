//
//  SearchArticleViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "SearchArticleViewController.h"

@interface SearchArticleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UIScrollView *homescrView;//底部滑动的scrview
@property (nonatomic ,strong)UITableView *searHisTableView;//tableview
@property (nonatomic ,strong)UISearchBar *searchBar;//搜索框
@end

@implementation SearchArticleViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏左边的系统的bake按钮
    self.navigationItem.hidesBackButton = YES;
    //设置titleView
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 625*BOScreenW/750, 60*BOScreenH/1334)];
    [self.navigationController.navigationBar setBarTintColor:[UIColor navDefaultColor]];
    [titleView setBackgroundColor:[UIColor clearColor]];
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.frame = CGRectMake(0, 0, 625*BOScreenW/750, 60*BOScreenH/1334);
    _searchBar.backgroundColor = [UIColor whiteColor];
    _searchBar.layer.cornerRadius = 16;
    _searchBar.layer.masksToBounds = YES;
    [_searchBar.layer setBorderWidth:2];
    [_searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    _searchBar.placeholder = @"搜索您感兴趣的文章                                  ";
    [titleView addSubview:_searchBar];
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    if (iPhone5)
    {
        titleView.frame = CGRectMake(0, 0, 615*BOScreenW/750, 60*BOScreenH/1334);
        _searchBar.frame = CGRectMake(0, 0, 615*BOScreenW/750, 60*BOScreenH/1334);
        _searchBar.layer.cornerRadius = 14;
        _searchBar.placeholder = @"搜索您感兴趣的文章                         ";
    }
    if (iPhone6P)
    {
        [_searchBar.layer setBorderWidth:3];
        titleView.frame = CGRectMake(0, 0, 605*BOScreenW/750, 60*BOScreenH/1334);
        _searchBar.frame = CGRectMake(0, 0, 605*BOScreenW/750, 60*BOScreenH/1334);
    }
    //设置rightBarButtonItem
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,100*BOScreenW/750,50*BOScreenH/1334)];
    [rightButton setTitle:@"   取消" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    //底部滑动的scr
    _homescrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    _homescrView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _homescrView.showsVerticalScrollIndicator = NO;
    _homescrView.contentSize = CGSizeMake(BOScreenW, 1498*BOScreenH/1334+64);
    [self.view addSubview:_homescrView];
    
    //热门搜索view
    [self topSearchView];
    //历史搜索tableview
    [self searchHistoryView];
    
    //清空记录
    CGFloat searHisTableViewY = CGRectGetMaxY(_searHisTableView.frame) + 50*BOScreenH/1334;
    UIButton *emptyRecordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    emptyRecordButton.frame = CGRectMake(277*BOScreenW/750, searHisTableViewY, 196*BOScreenW/750, 62*BOScreenH/1334);
    emptyRecordButton.layer.borderWidth = 1;
    emptyRecordButton.layer.borderColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1].CGColor;
    emptyRecordButton.layer.cornerRadius = 3;
    emptyRecordButton.layer.masksToBounds = YES;
    [emptyRecordButton setTitle:@"清空记录" forState:UIControlStateNormal];
    [emptyRecordButton setImage:[UIImage imageNamed:@"icon_del"] forState:UIControlStateNormal];
    emptyRecordButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [emptyRecordButton setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
    emptyRecordButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10*BOScreenW/750, 0, 0);
    [_homescrView addSubview:emptyRecordButton];
}
#pragma mark---热门搜索的view---
- (void)topSearchView
{
    UIView *hotView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 340*BOScreenH/1334)];
    hotView.backgroundColor = [UIColor whiteColor];
    [_homescrView addSubview:hotView];
    
    //热门搜索
    UILabel *hotlabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 30*BOScreenH/1334, 150*BOScreenW/750, 30*BOScreenH/1334)];
    hotlabel.text = @"热门搜索";
    [hotlabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
    hotlabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    [hotView addSubview:hotlabel];
    
    NSArray *arr = @[@"理财",@"微贷网",@"春节抢红包",@"浦发银行",@"招商银行",@"蚂蚁金融",@"金融大事件",@"牛市",@"股票",@"基金"];
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 80*BOScreenH/1334;//用来控制button距离父视图的高
    for (int i = 0; i < arr.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 100 + i;
        button.backgroundColor = [UIColor colorWithHexString:@"#fafbfc" alpha:1];
        [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor colorWithHexString:@"#737373" alpha:1] forState:UIControlStateNormal];
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor colorWithHexString:@"#d5d8db" alpha:1].CGColor;
        button.layer.cornerRadius = 3;
        button.layer.masksToBounds = YES;
        //根据计算文字的大小 //设置所有button的宽高也就是所占大小
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGFloat length = [arr[i] boundingRectWithSize:CGSizeMake(700*BOScreenW/750, 260*BOScreenH/1334) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        //为button赋值
        [button setTitle:arr[i] forState:UIControlStateNormal];
        //设置button的frame //48*BOScreenW/750可设button的宽度
        button.frame = CGRectMake(30*BOScreenW/750 + w, h, length + 48*BOScreenW/750, 58*BOScreenH/1334);
        //当button的位置超出屏幕边缘时换行 700*BOScreenW/750 只是button所在父视图的宽度
        if(30*BOScreenW/750 + w + length + 48*BOScreenW/750 > 700*BOScreenW/750)
        {
            w = 0; //换行时将w置为0
            h = h + button.frame.size.height + 16*BOScreenH/1334;//距离父视图也变化 //行高
            button.frame = CGRectMake(30*BOScreenW/750 + w, h, length + 48*BOScreenW/750, 58*BOScreenH/1334);//重设button的frame
        }
        //button 之间的距离
        w = button.frame.size.width + button.frame.origin.x - 14*BOScreenW/750;
        [hotView addSubview:button];
    }
}
- (void)handleClick:(UIButton *)btn
{
    NSLog(@"%ld",(long)btn.tag);
}
#pragma mark---历史搜索---
- (void)searchHistoryView
{
    _searHisTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 356*BOScreenH/1334, BOScreenW, 980*BOScreenH/1334) style:UITableViewStyleGrouped];
    _searHisTableView.delegate = self;
    _searHisTableView.dataSource = self;
    _searHisTableView.scrollEnabled = NO;
    _searHisTableView.backgroundColor = [UIColor whiteColor];
    [_homescrView addSubview:_searHisTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier= @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"一两理财";
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    cell.imageView.image = [UIImage imageNamed:@"icon_lishi"];
    cell.separatorInset = UIEdgeInsetsMake(0, 30*BOScreenW/750, 0, 0);//设置cell的分割线位置
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90*BOScreenH/1334;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80*BOScreenH/1334;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 80*BOScreenH/1334)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 25*BOScreenH/1334, 150*BOScreenW/750, 30*BOScreenH/1334)];
    [headerLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
    headerLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    headerLabel.text = @"历史搜索";
    [headerView addSubview:headerLabel];
    return headerView;
}
#pragma mark---rightButtonClick---
- (void)rightButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
//    [_searchBar resignFirstResponder]; 键盘失去响应
}
@end
