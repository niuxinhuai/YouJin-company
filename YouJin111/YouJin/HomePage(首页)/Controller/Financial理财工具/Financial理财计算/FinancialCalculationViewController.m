//
//  FinancialCalculationViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/20.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "FinancialCalculationViewController.h"
#import "UIImage+UIColor.h"
#import "BankFinancingView.h"
#import "PTwoPFinancingView.h"
#import "InterestTableViewController.h"
#import "PickerviewsView.h"
#import "BankFinancialModel.h"
#import "DatePickerView.h"
#import "PtwoPfinancialModel.h"
#import "ChakanViewController.h"
#import "HuankuanlistModel.h"

@interface FinancialCalculationViewController ()<UIGestureRecognizerDelegate,UITextFieldDelegate>
@property (nonatomic ,strong)PTwoPFinancingView *ptwopView;//点击P2P理财显示的view
@property (nonatomic ,strong)BankFinancingView *bankfiView;//点击银行理财显示的view
@property (nonatomic ,copy)NSString *jilustring;//记录是在那个按钮进去的
//银行理财
@property (nonatomic ,strong)PickerviewsView *pickerView;
@property (nonatomic ,strong)NSMutableArray *cunkuanArr;//存款期限的pickerView数据
@property (nonatomic ,copy)NSString *cklimitString;//后台需要的存款期限
@property (nonatomic ,copy)NSString *timetypeString;//后台需要的时间类型
//P2P理财
@property (nonatomic ,strong)DatePickerView *datePickerView;
@property (nonatomic ,strong)NSMutableArray *huankuanArr;//还款方式的pickerView数据
@property (nonatomic ,copy)NSString *yueAndriString;//月和日后台需要的请求参数
@property (nonatomic ,copy)NSString *nianAndriString;//年和日后台需要的请求参数
@property (nonatomic ,copy)NSString *yearDayString;//360 365
@property (nonatomic ,copy)NSString *jkfsString;//还款方式后台需要的参数的请求参数
@property (nonatomic ,strong)PtwoPfinancialModel *model;

@property (nonatomic ,copy)NSString *huoqiStr;
@property (nonatomic ,copy)NSString *dingqiStr;
@property (nonatomic ,copy)NSString *lilvshifobian;

//还款明细
@property (nonatomic ,strong)NSMutableArray *qishuArr;
@property (nonatomic ,strong)NSMutableArray *benjinArr;
@property (nonatomic ,strong)NSMutableArray *lixiArr;
@property (nonatomic ,strong)NSMutableArray *timeendArr;

@end

@implementation FinancialCalculationViewController
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
    
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"理财计算器"];
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    //rightBarButtonItem
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,130*BOScreenW/750,40*BOScreenH/1334)];
//    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightButton setTitle:@"利率表" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithHexString:@"#ffffff" alpha:1] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;//控制整个功能是否启用
    manager.shouldResignOnTouchOutside = YES;//点击背景是否收起键盘
    manager.shouldToolbarUsesTextFieldTintColor = YES;//工具条颜色是否自定义
    manager.shouldShowTextFieldPlaceholder = NO;//中间位置显示占位符
    manager.enableAutoToolbar = YES;//是否显示键盘上的工具条
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager]setEnable:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _qishuArr = [NSMutableArray array];
    _benjinArr = [NSMutableArray array];
    _lixiArr = [NSMutableArray array];
    _timeendArr = [NSMutableArray array];
    _lilvshifobian = @"huoqi";
    _dingqiStr = @"1.50";
    
    _jkfsString = @"2";
    _yearDayString = @"365";
    _nianAndriString = @"y";
    _yueAndriString = @"m";
    _cunkuanArr = [[NSMutableArray alloc]initWithObjects:@"1年",@"2年",@"3年",@"5年",@"3个月",@"6个月", nil];
    _cklimitString = @"1";
    _timetypeString = @"y";
    _huankuanArr = [[NSMutableArray alloc]initWithObjects:@"按月付息到期还本",@"一次性还本付息",@"等额本息", nil];
    //银行理财 和 P2P理财的背景View
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 80*BOScreenH/1334)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#2d84f2" alpha:1];
    [self.view addSubview:bgView];
    //银行理财 和 P2P理财
    UISegmentedControl *segmentCon = [[UISegmentedControl alloc] initWithItems:@[@"银行理财", @"P2P理财"]];
    segmentCon.frame = CGRectMake(174*BOScreenW/750, 4*BOScreenH/1334, 402*BOScreenW/750, 58*BOScreenH/1334);
    segmentCon.selectedSegmentIndex = 0;
    segmentCon.tintColor = [UIColor whiteColor];
    [segmentCon addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventValueChanged];//添加响应方法
    [bgView addSubview:segmentCon];
    
    //点击P2P理财显示的view
    _ptwopView = [[PTwoPFinancingView alloc]initWithFrame:CGRectMake(0, 80*BOScreenH/1334, BOScreenW, BOScreenH)];
    _ptwopView.inputsTextField.delegate = self;
    _ptwopView.monthTextField.delegate = self;
    _ptwopView.yearTextField.delegate = self;
    _ptwopView.cashBackTextField.delegate = self;
    _ptwopView.deductionTextField.delegate = self;
    _ptwopView.feeTextField.delegate = self;
    [_ptwopView.lookButton addTarget:self action:@selector(lookButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_ptwopView.timeButton addTarget:self action:@selector(timeButtonClick) forControlEvents:UIControlEventTouchUpInside];//起息日期的按钮
    [_ptwopView.meansButton addTarget:self action:@selector(meansButtonClick) forControlEvents:UIControlEventTouchUpInside];//还款方式的按钮
    [_ptwopView.monthSegmentCon addTarget:self action:@selector(monthSegmentConSelectItem:) forControlEvents:UIControlEventValueChanged];//添加月 日响应方法
    [_ptwopView.yearSegmentCon addTarget:self action:@selector(yearSegmentConSelectItem:) forControlEvents:UIControlEventValueChanged];//添加年 日响应方法
    [_ptwopView.dayButton addTarget:self action:@selector(dayButtonClick:) forControlEvents:UIControlEventTouchUpInside];//360天制的按钮
    [self.view addSubview:_ptwopView];
    
    //点击银行理财显示的view
    _bankfiView = [[BankFinancingView alloc]initWithFrame:CGRectMake(0, 80*BOScreenH/1334, BOScreenW, BOScreenH)];
    _bankfiView.inputTextField.delegate = self;
    [_bankfiView.yearButton addTarget:self action:@selector(yearButtonClick) forControlEvents:UIControlEventTouchUpInside];//存款期限的按钮
    [_bankfiView.periodSegmentCon addTarget:self action:@selector(periodSegmentConSelectItem:) forControlEvents:UIControlEventValueChanged];//添加响应方法
    [self.view addSubview:_bankfiView];
    
    //pickerview
    _pickerView = [[PickerviewsView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    [_pickerView.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];//取消按钮的点击事件
    [_pickerView.sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];//确定按钮的点击事件
    [[UIApplication sharedApplication].keyWindow addSubview:_pickerView];
    _pickerView.hidden = YES;
    //添加手势单击事件
    UITapGestureRecognizer *Gess = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GesClicks:)];
    Gess.delegate = self;
    Gess.numberOfTapsRequired = 1;
    [_pickerView addGestureRecognizer:Gess];
    
    //DatePickerView
    _datePickerView = [[DatePickerView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    [[UIApplication sharedApplication].keyWindow addSubview:_datePickerView];
    [_datePickerView.sureButtons addTarget:self action:@selector(sureButtonsClick) forControlEvents:UIControlEventTouchUpInside];//确定按钮的点击事件
    [_datePickerView.cancelButtons addTarget:self action:@selector(cancelButtonsClick) forControlEvents:UIControlEventTouchUpInside];
    _datePickerView.hidden = YES;
    //添加手势单击事件
    UITapGestureRecognizer *pkGess = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pkGesClicks:)];
    pkGess.delegate = self;
    pkGess.numberOfTapsRequired = 1;
    [_datePickerView addGestureRecognizer:pkGess];
}
#pragma mark---银行理财 和 P2P理财的点击事件
- (void)selectItem:(UISegmentedControl *)sender
{
    [self.view endEditing:YES];
    if (sender.selectedSegmentIndex == 0)
    {
        self.navigationItem.rightBarButtonItem.customView.hidden = NO;
        _ptwopView.hidden = YES;
        _bankfiView.hidden = NO;
    } else
    {
        self.navigationItem.rightBarButtonItem.customView.hidden = YES;
        _bankfiView.hidden = YES;
        _ptwopView.hidden = NO;
    }
}
#pragma mark---银行理财页面的点击事件---
//存款期限的点击事件
- (void)yearButtonClick
{
    [_bankfiView.inputTextField resignFirstResponder];
    _jilustring = @"1111";
    _pickerView.hidden = NO;
    _pickerView.titleLabel.text = @"存款期限";
    _pickerView.number = _cunkuanArr;
    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
    [_pickerView.payPicView reloadAllComponents];
}
#pragma mark  取消确定按钮点击事件
- (void)cancelButtonClick
{
    _pickerView.hidden = YES;
}
- (void)sureButtonClick
{
    if ([_jilustring  isEqual: @"1111"])
    {
        if (_pickerView.chooseString == nil)
        {
            
        }else
        {
            _bankfiView.yearLabel.text = _pickerView.chooseString;
            if ([_pickerView.chooseString isEqual:@"1年"])
            {
                if ([_lilvshifobian isEqualToString:@"huoqi"])
                {
                    _bankfiView.zeroLabel.text = @"0.35";
                }else
                {
                    _bankfiView.zeroLabel.text = @"1.50";
                }
                
                _dingqiStr = @"1.50";
                
                _cklimitString = @"1";
                _timetypeString = @"y";
            }
            if ([_pickerView.chooseString isEqual:@"2年"])
            {
                if ([_lilvshifobian isEqualToString:@"huoqi"])
                {
                    _bankfiView.zeroLabel.text = @"0.35";
                }else
                {
                    _bankfiView.zeroLabel.text = @"2.10";
                }
                _dingqiStr = @"2.10";

                _cklimitString = @"2";
                _timetypeString = @"y";
            }
            if ([_pickerView.chooseString isEqual:@"3年"])
            {
                if ([_lilvshifobian isEqualToString:@"huoqi"])
                {
                    _bankfiView.zeroLabel.text = @"0.35";
                }else
                {
                    _bankfiView.zeroLabel.text = @"2.75";
                }
                _dingqiStr = @"2.75";

                _cklimitString = @"3";
                _timetypeString = @"y";
            }
            if ([_pickerView.chooseString isEqual:@"5年"])
            {
                if ([_lilvshifobian isEqualToString:@"huoqi"])
                {
                    _bankfiView.zeroLabel.text = @"0.35";
                }else
                {
                    _bankfiView.zeroLabel.text = @"2.75";
                }
                _dingqiStr = @"2.75";

                _cklimitString = @"5";
                _timetypeString = @"y";
            }
            if ([_pickerView.chooseString isEqual:@"3个月"])
            {
                if ([_lilvshifobian isEqualToString:@"huoqi"])
                {
                    _bankfiView.zeroLabel.text = @"0.35";
                }else
                {
                    _bankfiView.zeroLabel.text = @"1.10";
                }

                _dingqiStr = @"1.10";

                _cklimitString = @"3";
                _timetypeString = @"m";
            }
            if ([_pickerView.chooseString isEqual:@"6个月"])
            {
                if ([_lilvshifobian isEqualToString:@"huoqi"])
                {
                    _bankfiView.zeroLabel.text = @"0.35";
                }else
                {
                    _bankfiView.zeroLabel.text = @"1.30";
                }
                _dingqiStr = @"1.30";

                _cklimitString = @"6";
                _timetypeString = @"m";
            }
        }
    }
    if ([_jilustring  isEqual: @"2222"])
    {
        if (_pickerView.chooseString == nil)
        {
            
        }else
        {
            _ptwopView.chooseLabel.text = _pickerView.chooseString;
            if ([_pickerView.chooseString isEqual:@"一次性还本付息"])
            {
                _jkfsString = @"1";
            }
            if ([_pickerView.chooseString isEqual:@"按月付息到期还本"])
            {
                _jkfsString = @"2";
            }
            if ([_pickerView.chooseString isEqual:@"等额本息"])
            {
                _jkfsString = @"3";
            }
        }
    }
    _pickerView.chooseString = nil;
    _pickerView.hidden = YES;
    
    //银行的接口
    [self textFieldtextisemptybank];
    //p2p的接口
    [self textFieldtextisempty];
}
#pragma mark---银行理财数据接口----
- (void)bankFinancingData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"money"] = _bankfiView.inputTextField.text;
    parameters[@"time"] = _cklimitString;
    parameters[@"time_type"] = _timetypeString;
    parameters[@"apr"] = _bankfiView.zeroLabel.text;
    [manager POST:[NSString stringWithFormat:@"%@Common/jisuanqiBank",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            BankFinancialModel *model = [BankFinancialModel mj_objectWithKeyValues:responseObject[@"data"]];
            _bankfiView.theAmountLabel.text = model.lixi;
            _bankfiView.theAmountOfLabel.text = model.benxi;
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
#pragma mark---P2P理财接口数据---
- (void)ptwopData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"money"] = _ptwopView.inputsTextField.text;
    parameters[@"begin"] = _ptwopView.yearsLabel.text;
    parameters[@"time"] = _ptwopView.monthTextField.text;
    parameters[@"time_type"] = _yueAndriString;
    parameters[@"apr"] = _ptwopView.yearTextField.text;
    parameters[@"apr_type"] = _nianAndriString;
    parameters[@"year_days"] = _yearDayString;
    parameters[@"huankuan_type"] = _jkfsString;
    parameters[@"fanxian"] = _ptwopView.cashBackTextField.text;
    parameters[@"dikou"] = _ptwopView.deductionTextField.text;
    parameters[@"guanli_fee"] = _ptwopView.feeTextField.text;
    [manager POST:[NSString stringWithFormat:@"%@Common/jisuanqiWd",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            _model = [PtwoPfinancialModel mj_objectWithKeyValues:responseObject[@"data"]];
            _ptwopView.rateLabel.text = _model.shiji_apr;
            _ptwopView.expectedLabel.text = _model.yuqi;
            
            [_qishuArr removeAllObjects];
            [_benjinArr removeAllObjects];
            [_lixiArr removeAllObjects];
            [_timeendArr removeAllObjects];
            for (HuankuanlistModel *listmodel in _model.huankuan_list)
            {
                [_qishuArr addObject:listmodel.qishu];
                [_benjinArr addObject:listmodel.benjin];
                [_lixiArr addObject:listmodel.lixi];
                [_timeendArr addObject:listmodel.time_end];
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


#pragma mark---p2p理财页面的处理---
//起息日期
- (void)timeButtonClick
{
    [self.view endEditing:YES];
    _datePickerView.hidden = NO;
}
//创建一个PickerView日期格式器 (确定 按钮的点击事件)
- (void)sureButtonsClick
{
    NSDate *selected = [_datePickerView.datePickerView date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    _ptwopView.yearsLabel.text = destDateString;
    _datePickerView.hidden = YES;
}
//取消按钮的点击事件
- (void)cancelButtonsClick
{
    _datePickerView.hidden = YES;
}
//还款方式的点击事件
- (void)meansButtonClick
{
    [self.view endEditing:YES];
    _jilustring = @"2222";
    _pickerView.hidden = NO;
    _pickerView.titleLabel.text = @"还款方式";
    _pickerView.number = _huankuanArr;
    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
    [_pickerView.payPicView reloadAllComponents];
}
#pragma mark---单击手势的代理---
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:_pickerView.buttonView] || [touch.view isDescendantOfView:_pickerView.payPicView] || [touch.view isDescendantOfView:_datePickerView.buttonViews] ||[touch.view isDescendantOfView:_datePickerView.datePickerView])
    {
        return NO;
    }
    return YES;
}

- (void)GesClicks:(UITapGestureRecognizer *)sender
{
    _pickerView.hidden = YES;
}
- (void)pkGesClicks:(UITapGestureRecognizer *)sender
{
    _datePickerView.hidden = YES;
}
#pragma mark---利率表的点击事件---
- (void)rightButtonClick
{
    InterestTableViewController *interVc = [[InterestTableViewController alloc]init];
    [self.navigationController pushViewController:interVc animated:YES];
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//月和日segmen的点击事件
- (void)monthSegmentConSelectItem:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        _yueAndriString = @"m";
    } else
    {
        _yueAndriString = @"d";
    }
    [self textFieldtextisempty];
}
//年和日segmen的点击事件
- (void)yearSegmentConSelectItem:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        _nianAndriString = @"y";
    } else
    {
        _nianAndriString = @"d";
    }
    [self textFieldtextisempty];
}
//360天制的点击按钮事件
- (void)dayButtonClick:(UIButton *)sender
{
    if (sender.selected)
    {
        _yearDayString = @"365";
        [_ptwopView.dayButton setImage:[UIImage imageNamed:@"icon_selectsmall_nor"] forState:UIControlStateNormal];
        sender.selected = NO;
    }else
    {
        _yearDayString = @"360";
        [_ptwopView.dayButton setImage:[UIImage imageNamed:@"icon_selectsmall_pre"] forState:UIControlStateNormal];
        sender.selected = YES;
    }
    [self textFieldtextisempty];
}

#pragma mark ---银行理财------------------------
//活期定期的点击事件
- (void)periodSegmentConSelectItem:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        _lilvshifobian = @"huoqi";
        _bankfiView.zeroLabel.text = @"0.35";
    } else
    {
        _lilvshifobian = @"dingqi";
        _bankfiView.zeroLabel.text = _dingqiStr;
    }
    [self textFieldtextisemptybank];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _bankfiView.inputTextField)
    {
        [self textFieldtextisemptybank];
    }else
    {
        [self textFieldtextisempty];
    }
}

#pragma mark ---p2p理财----------------------------
//判断是否为空输入框
- (void)textFieldtextisempty
{
    if (_ptwopView.inputsTextField.text.length>0&&_ptwopView.monthTextField.text.length>0&&_ptwopView.yearTextField.text.length>0)
    {
        unichar onesingle = [_ptwopView.inputsTextField.text characterAtIndex:0];//当前输入的字符
        unichar twosingle = [_ptwopView.monthTextField.text characterAtIndex:0];//当前输入的字符
        unichar threesingle = [_ptwopView.yearTextField.text characterAtIndex:0];//当前输入的字符
        if (onesingle == '.' || twosingle == '.'|| threesingle == '.')
        {
            NSLog(@"第一个字符不能为点");
        }else
        {
            [self ptwopData];
        }
    }else
    {
        NSLog(@"不能为空");
        _ptwopView.rateLabel.text = @"0";
        _ptwopView.expectedLabel.text = @"0";
    }
}
#pragma mark------银行理财-------
//判断输入框是否为空
- (void)textFieldtextisemptybank
{
    if (_bankfiView.inputTextField.text.length>0)
    {
        unichar single = [_bankfiView.inputTextField.text characterAtIndex:0];//当前输入的字符
        if (single == '.')
        {
            NSLog(@"第一个字符不能为点");
        }else
        {
            [self bankFinancingData];
        }
    }else
    {
        NSLog(@"请输入金额");
        _bankfiView.theAmountLabel.text = @"0";
        _bankfiView.theAmountOfLabel.text = @"0";
    }
}
#pragma mark查看按钮的点击事件----------------
- (void)lookButtonClick
{
    if (_model.huankuan_list.count > 0)
    {
        ChakanViewController *chakanvc = [[ChakanViewController alloc]init];
        chakanvc.benjinString = _model.money;
        chakanvc.yuqishouyiString = _model.yuqi;
        chakanvc.qishuString = [NSString stringWithFormat:@"%lu",(unsigned long)_model.huankuan_list.count];
        chakanvc.lixiString = _model.lixi;
        chakanvc.nianhuaString = _model.shiji_apr;
        chakanvc.daoqishijianString = _model.time_end;
        chakanvc.qishuArray =_qishuArr;
        chakanvc.benjinArray = _benjinArr;
        chakanvc.lixiArray = _lixiArr;
        chakanvc.timeendArray = _timeendArr;
        [self.navigationController pushViewController:chakanvc animated:YES];
    }
}
@end
