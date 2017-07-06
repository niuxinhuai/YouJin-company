//
//  MortgageCalculationViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/20.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "MortgageCalculationViewController.h"
#import "UIImage+UIColor.h"
#import "BusinessView.h"
#import "AccumulationView.h"
#import "CombinationView.h"
#import "TheLatestTableViewController.h"
#import "PickerviewsView.h"
#import "MortgageModel.h"

@interface MortgageCalculationViewController ()<UIGestureRecognizerDelegate,UITextFieldDelegate>
@property (nonatomic ,strong)BusinessView *busiView;//商业贷款的View
@property (nonatomic ,strong)AccumulationView *accView;//公积金贷款的View
@property (nonatomic ,strong)CombinationView *comView;//组合贷款的View
@property (nonatomic ,strong)PickerviewsView *pickerView;
//商业贷款
@property (nonatomic ,strong)NSMutableArray *nianxianArr;//贷款年限的数据
@property (nonatomic ,strong)NSMutableArray *sylilvArr;//商业贷款利率
@property (nonatomic ,copy)NSString *jilustring;//记录是在那个按钮进去的
@property (nonatomic ,copy)NSString *daikuannianxian;//贷款年限
@property (nonatomic ,copy)NSString *daikuanlilv;//贷款利率
@property (nonatomic ,copy)NSString *dengebenxi;//等额本息等额本金

//公积金贷款
@property (nonatomic ,strong)NSMutableArray *jijinLilvArr;//利率
@property (nonatomic ,copy)NSString *jijindaikuannianxian;//贷款年限
@property (nonatomic ,copy)NSString *jijindaikuanlilv;//贷款利率
@property (nonatomic ,copy)NSString *jijindengebenxi;//等额本息等额本金

//组合贷款
@property (nonatomic ,copy)NSString *zuhedaikuannianxian;//贷款年限
@property (nonatomic ,copy)NSString *zuhesydaikuanlilv;//商业贷款利率
@property (nonatomic ,copy)NSString *zuhejjdaikuanlilv;//公积金贷款利率
@property (nonatomic ,copy)NSString *zuhedengebenxi;//等额本息等额本金

//记录是5年还是以上
@property (nonatomic ,copy)NSString *sywunian;
@property (nonatomic ,copy)NSString *jjwunian;
@property (nonatomic ,copy)NSString *zhwunian;

@end

@implementation MortgageCalculationViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];

    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"房贷计算器"];
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

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    _nianxianArr = [[NSMutableArray alloc]initWithObjects:@"5",@"10",@"15",@"20",@"25",@"30", nil];
    _sylilvArr = [[NSMutableArray alloc]initWithObjects:@"基础利率",@"9.5折",@"9折",@"8.8折",@"8.5折",@"8.3折",@"8折",@"7折",@"1.05倍",@"1.1倍",@"1.2倍",@"1.3倍", nil];
    _jijinLilvArr = [[NSMutableArray alloc]initWithObjects:@"基础利率",@"1.1倍", nil];
    //商业贷款
    _daikuannianxian = @"5";
    _daikuanlilv = @"4.75";
    _dengebenxi = @"1";
    //公积金贷款
    _jijindaikuannianxian = @"5";
    _jijindaikuanlilv = @"2.75";
    _jijindengebenxi = @"1";
    //组合贷款
    _zuhedaikuannianxian = @"5";
    _zuhesydaikuanlilv = @"4.75";
    _zuhejjdaikuanlilv = @"2.75";
    _zuhedengebenxi = @"1";
    
    //商业贷款  积金贷款  组合贷款的背景View
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenH, 80*BOScreenH/1334)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#2d84f2" alpha:1];
    [self.view addSubview:bgView];
    //商业贷款  积金贷款  组合贷款
    UISegmentedControl *segmentCon = [[UISegmentedControl alloc] initWithItems:@[@"商业贷款", @"公积金贷款",@"组合贷款"]];
    segmentCon.frame = CGRectMake(74*BOScreenW/750, 4*BOScreenH/1334, 602*BOScreenW/750, 58*BOScreenH/1334);
    segmentCon.selectedSegmentIndex = 0;
    segmentCon.tintColor = [UIColor whiteColor];
    [segmentCon addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventValueChanged];//添加响应方法
    [bgView addSubview:segmentCon];
    
    //公积金贷款的View
    _accView = [[AccumulationView alloc]initWithFrame:CGRectMake(0, 80*BOScreenH/1334, BOScreenW, BOScreenH)];
    _accView.jijininputTextF.delegate = self;
    [_accView.jijinNianbutton addTarget:self action:@selector(jijinNianbuttonClick) forControlEvents:UIControlEventTouchUpInside];//贷款年限
    [_accView.jijinlilvbutton addTarget:self action:@selector(jijinlilvbuttonClick) forControlEvents:UIControlEventTouchUpInside];//贷款利率
    [_accView.jijinperiodSegmentCon addTarget:self action:@selector(jijinperiodSegmentConItem:) forControlEvents:UIControlEventValueChanged];//等额本息等额本金
    [self.view addSubview:_accView];
    
    //组合贷款的View
    _comView = [[CombinationView alloc]initWithFrame:CGRectMake(0, 80*BOScreenH/1334, BOScreenW, BOScreenH)];
    _comView.zuhesyinputTextF.delegate = self;
    _comView.zuhejjinputsTextF.delegate = self;
    [_comView.zuhearrowButton addTarget:self action:@selector(zuhearrowButtonClick) forControlEvents:UIControlEventTouchUpInside];//贷款年限
    [_comView.zuhesyLilvButton addTarget:self action:@selector(zuhesyLilvButtonClick) forControlEvents:UIControlEventTouchUpInside];//商业利率
    [_comView.zuhejjlilvButton addTarget:self action:@selector(zuhejjlilvButtonClick) forControlEvents:UIControlEventTouchUpInside];//公积金利率
    [_comView.zuheperiodSegmentCon addTarget:self action:@selector(zuheperiodSegmentConItem:) forControlEvents:UIControlEventValueChanged];//等额本息等额本金
    [self.view addSubview:_comView];
    
    //商业贷款的View
    _busiView = [[BusinessView alloc]initWithFrame:CGRectMake(0, 80*BOScreenH/1334, BOScreenW, BOScreenH)];
    _busiView.inputTextF.delegate = self;
    [_busiView.yearButton addTarget:self action:@selector(yearButtonClick) forControlEvents:UIControlEventTouchUpInside];//贷款年限的点击事件
    [_busiView.syllbutton addTarget:self action:@selector(syllbuttonClick) forControlEvents:UIControlEventTouchUpInside];//贷款利率
    [_busiView.periodSegmentCon addTarget:self action:@selector(periodSegmentConSelectItem:) forControlEvents:UIControlEventValueChanged];//等额本息等额本金
    [self.view addSubview:_busiView];
    
    //pickerview
    _pickerView = [[PickerviewsView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    [_pickerView.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];//取消按钮的点击事件
    [_pickerView.sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];//确定按钮的点击事件
//    [self.navigationController.view addSubview:_pickerView];
    [[UIApplication sharedApplication].keyWindow addSubview:_pickerView];
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
            _busiView.arrowLabel.text = [NSString stringWithFormat:@"%@年",_pickerView.chooseString];
            if ([_pickerView.chooseString integerValue] > 5)
            {
                _sywunian = @"dayuwunian";
                _busiView.arrowsLabel.text = @"4.90";
                _daikuanlilv = _busiView.arrowsLabel.text;
            }else
            {
                _sywunian = @"dengyuwunian";
                _busiView.arrowsLabel.text = @"4.75";
                _daikuanlilv = _busiView.arrowsLabel.text;
            }
            _daikuannianxian = _pickerView.chooseString;
        }
    }
    if ([_jilustring  isEqual: @"222"])
    {
        if (_pickerView.chooseString == nil)
        {
            
        }else
        {
            if ([_pickerView.chooseString isEqualToString:@"基础利率"])
            {
                if ([_sywunian isEqualToString:@"dayuwunian"])
                {
                    _busiView.arrowsLabel.text = @"4.90";
                }else
                {
                    _busiView.arrowsLabel.text = @"4.75";
                }
            }else if ([_pickerView.chooseString isEqualToString:@"1.05倍"])
            {
                if ([_sywunian isEqualToString:@"dayuwunian"])
                {
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.90*1.05];
                }else
                {
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.75*1.05];
                }
            }else if ([_pickerView.chooseString isEqualToString:@"1.1倍"])
            {
                if ([_sywunian isEqualToString:@"dayuwunian"])
                {
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.90*1.1];
                }else
                {
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.75*1.1];
                }
            }else if ([_pickerView.chooseString isEqualToString:@"1.2倍"])
            {
                if ([_sywunian isEqualToString:@"dayuwunian"])
                {
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.90*1.2];
                }else
                {
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.75*1.2];
                }
            }
            else if ([_pickerView.chooseString isEqualToString:@"1.3倍"])
            {
                if ([_sywunian isEqualToString:@"dayuwunian"])
                {
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.90*1.3];
                }else
                {
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.75*1.3];
                }
            }else
            {
                if ([_sywunian isEqualToString:@"dayuwunian"])
                {
                    NSArray *newArray = [_pickerView.chooseString componentsSeparatedByString:@"折"];
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",0.49*[newArray[0]floatValue]];
                }else
                {
                    NSArray *newArray = [_pickerView.chooseString componentsSeparatedByString:@"折"];
                    _busiView.arrowsLabel.text = [NSString stringWithFormat:@"%.3f",0.475*[newArray[0]floatValue]];
                }
            }
            _daikuanlilv = _busiView.arrowsLabel.text;
        }
    }
    if ([_jilustring  isEqual: @"333"])
    {
        if (_pickerView.chooseString == nil)
        {
        }else
        {
            _accView.jijinarrowLabel.text = [NSString stringWithFormat:@"%@年",_pickerView.chooseString];
            _jijindaikuannianxian = _pickerView.chooseString;
            
            if ([_pickerView.chooseString integerValue] > 5)
            {
                _jjwunian = @"jjdayuwunian";
                _accView.jijinarrowsLabel.text = @"3.25";
                _jijindaikuanlilv = _accView.jijinarrowsLabel.text;
            }else
            {
                _jjwunian = @"jjdengyuwunian";
                _accView.jijinarrowsLabel.text = @"2.75";
                _jijindaikuanlilv = _accView.jijinarrowsLabel.text;
            }
        }
    }
    if ([_jilustring  isEqual: @"444"])
    {
        if (_pickerView.chooseString == nil)
        {
            
        }else
        {
            if ([_pickerView.chooseString isEqualToString:@"基础利率"])
            {
                if ([_jjwunian isEqualToString:@"jjdayuwunian"])
                {
                    _accView.jijinarrowsLabel.text = @"3.25";
                }else
                {
                    _accView.jijinarrowsLabel.text = @"2.75";
                }
            }else if ([_pickerView.chooseString isEqualToString:@"1.1倍"])
            {
                if ([_jjwunian isEqualToString:@"jjdayuwunian"])
                {
                    _accView.jijinarrowsLabel.text = [NSString stringWithFormat:@"%.3f",3.25*1.1];
                }else
                {
                    _accView.jijinarrowsLabel.text = [NSString stringWithFormat:@"%.3f",2.75*1.1];
                }
            }
            _jijindaikuanlilv = _accView.jijinarrowsLabel.text;
        }
    }
    if ([_jilustring  isEqual: @"555"])
    {
        if (_pickerView.chooseString == nil)
        {
        }else
        {
            _comView.zuhearrowLabel.text = [NSString stringWithFormat:@"%@年",_pickerView.chooseString];
            _zuhedaikuannianxian = _pickerView.chooseString;
            
            if ([_pickerView.chooseString integerValue] > 5)
            {
                _zhwunian = @"zhdayewunian";
                _comView.zuhearrowsLabel.text = @"4.90";
                _zuhesydaikuanlilv = _comView.zuhearrowsLabel.text;
                _comView.zuhearrowsLabels.text = @"3.25";
                _zuhejjdaikuanlilv = _comView.zuhearrowsLabels.text;
            }else
            {
                _zhwunian = @"zhdengyuwunian";
                _comView.zuhearrowsLabel.text = @"4.75";
                _zuhesydaikuanlilv = _comView.zuhearrowsLabel.text;
                _comView.zuhearrowsLabels.text = @"2.75";
                _zuhejjdaikuanlilv = _comView.zuhearrowsLabels.text;
            }

        }
    }
    if ([_jilustring  isEqual: @"666"])
    {
        if (_pickerView.chooseString == nil)
        {
            
        }else
        {
            if ([_pickerView.chooseString isEqualToString:@"基础利率"])
            {
                if ([_zhwunian isEqualToString:@"zhdayewunian"])
                {
                    _comView.zuhearrowsLabel.text = @"4.90";
                }else
                {
                    _comView.zuhearrowsLabel.text = @"4.75";
                }
            }else if ([_pickerView.chooseString isEqualToString:@"1.05倍"])
            {
                if ([_zhwunian isEqualToString:@"zhdayewunian"])
                {
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.9*1.05];
                }else
                {
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.75*1.05];
                }
            }else if ([_pickerView.chooseString isEqualToString:@"1.1倍"])
            {
                if ([_zhwunian isEqualToString:@"zhdayewunian"])
                {
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.9*1.1];
                }else
                {
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.75*1.1];
                }
            }else if ([_pickerView.chooseString isEqualToString:@"1.2倍"])
            {
                if ([_zhwunian isEqualToString:@"zhdayewunian"])
                {
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.9*1.2];
                }else
                {
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.75*1.2];
                }
            }
            else if ([_pickerView.chooseString isEqualToString:@"1.3倍"])
            {
                if ([_zhwunian isEqualToString:@"zhdayewunian"])
                {
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.9*1.3];
                }else
                {
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",4.75*1.3];
                }
            }else
            {
                if ([_zhwunian isEqualToString:@"zhdayewunian"])
                {
                    NSArray *newArray = [_pickerView.chooseString componentsSeparatedByString:@"折"];
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",0.49*[newArray[0] floatValue]];
                }else
                {
                    NSArray *newArray = [_pickerView.chooseString componentsSeparatedByString:@"折"];
                    _comView.zuhearrowsLabel.text = [NSString stringWithFormat:@"%.3f",0.475*[newArray[0] floatValue]];
                }
              
            }
            _zuhesydaikuanlilv = _comView.zuhearrowsLabel.text;
        }
    }
    if ([_jilustring  isEqual: @"777"])
    {
        if (_pickerView.chooseString == nil)
        {
            
        }else
        {
            if ([_pickerView.chooseString isEqualToString:@"基础利率"])
            {
                if ([_zhwunian isEqualToString:@"zhdayewunian"])
                {
                    _comView.zuhearrowsLabels.text = @"3.25";
                }else
                {
                    _comView.zuhearrowsLabels.text = @"2.75";
                }
            }else if ([_pickerView.chooseString isEqualToString:@"1.1倍"])
            {
                if ([_zhwunian isEqualToString:@"zhdayewunian"])
                {
                    _comView.zuhearrowsLabels.text = [NSString stringWithFormat:@"%.3f",3.25*1.1];
                }else
                {
                    _comView.zuhearrowsLabels.text = [NSString stringWithFormat:@"%.3f",2.75*1.1];
                }
            }
            _zuhejjdaikuanlilv = _comView.zuhearrowsLabels.text;
        }
    }



    _pickerView.chooseString = nil;
    _pickerView.hidden = YES;
    
    //房贷计算器的接口
    [self sytextfieldiskong];
    //公积金贷款的接口
    [self gjjtextfieldiskong];
    //组合贷款的接口
    [self zhtextfieldiskong];
}
#pragma mark --商业贷款的点击事件处理
#pragma mar--贷款年限的点击事件
- (void)yearButtonClick
{
    [_busiView.inputTextF resignFirstResponder];
    _pickerView.hidden = NO;
    _jilustring = @"111";
    _pickerView.titleLabel.text = @"贷款年限(年)";
    _pickerView.number = _nianxianArr;
    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
    [_pickerView.payPicView reloadAllComponents];
}
- (void)syllbuttonClick
{
    [_busiView.inputTextF resignFirstResponder];
    _pickerView.hidden = NO;
    _jilustring = @"222";
    _pickerView.titleLabel.text = @"商业贷款利率(%)";
    _pickerView.number = _sylilvArr;
    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
    [_pickerView.payPicView reloadAllComponents];
}
#pragma mark---商业贷款  积金贷款  组合贷款的点击事件
- (void)selectItem:(UISegmentedControl *)sender
{
    [self.view endEditing:YES];
    if (sender.selectedSegmentIndex == 0)
    {
        _comView.hidden = YES;
        _accView.hidden = YES;
        _busiView.hidden = NO;
    }
    if (sender.selectedSegmentIndex == 1)
    {
        _accView.hidden = NO;
        _busiView.hidden = YES;
        _comView.hidden = YES;
    }
    if (sender.selectedSegmentIndex == 2)
    {
        _comView.hidden = NO;
        _busiView.hidden = YES;
        _accView.hidden = YES;
    }
}
#pragma mark---利率表的点击事件---
- (void)rightButtonClick
{
    TheLatestTableViewController *lateVc = [[TheLatestTableViewController alloc]init];
    [self.navigationController pushViewController:lateVc animated:YES];
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
#pragma mark---商业贷款 接口和输入框代理---
//房贷计算器的接口
- (void)fangdaijiekou
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"type"] = @"1";
    parameters[@"money"] = [NSString stringWithFormat:@"%f",[_busiView.inputTextF.text floatValue]*10000];
    parameters[@"money_t"] = @"0";
    parameters[@"years"] = _daikuannianxian;
    parameters[@"apr"] = _daikuanlilv;
    parameters[@"apr_t"] = @"0";
    parameters[@"daikuan_type"] = _dengebenxi;
    [manager POST:[NSString stringWithFormat:@"%@Common/jisuanqiFangdai",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            MortgageModel *model = [MortgageModel mj_objectWithKeyValues:responseObject[@"data"]];
            
            _busiView.moneyLabel.text = model.max;
            UILabel *dijianLabel = (UILabel *)[self.view viewWithTag:603];
            dijianLabel.text = model.dijian;
            UILabel *lixiLabel = (UILabel *)[self.view viewWithTag:604];
            lixiLabel.text = model.lixi;
            UILabel *zongeLabel = (UILabel *)[self.view viewWithTag:605];
            zongeLabel.text = model.sum;
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _busiView.inputTextF)
    {
        [self sytextfieldiskong];
    }
   
    if (textField == _accView.jijininputTextF)
    {
        [self gjjtextfieldiskong];
    }
    
    if (textField == _comView.zuhesyinputTextF || _comView.zuhejjinputsTextF)
    {
        [self zhtextfieldiskong];
    }
}
//等额本息等额本金的点击事件
- (void)periodSegmentConSelectItem:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        _dengebenxi = @"1";
    } else
    {
        _dengebenxi = @"2";
    }
    [self sytextfieldiskong];
}


#pragma mark---公积金贷款---
//贷款年限的点击事件
- (void)jijinNianbuttonClick
{
    [_accView.jijininputTextF resignFirstResponder];
    _pickerView.hidden = NO;
    _jilustring = @"333";
    _pickerView.titleLabel.text = @"贷款年限(年)";
    _pickerView.number = _nianxianArr;
    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
    [_pickerView.payPicView reloadAllComponents];
}
//贷款利率的点击事件
- (void)jijinlilvbuttonClick
{
    [_accView.jijininputTextF resignFirstResponder];
    _pickerView.hidden = NO;
    _jilustring = @"444";
    _pickerView.titleLabel.text = @"公积金贷款利率(%)";
    _pickerView.number = _jijinLilvArr;
    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
    [_pickerView.payPicView reloadAllComponents];
}
//公积金贷款的接口
- (void)jijinfangdaijiekou
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"type"] = @"2";
    parameters[@"money"] = [NSString stringWithFormat:@"%f",[_accView.jijininputTextF.text floatValue]*10000];
    parameters[@"money_t"] = @"0";
    parameters[@"years"] = _jijindaikuannianxian;
    parameters[@"apr"] = _jijindaikuanlilv;
    parameters[@"apr_t"] = @"0";
    parameters[@"daikuan_type"] = _jijindengebenxi;
    [manager POST:[NSString stringWithFormat:@"%@Common/jisuanqiFangdai",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            MortgageModel *model = [MortgageModel mj_objectWithKeyValues:responseObject[@"data"]];
            _accView.jijinmoneyLabel.text = model.max;
            UILabel *dijianLabel = (UILabel *)[self.view viewWithTag:703];
            dijianLabel.text = model.dijian;
            UILabel *lixiLabel = (UILabel *)[self.view viewWithTag:704];
            lixiLabel.text = model.lixi;
            UILabel *zongeLabel = (UILabel *)[self.view viewWithTag:705];
            zongeLabel.text = model.sum;
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
//等额本息等额本金的点击事件
- (void)jijinperiodSegmentConItem:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        _jijindengebenxi = @"1";
    } else
    {
        _jijindengebenxi = @"2";
    }
    [self gjjtextfieldiskong];
}

#pragma mark -- 组合贷款------------------
//贷款年限的点击事件
- (void)zuhearrowButtonClick
{
    [self.view endEditing:YES];
    _pickerView.hidden = NO;
    _jilustring = @"555";
    _pickerView.titleLabel.text = @"贷款年限(年)";
    _pickerView.number = _nianxianArr;
    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
    [_pickerView.payPicView reloadAllComponents];
}
//商业利率的点击事件
- (void)zuhesyLilvButtonClick
{
    [self.view endEditing:YES];
    _pickerView.hidden = NO;
    _jilustring = @"666";
    _pickerView.titleLabel.text = @"商业贷款利率(%)";
    _pickerView.number = _sylilvArr;
    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
    [_pickerView.payPicView reloadAllComponents];
}
//公积金利率的点击事件
- (void)zuhejjlilvButtonClick
{
    [self.view endEditing:YES];
    _pickerView.hidden = NO;
    _jilustring = @"777";
    _pickerView.titleLabel.text = @"公积金贷款利率(%)";
    _pickerView.number = _jijinLilvArr;
    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
    [_pickerView.payPicView reloadAllComponents];
}
//组合贷款的接口
- (void)zuhefangdaijiekou
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"type"] = @"3";
    parameters[@"money"] = [NSString stringWithFormat:@"%f",[_comView.zuhesyinputTextF.text floatValue]*10000];
    parameters[@"money_t"] = [NSString stringWithFormat:@"%f",[_comView.zuhejjinputsTextF.text floatValue]*10000];
    parameters[@"years"] = _zuhedaikuannianxian;
    parameters[@"apr"] = _zuhesydaikuanlilv;
    parameters[@"apr_t"] = _zuhejjdaikuanlilv;
    parameters[@"daikuan_type"] = _zuhedengebenxi;
    [manager POST:[NSString stringWithFormat:@"%@Common/jisuanqiFangdai",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            MortgageModel *model = [MortgageModel mj_objectWithKeyValues:responseObject[@"data"]];
            _comView.zuhemoneyLabel.text = model.max;
            UILabel *dijianLabel = (UILabel *)[self.view viewWithTag:803];
            dijianLabel.text = model.dijian;
            UILabel *lixiLabel = (UILabel *)[self.view viewWithTag:804];
            lixiLabel.text = model.lixi;
            UILabel *zongeLabel = (UILabel *)[self.view viewWithTag:805];
            zongeLabel.text = model.sum;
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
//等额本息等额本金的点击事件
- (void)zuheperiodSegmentConItem:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        _zuhedengebenxi = @"1";
    } else
    {
        _zuhedengebenxi = @"2";
    }
    [self zhtextfieldiskong];
}
#pragma mark  --- 商业贷款判断输入框是否为空-------------
- (void)sytextfieldiskong
{
    if (_busiView.inputTextF.text.length>0)
    {
        unichar single = [_busiView.inputTextF.text characterAtIndex:0];//当前输入的字符
        if (single == '.')
        {
            NSLog(@"第一个字符不能为点");
        }else
        {
            [self fangdaijiekou];
        }
    }else
    {
        NSLog(@"请输入金额");
        _busiView.moneyLabel.text = @"0";
        UILabel *dijianLabel = (UILabel *)[self.view viewWithTag:603];
        dijianLabel.text = @"0";
        UILabel *lixiLabel = (UILabel *)[self.view viewWithTag:604];
        lixiLabel.text = @"0";
        UILabel *zongeLabel = (UILabel *)[self.view viewWithTag:605];
        zongeLabel.text = @"0";
    }
}
#pragma mark  --- 公积金贷款判断输入框是否为空-------------
- (void)gjjtextfieldiskong
{
    if (_accView.jijininputTextF.text.length>0)
    {
        unichar single = [_accView.jijininputTextF.text characterAtIndex:0];//当前输入的字符
        if (single == '.')
        {
            NSLog(@"第一个字符不能为点");
        }else
        {
            [self jijinfangdaijiekou];
        }
    }else
    {
        NSLog(@"请输入金额");
        _accView.jijinmoneyLabel.text = @"0";
        UILabel *dijianLabel = (UILabel *)[self.view viewWithTag:703];
        dijianLabel.text = @"0";
        UILabel *lixiLabel = (UILabel *)[self.view viewWithTag:704];
        lixiLabel.text = @"0";
        UILabel *zongeLabel = (UILabel *)[self.view viewWithTag:705];
        zongeLabel.text = @"0";
    }
}
#pragma mark  --- 组合款判断输入框是否为空-------------
- (void)zhtextfieldiskong
{
    //组合贷款
    if (_comView.zuhesyinputTextF.text.length>0&&_comView.zuhejjinputsTextF.text.length>0)
    {
        unichar single = [_comView.zuhesyinputTextF.text characterAtIndex:0];//当前输入的字符
        unichar singles = [_comView.zuhejjinputsTextF.text characterAtIndex:0];//当前输入的字符
        if (single == '.' || singles == '.')
        {
            NSLog(@"第一个字符不能为点");
        }else
        {
            [self zuhefangdaijiekou];
        }
    }else
    {
        _comView.zuhemoneyLabel.text = @"0";
        UILabel *dijianLabel = (UILabel *)[self.view viewWithTag:803];
        dijianLabel.text = @"0";
        UILabel *lixiLabel = (UILabel *)[self.view viewWithTag:804];
        lixiLabel.text = @"0";
        UILabel *zongeLabel = (UILabel *)[self.view viewWithTag:805];
        zongeLabel.text = @"0";
    }
}

@end
