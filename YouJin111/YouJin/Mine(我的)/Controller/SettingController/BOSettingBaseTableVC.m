//
//  BOSettingBaseTableVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOSettingBaseTableVC.h"
@interface BOSettingBaseTableVC ()

@end

@implementation BOSettingBaseTableVC


- (NSMutableArray *)groupArray {
    
    if (!_groupArray) {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;
}
- (instancetype)init {
    
    return [super initWithStyle:UITableViewStylePlain];
}

#pragma - mark tableView数据源代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groupArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BOSettingGroupItem *groupItem =  self.groupArray[section];
    return groupItem.rowItemArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1.创建Cell
    BOSettingCell *cell = [BOSettingCell cellWithTableView:tableView style:UITableViewCellStyleValue1];
    
    //2.取出模型
    //取出每一行的行模型
    BOSettingGroupItem *groupItem =  self.groupArray[indexPath.section];
    BORowItem *rowItem = groupItem.rowItemArray[indexPath.row];
    
    //3.把模型给Cell.让Cell展示数据
    cell.rowItem = rowItem;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}

//返加每一组的头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    BOSettingGroupItem *groupItem =  self.groupArray[section];
    return groupItem.HeaderT;
}

//返加每一组的尾部标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    BOSettingGroupItem *groupItem =  self.groupArray[section];
    return groupItem.footerT;
}

//点击Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取当前的行模型
    BOSettingGroupItem *groupItem =  self.groupArray[indexPath.section];
    BORowItem *rowItem = groupItem.rowItemArray[indexPath.row];
    
    if ([rowItem isKindOfClass:[BOSettingArrowItem class]]) {
        
        BOSettingArrowItem *item = (BOSettingArrowItem *)rowItem;
        //判断有没有要执行的任务
        if (item.desTask) {
            //执行任务
            item.desTask(indexPath);
            
            return;
        }
        
        
        //判断有没有要跳转的控制器名称
        if (item.desVCName) {
            //创建控制器
            UIViewController *vc = [[item.desVCName alloc] init];
            //跳转
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
}

@end
