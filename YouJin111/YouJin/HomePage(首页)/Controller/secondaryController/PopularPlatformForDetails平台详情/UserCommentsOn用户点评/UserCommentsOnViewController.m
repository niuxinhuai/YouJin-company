//
//  UserCommentsOnViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/19.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "UserCommentsOnViewController.h"
#import "UserCommentTableViewCell.h"
#import "BiaoQianModel.h"
#import "UserCommentCell.h"
#import "CommentInsideViewController.h"

@interface UserCommentsOnViewController ()<UITableViewDelegate,UITableViewDataSource,UserCommentCellDelegate,BONoteVerifyLogiinDelegate>
@property (nonatomic ,strong)UIView *bqView;//标签view
@property (nonatomic ,strong)NSMutableArray *BQButtonArr;//存放标签的数组
@property (nonatomic ,strong)UIButton *button;//标签按钮
@property (nonatomic ,strong)NSMutableArray *resultArr;
@property (nonatomic ,strong)UITableView *userDPTableview;
@property (nonatomic ,strong)UIView *whiView;//标签view
@property (nonatomic ,strong)NSMutableArray *searchstrArr;//给后台的标签字段
@property (nonatomic ,copy)NSString *searchString;//后台标签传参
@property (nonatomic ,copy)NSString *allString;//后台请求几条传参
@property (nonatomic ,copy)NSString *allcountString;//后台返回的一共有几条评论
@property (nonatomic ,copy)NSString *isnewString;//后台传参 最新还是默认
@property (nonatomic ,strong)BiaoQianModel *model;
@property (nonatomic ,copy)NSString *jiluString;


@property (nonatomic ,copy)NSString *hpString;
@property (nonatomic ,copy)NSString *cpString;
@property (nonatomic ,copy)NSString *txcString;
@property (nonatomic ,copy)NSString *fwhString;
@property (nonatomic ,copy)NSString *kpString;
@property (nonatomic ,copy)NSString *btmString;
@property (nonatomic ,copy)NSString *kdString;
@property (nonatomic ,copy)NSString *btjString;

@property (nonatomic ,assign)NSInteger *tagINtss;

@property (nonatomic ,copy)NSString *zanoutIDString;

@end

@implementation UserCommentsOnViewController

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
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    //设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:self.yhdpString];
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _jiluString = @"aaa";
    _tagINtss = 0;

    [super didReceiveMemoryWarning];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _searchstrArr = [[NSMutableArray alloc]initWithObjects:@"",@"",@"good",@"bad",@"fast_tixian",@"nice_service",@"reliable",@"not_open",@"terrible",@"not_indroduce", nil];
    _allString = @"10";
    _isnewString = @"0";
    _BQButtonArr = [NSMutableArray array];
    _userDPTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64) style:UITableViewStyleGrouped];
    _userDPTableview.delegate = self;
    _userDPTableview.dataSource = self;
    _userDPTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _userDPTableview.showsVerticalScrollIndicator = NO;
    [_userDPTableview registerNib:[UINib nibWithNibName:@"UserCommentCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([UserCommentCell class])];
    [self.view addSubview:_userDPTableview];
    [self getdata];//获取数据

//    [self theLabelView];//标签view
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    return self.resultArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserCommentCell class]) forIndexPath:indexPath];
    [cell updateBiaoQianModel:self.resultArr[indexPath.row]];
    cell.row = indexPath.row;
    cell.delegate = self;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 294*BOScreenH/1334;
    }
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BiaoQianModel *model = self.resultArr[indexPath.row];
    return [model topCommentCellHeight];
    
//    return 670*BOScreenH/1334;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        [self theLabelView];//标签view

        return _bqView;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CommentInsideViewController *commVc = [[CommentInsideViewController alloc]init];
    commVc.hidesBottomBarWhenPushed = YES;
    commVc.pidString = cell.model.pid;
    commVc.outidString = cell.model.pid;
    commVc.outtypeString = @"3";
    commVc.nameString = self.namestring;
    commVc.playKeyboard = @"noplayKeyboard";
    [self.navigationController pushViewController:commVc animated:YES];
}
- (void)userCommentCellDidCilckComment:(UserCommentCell *)cell
{
    CommentInsideViewController *commVc = [[CommentInsideViewController alloc]init];
    commVc.hidesBottomBarWhenPushed = YES;
    commVc.pidString = cell.model.pid;
    commVc.outidString = cell.model.pid;
    commVc.outtypeString = @"3";
    commVc.nameString = self.namestring;
    commVc.playKeyboard = @"playKeyboard";
    [self.navigationController pushViewController:commVc animated:YES];
}
//标签
- (void)theLabelView
{
    _bqView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 224*BOScreenH/1334)];
    _bqView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    
    _whiView = [[UIView alloc]initWithFrame:CGRectMake(0, 16*BOScreenH/1334, BOScreenW, 262*BOScreenH/1334)];
    _whiView.backgroundColor = [UIColor whiteColor];
    [_bqView addSubview:_whiView];
    
    if ([_jiluString isEqual:@"aaa"])
    {
        _hpString = [NSString stringWithFormat:@"好评(%@)",_model.good_sum];
        _cpString = [NSString stringWithFormat:@"差评(%@)",_model.bad_sum];
        _txcString = [NSString stringWithFormat:@"提现快(%@)",_model.fast_tixian_sum];
        _fwhString = [NSString stringWithFormat:@"服务好(%@)",_model.nice_service_sum];
        _kpString = [NSString stringWithFormat:@"靠谱(%@)",_model.reliable_sum];
        _btmString = [NSString stringWithFormat:@"不透明(%@)",_model.not_open_sum];
        _kdString = [NSString stringWithFormat:@"坑爹(%@)",_model.terrible_sum];
        _btjString = [NSString stringWithFormat:@"不推荐(%@)",_model.not_indroduce_sum];
    }
    
    NSArray *arr = @[@"全部",@"最新",_hpString,_cpString,_txcString,_fwhString,_kpString,_btmString,_kdString,_btjString];
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 34*BOScreenH/1334;//用来控制button距离父视图的高
    for (int i = 0; i < arr.count; i++)
    {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.tag = i;
        _button.backgroundColor = [UIColor colorWithHexString:@"#fafbfc" alpha:1];
        [_button setTitleColor:[UIColor colorWithHexString:@"#737373" alpha:1] forState:UIControlStateNormal];
        _button.layer.borderWidth = 1;
        _button.layer.borderColor = [UIColor colorWithHexString:@"#d5d8db" alpha:1].CGColor;
        _button.layer.cornerRadius = 3;
        _button.layer.masksToBounds = YES;
        _button.titleLabel.font = [UIFont systemFontOfSize:12];
        //根据计算文字的大小 //设置所有button的宽高也就是所占大小
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGFloat length = [arr[i] boundingRectWithSize:CGSizeMake(700*BOScreenW/750, 260*BOScreenH/1334) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        //为button赋值
        [_button setTitle:arr[i] forState:UIControlStateNormal];
        //设置button的frame //48*BOScreenW/750可设button的宽度
        _button.frame = CGRectMake(30*BOScreenW/750 + w, h, length + 35*BOScreenW/750, 54*BOScreenH/1334);
        //当button的位置超出屏幕边缘时换行 700*BOScreenW/750 只是button所在父视图的宽度
        if(30*BOScreenW/750 + w + length + 35*BOScreenW/750 > 700*BOScreenW/750)
        {
            w = 0; //换行时将w置为0
            h = h + _button.frame.size.height + 16*BOScreenH/1334;//距离父视图也变化 //行高
            _button.frame = CGRectMake(30*BOScreenW/750 + w, h, length + 35*BOScreenW/750, 54*BOScreenH/1334);//重设button的frame
        }
        //button 之间的距离
        w = _button.frame.size.width + _button.frame.origin.x - 15*BOScreenW/750;
        [_button addTarget:self action:@selector(buttonOfAction:) forControlEvents:UIControlEventTouchUpInside];
        [_whiView addSubview:_button];
        [_BQButtonArr addObject:_button];
        
        
        if (i == _tagINtss)
        {
            [_button setTitleColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] forState:UIControlStateNormal];
            _button.layer.borderColor = [UIColor colorWithHexString:@"#2d84f2" alpha:1].CGColor;
        }
    }
}
- (void)buttonOfAction:(UIButton*)sender
{
    for (UIButton *btn in _BQButtonArr)
    {
        if (btn.tag == sender.tag)
        {
            _tagINtss = sender.tag;
            [btn setTitleColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] forState:UIControlStateNormal];
            btn.layer.borderColor = [UIColor colorWithHexString:@"#2d84f2" alpha:1].CGColor;
        } else
        {
            [btn setTitleColor:[UIColor colorWithHexString:@"#737373" alpha:1] forState:UIControlStateNormal];
            btn.layer.borderColor = [UIColor colorWithHexString:@"#d5d8db" alpha:1].CGColor;
        }
    }

    
    if (sender.tag == 0)
    {
        _allString = _allcountString;
        _isnewString = @"0";
        _searchString = @"";
        [self getdata];
    }else if (sender.tag == 1)
    {
        _isnewString = @"1";
        _allString = @"10";
        _searchString = @"";
        [self getdata];
    }else if (sender.tag > 1)
    {
        _searchString = _searchstrArr[sender.tag];
        _allString = _allcountString;
        _isnewString = @"";
        [self getdata];
    }
}
//接口数据
- (void)getdata
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"ptid"] = self.ptidString;
    parameters[@"start"] = @"0";
    parameters[@"limit"] = self.numberString;
    parameters[@"search_str"] = _searchString;
    parameters[@"is_new"] = _isnewString;
    parameters[@"sid"] = USERSid;
    [manager POST:[NSString stringWithFormat:@"%@WdApi/wdAllDpList",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"hahahahahahahahahahaha%@",responseObject);
        if ([responseObject[@"r"] integerValue] == 1)
        {
            _allcountString = responseObject[@"count"];//后台返回的一共有几条评论
            
            _model = [BiaoQianModel mj_objectWithKeyValues:responseObject[@"sum"]];
            
            self.resultArr = [BiaoQianModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//            NSLog(@"responseObjectsum%@",responseObject[@"data"]);
        
            
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
            [_userDPTableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            
            if ([_jiluString isEqual:@"aaa"])
            {
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
                [_userDPTableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                _jiluString = @"bbb";
            }
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)userCommentCellAlertToLogin:(UserCommentCell *)cell
{
    if (USERUID)
    {
    } else
    {
        //登陆界面
        [self pushToLoginViewController];
    }
}
- (void)pushToLoginViewController
{
    BONoteVerifyLogiin *noteVerifyLoginVC = [[BONoteVerifyLogiin alloc] init];
    noteVerifyLoginVC.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:noteVerifyLoginVC];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:nil];
}
//登陆成功后的代理
- (void)BONoteVerifyLoginViewControllerDidLoginSucess:(BONoteVerifyLogiin *)loginVc
{
    [self getdata];
}
- (void)userCommentCellDidCilckFavour:(UserCommentCell *)cell
{
    _zanoutIDString = cell.model.pid;
    [self zanOfTheData];
}
//赞的接口
- (void)zanOfTheData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"type_id"] = @"5";
    parameters[@"out_id"] = _zanoutIDString;
    [manager POST:[NSString stringWithFormat:@"%@App/star",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            [self getdata];
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}

@end
