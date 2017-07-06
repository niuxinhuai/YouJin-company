//
//  BOPlatformActivityTableVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/20.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOPlatformActivityTableVC.h"
#import "PlatformActivityCell.h"
#import "BannerWebViewViewController.h"
#import "PlatformActivityModel.h"

static NSString *const ID = @"cell";
@interface BOPlatformActivityTableVC ()

@end

@implementation BOPlatformActivityTableVC
- (NSMutableArray *)platformActivityArrayM {
    if (_platformActivityArrayM == nil) {
        _platformActivityArrayM = [[NSMutableArray alloc] init];
    }
    return _platformActivityArrayM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor redColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"PlatformActivityCell" bundle:nil] forCellReuseIdentifier:ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.platformActivityArrayM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlatformActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.item = self.platformActivityArrayM[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140 * BOScreenH / BOPictureH;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 15*BOScreenH/1334)];
    view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BannerWebViewViewController *webVc = [[BannerWebViewViewController alloc]init];
    PlatformActivityModel *item = self.platformActivityArrayM[indexPath.row];
    NSArray *newArray = [item.url componentsSeparatedByString:@"|"];
    webVc.name = newArray[0];
    webVc.url = newArray[1];
    [self.navigationController pushViewController:webVc animated:YES];
}
@end
