//
//  hotTopicTableVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "hotTopicTableVC.h"
#import "BODynamicDetailsVC.h"
@interface hotTopicTableVC ()

@end

@implementation hotTopicTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BODynamicDetailsVC *VC = [[BODynamicDetailsVC alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

@end
