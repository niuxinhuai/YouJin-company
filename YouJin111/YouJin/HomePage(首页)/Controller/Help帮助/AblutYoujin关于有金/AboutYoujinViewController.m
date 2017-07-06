//
//  AboutYoujinViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "AboutYoujinViewController.h"
#import "HotIssueTableViewCell.h"
#import "AboutYoujindetailViewController.h"

@interface AboutYoujinViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)NSMutableArray *youjinArr;
@property (nonatomic ,strong)NSMutableArray *youjindetailArr;
@end

@implementation AboutYoujinViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = self.titleviewstr;
    _youjinArr = [NSMutableArray arrayWithObjects:@"有金是什么？", @"如何登录有金？",@"登录有金提示密码错误怎么办？",@"昵称设置规则？", nil];
    _youjindetailArr = [NSMutableArray arrayWithObjects:@"你好，有金是柚今科技旗下国内首个专注金融点评的APP，是金融与社交相结合的产品。", @"你好，目前登录有金有以下三个方法：1、通过手机号码登录，2、通过微信、微博、QQ第三方账号登录。",@"你好，如忘记密码您可以使用验证码登录，在设置中根据页面提示操作重置密码即可。",@"你好，昵称最多可设置7个汉字或15个字符，可设置含有中文、英文、数字组合的昵称，但不建议设置特殊符号。", nil];
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:self.titleviewstr];
//    // 设置leftButtonItem
//    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
//    self.navigationItem.leftBarButtonItem = btnItem;
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    [self.view addSubview:bgView];
    
    UITableView *hotTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 16*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334*self.numberArr.count) style:UITableViewStylePlain];
    hotTableView.delegate = self;
    hotTableView.dataSource = self;
    hotTableView.scrollEnabled = NO;
    [self.view addSubview:hotTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.numberArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90*BOScreenH/1334;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellString = @"cell";
    UINib *nib = [UINib nibWithNibName:@"HotIssueTableViewCell" bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:cellString];
    
    HotIssueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[HotIssueTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.problemLabel.text = self.numberArr[indexPath.row];
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AboutYoujindetailViewController *aboutDetailVc = [[AboutYoujindetailViewController alloc]init];
    aboutDetailVc.titleViewString = self.titleviewstr;
    aboutDetailVc.problomString = self.numberArr[indexPath.row];
    aboutDetailVc.detailString = self.detailArr[indexPath.row];
    [self.navigationController pushViewController:aboutDetailVc animated:YES];
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
