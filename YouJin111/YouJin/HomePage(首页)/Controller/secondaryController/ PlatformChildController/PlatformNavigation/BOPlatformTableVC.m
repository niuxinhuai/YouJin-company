//
//  BOPlatformTableVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOPlatformTableVC.h"
#import "PlatformNewsCell.h"
static NSString *const ID = @"cell";
@interface BOPlatformTableVC ()

@end

@implementation BOPlatformTableVC
- (NSMutableArray *)platformNewsArrayM {
    if (_platformNewsArrayM == nil) {
        _platformNewsArrayM = [NSMutableArray array];
    }
    return _platformNewsArrayM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 注册对应的cell
    [self.tableView registerNib:[UINib nibWithNibName:@"PlatformNewsCell" bundle:nil] forCellReuseIdentifier:ID];
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
    return self.platformNewsArrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlatformNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.item = self.platformNewsArrayM[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100 * BOScreenH / BOPictureH;
}

@end
