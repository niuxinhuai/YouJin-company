//
//  BOChangeNicknameVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOChangeNicknameVC.h"
#import "SVProgressHUD.h"
#import "NSString+Utilities.h"
@interface BOChangeNicknameVC ()<UITextFieldDelegate>
@property (nonatomic, weak) UITextField *textField;

/**记录用户刚开始的昵称*/
@property (nonatomic, copy) NSString *name;

/**记录是否更改了昵称*/
@property (nonatomic, weak) UIButton *rightBtn;

@property (nonatomic, weak) AFHTTPSessionManager *mgr;
@end

@implementation BOChangeNicknameVC
- (void)dealloc {
    NSLog(@"BOChangeNicknameVC");
}
#pragma mark - 懒加载
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BOColor(244, 245, 247);
    // 设置上部的View
    [self setupTopView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // 隐藏底部的tabbar
    //    self.tabBarController.tabBar.hidden = YES;
    
    // 设置navigationItem的左边按钮
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    //    self.navigationItem.leftBarButtonItem = btnItem;
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];

    
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"修改昵称"];
    self.navigationItem.titleView = titleView;
    
    // 设置rightButtonItem
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 20)];
    self.rightBtn = rightBtn;
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"#B3B3B3" alpha:1] forState:UIControlStateDisabled];
    [rightBtn addTarget:self action:@selector(rightBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    rightBtn.enabled = NO;
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 20)];
    [rightView addSubview:rightBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
}
#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 点击右边item按钮的事件
- (void)rightBarButtonItemClick {
    NSString *text = self.textField.text;
    if (!text || text.length == 0) {
        [self toast:@"昵称不能为空" complete:nil];
        return;
    }
    NSString *firstStr = [text substringToIndex:1];
    if ([firstStr isNum] || text.length < 2 || text.length >9 || [text isNum] || ![text judgeLegalCharacter]) {
        [self toast:@"不符合昵称规则" complete:nil];
        return;
    }else {
        if (self.nameChangeBlock) {
            self.nameChangeBlock(self.textField.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
   
}
#pragma mark - 设置上部的View
- (void)setupTopView {
    CGFloat topX = 0;
    CGFloat topY = 8 * BOHeightRate;
    CGFloat topW = BOScreenW;
    CGFloat topH = 45 * BOHeightRate;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(topX, topY, topW, topH)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    // 添加输入框
    CGFloat textX = 15 * BOWidthRate;
    CGFloat textY = 0 * BOHeightRate;
    CGFloat textW = 260 * BOWidthRate;
    CGFloat textH = 45 * BOHeightRate;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(textX, textY, textW, textH)];
    self.textField = textField;
    textField.text = self.nameString;
    self.name = @"柚子_123456";
    textField.delegate = self;
    [textField setFont:[UIFont systemFontOfSize:15]];
    [topView addSubview:textField];
    // 添加删除全部按钮
    CGFloat deleteX = 350 * BOWidthRate;
    CGFloat deleteY = 16 * BOHeightRate;
    CGFloat deleteWH =  13* BOWidthRate;
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(deleteX, deleteY, deleteWH, deleteWH)];
    [deleteBtn setImage:[UIImage imageNamed:@"common_icon_closed"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteAllText) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:deleteBtn];
    // 添加最底部的label
    CGFloat bottomX = 15 * BOWidthRate;
    CGFloat bottomY = CGRectGetMaxY(topView.frame) + 10 * BOHeightRate;
    CGFloat bottomW = 300 * BOWidthRate;
    CGFloat bottomH = 15 * BOHeightRate;
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(bottomX, bottomY, bottomW, bottomH)];
    [bottomLabel setFont:[UIFont systemFontOfSize:11]];
    [bottomLabel setTextColor:[UIColor colorWithHexString:@"#999999" alpha:1]];
    bottomLabel.text = @"请输入2-9个字符,不能以数字开头或者纯数字";
    [self.view addSubview:bottomLabel];
}

#pragma mark - 删除所有的文字
- (void)deleteAllText {
    self.textField.text = nil;
    [self.textField becomeFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.textField.text != self.name && self.textField.text.length > 0) {
        self.rightBtn.enabled = YES;
    }
}


#pragma mark - 判断输入昵称是不是纯数字
- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
@end
