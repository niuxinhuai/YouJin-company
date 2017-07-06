//
//  LendMoneyDetailVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/13.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "LendMoneyDetailVC.h"
#import "UIImage+UIColor.h"
#import "BOSetupTitleView.h"
#import "LendMoneyDetailTopView.h"
#import "LendRefundRateView.h"
#import "LendMoneyDeadlineLoanView.h"
#import "LendMoneyApplyForConditionView.h"
#import "DetailNoPictureCellTableViewCell.h"
#import "DetailOnePictureCell.h"
#import "DetailOtherPictureCell.h"
#import <MJExtension/MJExtension.h>
#import "BODynamicItem.h"
#import "PlatformDetailViewModel.h"
#import "LendMoneyDetailModel.h"
#import "BannerWebViewViewController.h"
#import "PickerviewsView.h"

static NSString *const NOPictureID = @"noPicturecell";
static NSString *const OnePictureID = @"onePicturecell";
static NSString *const OtherPictureID = @"otherPicturecell";
@interface LendMoneyDetailVC ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIScrollView *lendMoneyDetailScrollView;
/** 申请条件的titleView*/
@property (nonatomic, weak) UIView *applyTitleView;
/** 最新点评的titleView*/
@property (nonatomic, weak) UIView *CommentTitleView;
/**根据文字大小以及行距计算出的行高*/
@property (nonatomic, assign) CGFloat lineHeight;

@property (nonatomic, strong) NSMutableArray *detailVM;
/**记录tableView的高度*/
@property (nonatomic, assign) CGFloat detailHeight;
/**底部的tableView*/
@property (nonatomic, weak) UITableView *detailTableView;
@property (nonatomic, strong) UITableViewCell *cell;

/**底部申请借款的View*/
@property (nonatomic, weak) UIView *bottomView;

/**scrollView滚动offestY*/
@property (nonatomic, assign) CGFloat offestY;

@property (nonatomic, weak) AFHTTPSessionManager *mgr;

/**保存model*/
@property (nonatomic, strong) LendMoneyDetailModel *model;

/**记录当前的y*/
@property (nonatomic, assign) CGFloat currentY;

@property (nonatomic, weak) LendMoneyApplyForConditionView *lendMoneyApplyForConditionView;

@property (nonatomic ,strong)UIView *reviewView;//上传第一条点评
@property (nonatomic ,strong)PickerviewsView *pickerView;
@property (nonatomic ,copy)NSString *jilustring;//记录是在那个按钮进去的
@property (nonatomic ,strong)NSMutableArray *muArray;
@property (nonatomic ,strong)LendMoneyDeadlineLoanView *lendMoneyDeadlineView;
@property (nonatomic ,strong)NSMutableArray *tempsss;
@property (nonatomic ,copy)NSString *moneyString;
@property (nonatomic ,copy)NSString *monthString;
@property (nonatomic ,strong)LendRefundRateView *lendRefundRateView;

@end

@implementation LendMoneyDetailVC
#pragma mark - 懒加载dynamicVM
- (NSMutableArray *)detailVM {
    if (_detailVM == nil) {
        _detailVM = [NSMutableArray array];
    }
    return _detailVM;
}
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}
#pragma mark - 懒加载首页ScrollView
- (UIScrollView *)lendMoneyDetailScrollView {
    if (_lendMoneyDetailScrollView == nil) {
        _lendMoneyDetailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH - 64)];
        _lendMoneyDetailScrollView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
        _lendMoneyDetailScrollView.showsVerticalScrollIndicator = NO;
        _lendMoneyDetailScrollView.delegate = self;
        [self.view addSubview:_lendMoneyDetailScrollView];
    }
    return  _lendMoneyDetailScrollView;
}
#pragma mark - 在View即将显示的时候设置navigationBar和隐藏tabbar
- (void)viewWillAppear:(BOOL)animated {
    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // 隐藏底部的tabbar
    self.tabBarController.tabBar.hidden = YES;
    
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    //    self.navigationItem.leftBarButtonItem = btnItem;
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    
    // 设置头部的标题的View
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:self.name];
    self.navigationItem.titleView = titleView;
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tempsss = [NSMutableArray array];
    _muArray = [NSMutableArray array];
    _moneyString = @"5000";
    _monthString = @"1";
    [self requstNetData];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    // 从plist中加载测试数据
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DynamicView.plist" ofType:nil]];
    NSArray *tempArray = [BODynamicItem mj_objectArrayWithKeyValuesArray:dictArray];
    // 遍历数组获取数据
    for (BODynamicItem *item in tempArray) {
        PlatformDetailViewModel *VM = [[PlatformDetailViewModel alloc] init];
        VM.item = item;
        self.detailHeight += VM.cellH;
        [self.detailVM addObject:VM];
    }
   
    //pickerview
    _pickerView = [[PickerviewsView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    [_pickerView.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];//取消按钮的点击事件
    [_pickerView.sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];//确定按钮的点击事件
    [self.navigationController.view addSubview:_pickerView];
    _pickerView.hidden = YES;
    //添加手势单击事件
    UITapGestureRecognizer *Gess = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GesClicks:)];
    Gess.delegate = self;
    Gess.numberOfTapsRequired = 1;
    [_pickerView addGestureRecognizer:Gess];
}
#pragma mark  取消确定按钮点击事件
- (void)cancelButtonClick
{
    _pickerView.hidden = YES;
}
- (void)sureButtonClick
{
    NSLog(@"choose%@",_pickerView.chooseString);
    if ([_jilustring  isEqual: @"111"])
    {
        if (_pickerView.chooseString == nil)
        {
            
        }else
        {
            [_lendMoneyDeadlineView.jiekuanButton setTitle:_pickerView.chooseString forState:UIControlStateNormal];
            _moneyString = _pickerView.chooseString;
            [self meiyuehuankuanData];
        }
    }
    if ([_jilustring  isEqual: @"222"])
    {
        if (_pickerView.chooseString == nil)
        {
            
        }else
        {
            [_lendMoneyDeadlineView.yueButton setTitle:[NSString stringWithFormat:@"%@月",_pickerView.chooseString] forState:UIControlStateNormal];
            _monthString = _pickerView.chooseString;
            [self meiyuehuankuanData];
        }
    }
    _pickerView.chooseString = nil;
    _pickerView.hidden = YES;
}
//借款按钮的点击事件
- (void)jiekuanButtonClick
{
    _pickerView.hidden = NO;
    _jilustring = @"111";
    _pickerView.titleLabel.text = @"借款金额";
    _pickerView.number = _muArray;
    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
    [_pickerView.payPicView reloadAllComponents];
}
//分期期限的点击事件
- (void)yuClick
{
    _pickerView.hidden = NO;
    _jilustring = @"222";
    _pickerView.titleLabel.text = @"分期期限";
    _pickerView.number = _tempsss;
    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
    [_pickerView.payPicView reloadAllComponents];

}
//得到借钱金额数字的数组
-(NSMutableArray*)test:(NSInteger)min  max:(NSInteger)max
{
    _muArray=[NSMutableArray arrayWithCapacity:20];
    NSInteger temp=min;
    while (temp<=max) {
        [_muArray addObject:[NSString stringWithFormat: @"%ld",(long)temp]];
        temp+=1000;
    }
//    NSLog(@"muArray%@",_muArray);
    return _muArray;
}
#pragma mark---单击手势的方法---
- (void)GesClicks:(UITapGestureRecognizer *)sender
{
    _pickerView.hidden = YES;
}
#pragma mark---单击手势的代理---
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:_pickerView.buttonView] || [touch.view isDescendantOfView:_pickerView.payPicView])
    {
        return NO;
    }
    return YES;
}
//每月还款的数据
- (void)meiyuehuankuanData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"money"] = _moneyString;
    parameters[@"month"] = _monthString;
    parameters[@"apr"] = _model.month_apr;
    [manager POST:[NSString stringWithFormat:@"%@WdApi/huankuanInfo",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            _lendRefundRateView.refundNumLabel.text = responseObject[@"data"];
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}








#pragma mark - 加载网络数据
- (void)requstNetData {
    NSString *url = [NSString stringWithFormat:@"%@Borrow/getBorrowInfo",BASEURL];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"at"] = tokenString;
    dictionary[@"brid"] = self.brid;
    
    [self.mgr POST:url parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"responseObjectjjjjjjj%@",responseObject);
        self.model = [LendMoneyDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self meiyuehuankuanData];//借款计算的接口
        //得到借款金额的数字数组
        [self test:[self.model.min_limit integerValue] max:[self.model.max_limit integerValue]];
        //得到分期期限
        if (self.model.fenqi_limit.length > 0)
        {
            NSString *str2 = self.model.fenqi_limit;
            _tempsss = [str2 componentsSeparatedByString:@","];
        }
        // 添加scrollView的子控件
        [self addScrollViewChildView];
        // 注册三种不同的cell
        [self.detailTableView registerClass:[DetailNoPictureCellTableViewCell class] forCellReuseIdentifier:NOPictureID];
        [self.detailTableView registerClass:[DetailOnePictureCell class] forCellReuseIdentifier:OnePictureID];
        [self.detailTableView registerClass:[DetailOtherPictureCell class] forCellReuseIdentifier:OtherPictureID];
        // 添加底部的申请贷款View
        [self setupBottomApplyforLoan];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 添加scrollView的子控件
- (void)addScrollViewChildView {
    // 添加顶部的View
    [self setupTopView];
    // 添加中部的每月还款，参考月利率，最快放款时间
    [self setupRefundRateLoanTimeView];
    // 添加借款金额，分期期限的View
    [self setupLendMoneyDeadlineView];
    // 设置申请条件的头部View
    [self setupApplyTitleView];
    // 设置申请条件的View
    [self setupApplyForView];
//    // 设置最新的点评的头部View
//    [self setupNewCommentTitleView];
//    // 根据后台是否有点评调用
//    [self setupUpFirstComment];
    // 设置底部的tableVIew
//    [self setupBottomTabView];
}
#pragma mark - 设置头部的View
- (void)setupTopView {
    LendMoneyDetailTopView *topView = [[LendMoneyDetailTopView alloc] init];
    topView.item = self.model;
    topView.frame = CGRectMake(0, 0, BOScreenW, 176 * BOHeightRate);
    topView.backgroundColor = [UIColor colorWithHexString:@"#2d84f2" alpha:1];
    [self.lendMoneyDetailScrollView addSubview:topView];
}

#pragma mark - 设置中部的每月还款，参考月利率，最快放款时间
- (void)setupRefundRateLoanTimeView {
    _lendRefundRateView = [[LendRefundRateView alloc] initWithFrame:CGRectMake(0, 176 * BOHeightRate, BOScreenW, 120 * BOHeightRate)];
    _lendRefundRateView.backgroundColor = [UIColor whiteColor];
    _lendRefundRateView.item = self.model;
    [self.lendMoneyDetailScrollView addSubview:_lendRefundRateView];
}

#pragma mark - 设置借款金额，分期期限的View
- (void)setupLendMoneyDeadlineView {
    _lendMoneyDeadlineView = [[LendMoneyDeadlineLoanView alloc] init];
    _lendMoneyDeadlineView.frame = CGRectMake(15 * BOWidthRate, 136 * BOHeightRate, BOScreenW - 30 * BOWidthRate, 80 * BOHeightRate);
    [_lendMoneyDeadlineView.jiekuanButton addTarget:self action:@selector(jiekuanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_lendMoneyDeadlineView.yueButton addTarget:self action:@selector(yuClick) forControlEvents:UIControlEventTouchUpInside];
    _lendMoneyDeadlineView.backgroundColor = [UIColor whiteColor];

    _lendMoneyDeadlineView.item = self.model;

    [self.lendMoneyDetailScrollView addSubview:_lendMoneyDeadlineView];
}
#pragma mark - 设置申请条件的头部View
- (void)setupApplyTitleView {
    UIView *applyTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 304 * BOScreenH / BOPictureH, BOScreenW, 40 * BOScreenH / BOPictureH)];
    self.applyTitleView = applyTitleView;
    applyTitleView.backgroundColor = [UIColor whiteColor];
    [self.lendMoneyDetailScrollView addSubview:applyTitleView];
    // 设置指示器
    UIView *indicateView = [[UIView alloc] initWithFrame:CGRectMake(0, 11.5 * BOScreenH / BOPictureH, 5 * BOScreenW / BOPictureW, 17 * BOScreenH / BOPictureH)];
    indicateView.backgroundColor = [UIColor colorWithHexString:@"#4697FB" alpha:1];
    [applyTitleView addSubview:indicateView];
    
    // 添加热门借钱产品的lable
    UILabel *commentLable = [[UILabel alloc] init];
    commentLable.frame = CGRectMake(15 * BOScreenW / BOPictureW, 10 * BOScreenH / BOPictureH, 100 * BOScreenW / BOPictureW, 20 * BOScreenH / BOPictureH);
    commentLable.text = @"申请条件";
    [commentLable setFont:[UIFont systemFontOfSize:15]];
    [applyTitleView addSubview:commentLable];
    
}
#pragma mark - 设置申请条件的View
- (void)setupApplyForView {
    LendMoneyApplyForConditionView *lendMoneyApplyForConditionView = [[LendMoneyApplyForConditionView alloc] init];
    self.lendMoneyApplyForConditionView = lendMoneyApplyForConditionView;
    [lendMoneyApplyForConditionView setBackgroundColor:[UIColor whiteColor]];
    lendMoneyApplyForConditionView.item = self.model;
    lendMoneyApplyForConditionView.frame = CGRectMake(0, 345 * BOHeightRate, BOScreenW, lendMoneyApplyForConditionView.currentY);
    [self.lendMoneyDetailScrollView addSubview:lendMoneyApplyForConditionView];
    self.lendMoneyDetailScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.lendMoneyApplyForConditionView.frame)+49);
}
#pragma mark - 设置最新点评的头部View
- (void)setupNewCommentTitleView {
    UIView *CommentTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lendMoneyApplyForConditionView.frame) + 8 * BOHeightRate, BOScreenW, 40 * BOScreenH / BOPictureH)];
    self.CommentTitleView = CommentTitleView;
    CommentTitleView.backgroundColor = [UIColor whiteColor];
    [self.lendMoneyDetailScrollView addSubview:CommentTitleView];
    // 设置指示器
    UIView *indicateView = [[UIView alloc] initWithFrame:CGRectMake(0, 11.5 * BOScreenH / BOPictureH, 5 * BOScreenW / BOPictureW, 17 * BOScreenH / BOPictureH)];
    indicateView.backgroundColor = [UIColor colorWithHexString:@"#4697FB" alpha:1];
    [CommentTitleView addSubview:indicateView];
    
    // 添加热门借钱产品的lable
    UILabel *commentLable = [[UILabel alloc] init];
    commentLable.frame = CGRectMake(15 * BOScreenW / BOPictureW, 10 * BOScreenH / BOPictureH, 100 * BOScreenW / BOPictureW, 20 * BOScreenH / BOPictureH);
    commentLable.text = @"用户点评";
    [commentLable setFont:[UIFont systemFontOfSize:15]];
    [CommentTitleView addSubview:commentLable];

}
#pragma mark - 如果点评数为0，设置上传第一条点评的View
- (void)setupUpFirstComment {
    //上传第一条点评view
    CGFloat commentsViewY = CGRectGetMaxY(self.CommentTitleView.frame) + 1;
    _reviewView = [[UIView alloc]initWithFrame:CGRectMake(0, commentsViewY, BOScreenW, 200*BOScreenH/1334)];
    _reviewView.backgroundColor = [UIColor whiteColor];
    [self.lendMoneyDetailScrollView addSubview:_reviewView];
    
    //上传第一条点评button
    UIButton *commentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentsButton.frame = CGRectMake(235*BOScreenW/750, 64*BOScreenH/1334, 280*BOScreenW/750, 72*BOScreenH/1334);
    [commentsButton setTitle:@" 上传第1条点评" forState:UIControlStateNormal];
    [commentsButton setImage:[UIImage imageNamed:@"icon_dianping_dark"] forState:UIControlStateNormal];
    [commentsButton setTitleColor:[UIColor colorWithHexString:@"#333333" alpha:1] forState:UIControlStateNormal];
    commentsButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [commentsButton.layer setMasksToBounds:YES];
    [commentsButton.layer setCornerRadius:4];
    [commentsButton.layer setBorderWidth:1.0];
    commentsButton.layer.borderColor = [UIColor colorWithHexString:@"#999999" alpha:1].CGColor;
    [_reviewView addSubview:commentsButton];
    
    self.lendMoneyDetailScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.reviewView.frame));
    self.lendMoneyDetailScrollView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
}
#pragma mark - 设置底部的tableView
- (void)setupBottomTabView {
    CGFloat tableX = 0;
    CGFloat tableY = CGRectGetMaxY(self.CommentTitleView.frame) + 1;
    CGFloat tableW = BOScreenW;
    CGFloat tableH = self.detailHeight + 40 * BOScreenH / BOPictureH;
    UITableView *detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(tableX, tableY, tableW, tableH) style:UITableViewStyleGrouped];
    self.detailTableView = detailTableView;
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    detailTableView.scrollEnabled = NO;
    [self.lendMoneyDetailScrollView addSubview:detailTableView];
    
    // 设置scrollView的contsize
    self.lendMoneyDetailScrollView.contentSize = CGSizeMake(0, tableY + self.detailHeight + 40 * BOScreenH / BOPictureH);
    self.lendMoneyDetailScrollView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailVM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlatformDetailViewModel *cellVM = self.detailVM[indexPath.row];
    if ([cellVM.item.picture_number integerValue] == 0) {
        DetailNoPictureCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NOPictureID forIndexPath:indexPath];
        cell.VM = self.detailVM[indexPath.row];
        _cell = cell;
        
    }else if ([cellVM.item.picture_number integerValue] == 1) {
        DetailOnePictureCell *cell = [tableView dequeueReusableCellWithIdentifier:OnePictureID forIndexPath:indexPath];
        cell.VM = self.detailVM[indexPath.row];
        _cell = cell;
    }else if ([cellVM.item.picture_number integerValue] > 0){
        DetailOtherPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:OtherPictureID forIndexPath:indexPath];
        cell.VM = self.detailVM[indexPath.row];
        _cell = cell;
    }
    return self.cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.detailVM[indexPath.row] cellH];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CGFloat moreVX = 0;
    CGFloat moreVY = 0;
    CGFloat moreVW = BOScreenW;
    CGFloat moreVH = 40 * BOScreenH / BOPictureH;
    UIView *lookMoreView = [[UIView alloc] initWithFrame:CGRectMake(moreVX, moreVY, moreVW, moreVH)];
    lookMoreView.backgroundColor = [UIColor whiteColor];
    // 在该View中添加查看更多的btn
    CGFloat lookX = (BOScreenW - 80 * BOScreenW / BOPictureW) * 0.5;
    CGFloat lookY = 10 * BOScreenH / BOPictureH;
    CGFloat lookW = 80 * BOScreenW / BOPictureW;
    CGFloat lookH = 20 * BOScreenH / BOPictureH;
    UIButton *lookMoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(lookX, lookY, lookW, lookH)];
    [lookMoreBtn setTitle:@"查看更多评论" forState:UIControlStateNormal];
    [lookMoreBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [lookMoreBtn setTitleColor:BOColor(155, 156, 157) forState:UIControlStateNormal];
    [lookMoreView addSubview:lookMoreBtn];
    return lookMoreView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40 * BOScreenH / BOPictureH;
}

#pragma mark - 添加最底部的申请借款View
- (void)setupBottomApplyforLoan {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, BOScreenH - 113, BOScreenW, 49)];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"#2d84f2" alpha:1];
    self.bottomView = bottomView;
    [self.view addSubview:bottomView];
    // 添加申请借款的button
    UIButton *loanBtn = [[UIButton alloc] initWithFrame:CGRectMake((BOScreenW - 150 * BOWidthRate) * 0.5, 7, 150, 35)];
    [loanBtn setImage:[UIImage imageNamed:@"icon_sqjk"] forState:UIControlStateNormal];
    [loanBtn setTitle:@"立即申请" forState:UIControlStateNormal];
    [loanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loanBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [loanBtn addTarget:self action:@selector(loanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:loanBtn];
}
#pragma mark---立即申请的点击事件---
- (void)loanBtnClick
{
    BannerWebViewViewController *vc = [[BannerWebViewViewController alloc]init];
    vc.name = _model.name;
    vc.url = _model.link_url;
    [self.navigationController pushViewController:vc animated:YES];
}
//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView.contentOffset.y > self.offestY) {
//        self.bottomView.hidden = YES;
//        self.offestY = scrollView.contentOffset.y;
//    }else if (scrollView.contentOffset.y < self.offestY) {
//        self.bottomView.hidden = NO;
//    }
//}
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    self.bottomView.hidden = NO;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
