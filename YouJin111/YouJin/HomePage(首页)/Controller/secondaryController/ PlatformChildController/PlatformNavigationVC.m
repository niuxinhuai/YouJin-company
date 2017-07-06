//
//  PlatformNavigationVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PlatformNavigationVC.h"
#import "BOLcationButton.h"
#import "HotPlatformTableViewCell.h"
#import "BOPlatformNavigationTableView.h"
static NSString *const ID = @"cell";
static NSString *const backID = @"backCell";
@interface PlatformNavigationVC ()<UITableViewDataSource, UITableViewDelegate>

/**年化的数组 */
@property (nonatomic, strong) NSArray *yearMeltArray;

/**业务类型的数组*/
@property (nonatomic, strong) NSArray *operationArray;

/**背景的数组*/
@property (nonatomic, strong) NSArray *backArray;

/**点击按钮呈现的tableView的数据数组*/
@property (nonatomic, strong) NSArray *tableViewArray;
/**点击头部的按钮的显示的tableView*/
@property (nonatomic, strong) BOPlatformNavigationTableView *platformNavigationTableView;

/** 遮盖View*/
@property (nonatomic, strong) UIView *coverView;

/**被选中的按钮*/
@property (nonatomic, strong) BOLcationButton *selectBtn;
@end

@implementation PlatformNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景颜色
    self.view.backgroundColor = BOColor(244, 245, 247);
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置年化，业务类型，背景的数据数组
    [self setupDataArray];
    // 设置navigationItem
    [self setupNavigationItem];
    // 设置topView
    [self setupTopView];
    // 设置tableView
    [self setupTableView];
}
#pragma mark - 更改选中的按钮
- (void)changeSelectBtn: (BOLcationButton *)button {
    _selectBtn.selected = NO;
    if (_selectBtn != button) {
        [self setSelectBtn:button];
    }else if (_selectBtn == button) {
        [self.platformNavigationTableView removeFromSuperview];
        [self.coverView removeFromSuperview];
        _selectBtn = nil;
    }
}
- (void)setSelectBtn:(BOLcationButton *)selectBtn {
    _selectBtn = selectBtn;
    _selectBtn.selected = YES;
    
}
#pragma mark - 点击事件添加的tableView和遮盖View的懒加载
- (BOPlatformNavigationTableView *)platformNavigationTableView {
    if (_platformNavigationTableView == nil) {
        _platformNavigationTableView = [[BOPlatformNavigationTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _platformNavigationTableView.dataSource = self;
        _platformNavigationTableView.delegate = self;
        [_platformNavigationTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:backID];
    }
    return _platformNavigationTableView;
}
- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 40 * BOScreenH / BOPictureH, BOScreenW, BOScreenH - 64 - 40 * BOScreenH / BOPictureH)];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.5;
        
        // 添加点按手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
        [_coverView addGestureRecognizer:tapGesture];
    }
    return _coverView;
}
#pragma mark - 年化，业务类型，背景的数据数组，tableVIew的数组的懒加载
- (NSArray *)yearMeltArray {
    if (_yearMeltArray == nil) {
        _yearMeltArray = [NSArray array];
    }
    return _yearMeltArray;
}
- (NSArray *)operationArray {
    if (_operationArray == nil) {
        _operationArray = [NSArray array];
    }
    return _operationArray;
}
- (NSArray *)backArray {
    if (_backArray == nil) {
        _backArray = [NSArray array];
    }
    return _backArray;
}
- (NSArray *)tableViewArray {
    if (_tableViewArray == nil) {
        _tableViewArray = [NSArray array];
    }
    return _tableViewArray;
}
#pragma mark - 设置年化，业务类型，背景的数据数组
- (void)setupDataArray {
    self.yearMeltArray = [NSArray arrayWithObjects:@"全部区间", @"8%以下", @"8%-12%", @"12%-16%", @"16%-20%", @"20%以上", nil];
    self.operationArray = [NSArray arrayWithObjects:@"全部类型", @"车贷", @"房贷", @"企业贷", @"优选理财", @"票据抵押", @"融资租赁", @"藏品质押", @"供应链金融", @"个人信用贷", nil];
    self.backArray = [NSArray arrayWithObjects:@"全部背景", @"银行系", @"上市系", @"国资系", @"风投系", nil];
}
#pragma mark - 设置navigationItem
- (void)setupNavigationItem {
    // 设置navigationItem的左边按钮
    UIBarButtonItem *leftBtnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(backToLevel)];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    // 设置标题
    self.title = @"平台导航";
    // 设置navigationItem的右边按钮
    UIBarButtonItem *rightBtnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"icon_search"] highImage:[UIImage imageNamed:@"icon_search"] target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
}
#pragma mark - 返回上一级
- (void)backToLevel {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 设置topView
- (void)setupTopView {
    
    // 创建一个topView
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 40 * BOScreenH / BOPictureH)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    CGFloat btnW = 0.25 * BOScreenW;
    CGFloat btnY = 0;
    CGFloat btnX = 0;
    CGFloat btnH = 40 * BOScreenH / BOPictureH;
    CGFloat viewH = 24 * BOScreenH / BOPictureH;
    // 创建所在地区的按钮
    BOLcationButton *firstBtn = [[BOLcationButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
    [firstBtn addTarget:self action:@selector(firstBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [firstBtn setTitle:@"所在地区 " forState:UIControlStateNormal];
    [firstBtn setImage:[UIImage imageNamed:@"common_icon_xiala"] forState:UIControlStateNormal];
    [firstBtn setImage:[UIImage imageNamed:@"common_icon_xiala_h"] forState:UIControlStateSelected];
    [firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [firstBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [firstBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(firstBtn.frame) - 1, 0.5 * (btnH - viewH), 1, viewH)];
    lineView.backgroundColor = BOColor(235, 236, 237);
    [topView addSubview:lineView];
    // 创建年化的按钮
    BOLcationButton *secondBtn = [[BOLcationButton alloc] initWithFrame:CGRectMake(1 * btnW, btnY, btnW, btnH)];
    [secondBtn addTarget:self action:@selector(secondBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [secondBtn setTitle:@"年化 " forState:UIControlStateNormal];
    [secondBtn setImage:[UIImage imageNamed:@"common_icon_xiala"] forState:UIControlStateNormal];
    [secondBtn setImage:[UIImage imageNamed:@"common_icon_xiala_h"] forState:UIControlStateSelected];
    [secondBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [secondBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [secondBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(secondBtn.frame) - 1, 0.5 * (btnH - viewH), 1, viewH)];
    lineView2.backgroundColor = BOColor(235, 236, 237);
    [topView addSubview:lineView2];
    // 创建业务类型的按钮
    BOLcationButton *thirdBtn = [[BOLcationButton alloc] initWithFrame:CGRectMake(2 * btnW, btnY, btnW, btnH)];
    [thirdBtn addTarget:self action:@selector(thirdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [thirdBtn setTitle:@"业务类型 " forState:UIControlStateNormal];
    [thirdBtn setImage:[UIImage imageNamed:@"common_icon_xiala"] forState:UIControlStateNormal];
    [thirdBtn setImage:[UIImage imageNamed:@"common_icon_xiala_h"] forState:UIControlStateSelected];
    [thirdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [thirdBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [thirdBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(thirdBtn.frame) - 1, 0.5 * (btnH - viewH), 1, viewH)];
    lineView3.backgroundColor = BOColor(235, 236, 237);
    [topView addSubview:lineView3];
    // 创建背景的按钮
    BOLcationButton *fourthBtn = [[BOLcationButton alloc] initWithFrame:CGRectMake(3 * btnW, btnY, btnW, btnH)];
    [fourthBtn addTarget:self action:@selector(fourthBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [fourthBtn setTitle:@"背景 " forState:UIControlStateNormal];
    [fourthBtn setImage:[UIImage imageNamed:@"common_icon_xiala"] forState:UIControlStateNormal];
    [fourthBtn setImage:[UIImage imageNamed:@"common_icon_xiala_h"] forState:UIControlStateSelected];
    [fourthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fourthBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [fourthBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(fourthBtn.frame) - 1, 0.5 * (btnH - viewH), 1, viewH)];
    lineView4.backgroundColor = BOColor(235, 236, 237);
    [topView addSubview:lineView4];
    
    [topView addSubview:firstBtn];
    [topView addSubview:secondBtn];
    [topView addSubview:thirdBtn];
    [topView addSubview:fourthBtn];
}
#pragma mark - 处理所在地区，年化，业务类型，背景的按钮点击事件
//处理所在地区按钮的点击事件
- (void)firstBtnClick: (BOLcationButton *)btn {
    
}
// 处理年化按钮的点击事件
- (void)secondBtnClick: (BOLcationButton *)btn {
    // 添加遮盖View
    [self.view addSubview:self.coverView];
    // 添加点击事件触发显示的tableView
    [self.view addSubview:self.platformNavigationTableView];
    // 给tableView的数据源数组赋值
    self.tableViewArray = self.yearMeltArray;
    self.platformNavigationTableView.frame = CGRectMake(0, 40 * BOScreenH / BOPictureH, BOScreenW, self.tableViewArray.count * 45 * BOScreenH / BOPictureH);
    [self changeSelectBtn:btn];
    [self.platformNavigationTableView reloadData];
}
// 处理业务类型按钮的点击事件
- (void)thirdBtnClick: (BOLcationButton *)btn {
    // 添加遮盖View
    [self.view addSubview:self.coverView];
    // 添加点击事件触发显示的tableView
    [self.view addSubview:self.platformNavigationTableView];
    // 给tableView的数据源数组赋值
    self.tableViewArray = self.operationArray;
    self.platformNavigationTableView.frame = CGRectMake(0, 40 * BOScreenH / BOPictureH, BOScreenW, self.tableViewArray.count * 45 * BOScreenH / BOPictureH);
    [self changeSelectBtn:btn];
    [self.platformNavigationTableView reloadData];
}
// 处理背景的按钮的点击事件
- (void)fourthBtnClick: (BOLcationButton *)btn {
    // 添加遮盖View
    [self.view addSubview:self.coverView];
    // 添加点击事件触发显示的tableView
    [self.view addSubview:self.platformNavigationTableView];
    // 给tableView的数据源数组赋值
    self.tableViewArray = self.backArray;
    self.platformNavigationTableView.frame = CGRectMake(0, 40 * BOScreenH / BOPictureH, BOScreenW, self.tableViewArray.count * 45 * BOScreenH / BOPictureH);
    [self changeSelectBtn:btn];
    [self.platformNavigationTableView reloadData];
}
#pragma mark - 移除遮盖View和显现的tableView
- (void)removeView {
    [self.platformNavigationTableView removeFromSuperview];
    [self.coverView removeFromSuperview];
    [self changeSelectBtn:_selectBtn];
}
#pragma mark - 设置tabbelView
- (void)setupTableView {
    // 创建tableView，并设置其代理和数据源
    CGFloat tableViewX = 0;
    CGFloat tableViewW = BOScreenW;
    CGFloat tableViewY = 40 * BOScreenH / BOPictureH + 1;
    CGFloat tableViewH = BOScreenH - 64 - 40 * BOScreenH / BOPictureH;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    [tableView registerNib:[UINib nibWithNibName:@"HotPlatformTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
    tableView.dataSource = self;
    tableView.delegate = self;
}

#pragma mark - 设置tableView的数据源协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isKindOfClass:[BOPlatformNavigationTableView class]]) {
        return [self.tableViewArray count];
    }else {
        return 6;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isKindOfClass:[BOPlatformNavigationTableView class]]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:backID forIndexPath:indexPath];
        cell.textLabel.text = self.tableViewArray[indexPath.row];
        [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
        return cell;
    }else {
        HotPlatformTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isKindOfClass:[BOPlatformNavigationTableView class]]) {
        return 45 * BOScreenH / BOPictureH;
    }
    return 140;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 移除按钮点击显示的tableView和遮盖View
    [self.platformNavigationTableView removeFromSuperview];
    [self.coverView removeFromSuperview];
    [self changeSelectBtn:_selectBtn];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
