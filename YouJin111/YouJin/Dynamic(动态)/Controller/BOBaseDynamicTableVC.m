//
//  BOBaseDynamicTableVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOBaseDynamicTableVC.h"
#import "BODynamicContentTableViewCell.h"
#import "BOOnePictureTableViewCell.h"
#import "BOFourPictureTableViewCell.h"
#import "BOOtherPictureTableViewCell.h"
#import "BODynamicItem.h"
#import "BODynamicViewModel.h"

static NSString *const NOPictureID = @"noPicturecell";
static NSString *const OnePictureID = @"onePicturecell";
static NSString *const FourPictureID = @"fourPicturecell";
static NSString *const OtherPictureID = @"otherPicturecell";
@interface BOBaseDynamicTableVC ()

@property (nonatomic, strong) UITableViewCell *cell;
@property (nonatomic, strong) NSMutableArray *dynamicVM;
@end

@implementation BOBaseDynamicTableVC

#pragma mark - 懒加载dynamicVM
- (NSMutableArray *)dynamicVM {
    if (_dynamicVM == nil) {
        _dynamicVM = [NSMutableArray array];
    }
    return _dynamicVM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 注册四种不同的cell
    [self.tableView registerClass:[BODynamicContentTableViewCell class] forCellReuseIdentifier:NOPictureID];
    [self.tableView registerClass:[BOOnePictureTableViewCell class] forCellReuseIdentifier:OnePictureID];
    [self.tableView registerClass:[BOFourPictureTableViewCell class] forCellReuseIdentifier:FourPictureID];
    [self.tableView registerClass:[BOOtherPictureTableViewCell class] forCellReuseIdentifier:OtherPictureID];
    // 从plist中加载测试数据
//    NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DynamicView.plist" ofType:nil]];
//    NSArray *tempArray = [BODynamicItem mj_objectArrayWithKeyValuesArray:dictArray];
//    // 遍历数组获取数据
//    for (BODynamicItem *item in tempArray) {
//        BODynamicViewModel *VM = [[BODynamicViewModel alloc] init];
//        VM.item = item;
//        self.tableViewHeight += VM.cellH;
//        [self.dynamicVM addObject:VM];
//    }
    self.tableViewHeight += 8 * BOHeightRate * _dynamicVM.count;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _dynamicVM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BODynamicViewModel *cellVM = _dynamicVM[indexPath.section];
    if ([cellVM.item.picture_number integerValue] == 0) {
        BODynamicContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NOPictureID forIndexPath:indexPath];
        cell.VM = _dynamicVM[indexPath.section];
        _cell = cell;
        
    }else if ([cellVM.item.picture_number integerValue] == 1) {
        BOOnePictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OnePictureID forIndexPath:indexPath];
        cell.VM = _dynamicVM[indexPath.section];
        _cell = cell;
    }else if ([cellVM.item.picture_number integerValue] == 4) {
        BOFourPictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FourPictureID forIndexPath:indexPath];
        cell.VM = _dynamicVM[indexPath.section];
        _cell = cell;
    }else if ([cellVM.item.picture_number integerValue] > 0){
        BOOtherPictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OtherPictureID forIndexPath:indexPath];
        cell.VM = _dynamicVM[indexPath.section];
        _cell = cell;
    }
    return self.cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_dynamicVM[indexPath.section] cellH];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8 * BOHeightRate;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    BODynamicDetailsVC *VC = [[BODynamicDetailsVC alloc] init];
//    self.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:VC animated:YES];
//}
@end
