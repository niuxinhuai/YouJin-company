//
//  BOHotPlatformTableVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/20.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOHotPlatformTableVC.h"
#import "HotPlatfromCellTableViewCell.h"
#import "HotdetailsViewController.h"
#import "PeerHonePageModel.h"
static NSString *const ID = @"cell";
@interface BOHotPlatformTableVC ()

@end

@implementation BOHotPlatformTableVC
- (NSMutableArray *)hotPlatformArrayM {
    if (_hotPlatformArrayM == nil) {
        _hotPlatformArrayM = [[NSMutableArray alloc] init];
    }
    return _hotPlatformArrayM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册cell
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[HotPlatfromCellTableViewCell class] forCellReuseIdentifier:ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hotPlatformArrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotPlatfromCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.contentView.width = BOScreenW;
    cell.item = self.hotPlatformArrayM[indexPath.row];
    cell.contentView.clipsToBounds = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95 * BOScreenH / BOPictureH;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotdetailsViewController *hotDetailVc = [[HotdetailsViewController alloc]init];
    PeerHonePageModel *item = self.hotPlatformArrayM[indexPath.row];
    hotDetailVc.ptid = item.ptid;
    hotDetailVc.nameOfPlatform = item.name;
    [self.navigationController pushViewController:hotDetailVc animated:YES];
}
@end
