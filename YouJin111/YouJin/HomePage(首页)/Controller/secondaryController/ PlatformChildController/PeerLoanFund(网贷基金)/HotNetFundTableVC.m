//
//  HotNetFundTableVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/24.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HotNetFundTableVC.h"
#import "HotNetFundCell.h"

static NSString *const ID = @"cell";
@interface HotNetFundTableVC ()

@end

@implementation HotNetFundTableVC
#pragma mark - 懒加载
- (NSMutableArray *)hotArrayM {
    if (_hotArrayM == nil) {
        _hotArrayM = [NSMutableArray array];
    }
    return _hotArrayM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[HotNetFundCell class] forCellReuseIdentifier:ID];
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

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotNetFundCell *cell = [tableView dequeueReusableCellWithIdentifier:ID  forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220 * BOScreenH / BOPictureH;
}
@end
