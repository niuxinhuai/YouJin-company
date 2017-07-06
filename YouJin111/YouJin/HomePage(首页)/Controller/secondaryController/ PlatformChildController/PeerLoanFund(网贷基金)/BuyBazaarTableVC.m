//
//  BuyBazaarTableVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/24.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BuyBazaarTableVC.h"
#import "BuyBazaarCell.h"
#import <MJExtension/MJExtension.h>
#import "BuyModel.h"
#import "BuyBazaarViewModel.h"
static NSString *const ID = @"cell";
@interface BuyBazaarTableVC ()<BuyBazaarCellDelegate>

/**模型数组 + Cell高度的数组*/
@property (nonatomic, strong) NSMutableArray *viewModelArray;
@end

@implementation BuyBazaarTableVC
#pragma mark - 懒加载
- (NSMutableArray *)viewModelArray {
    if (_viewModelArray == nil) {
        _viewModelArray = [NSMutableArray array];
    }
    return _viewModelArray;
}
- (NSMutableArray *)buyArrayM {
    if (_buyArrayM == nil) {
        _buyArrayM = [NSMutableArray array];
    }
    return _buyArrayM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册cell
    [self.tableView registerClass:[BuyBazaarCell class] forCellReuseIdentifier:ID];
    
    // 加载plist文件
    [self loadPlist];
}

#pragma mark - 加载plist文件
- (void)loadPlist {
    // 加载对应数组
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"buy.plist" ofType:nil];
    NSArray *tempArray = [NSArray arrayWithContentsOfFile:fileName];
    
    // 字典转模型
    
    NSArray *modelArray= [BuyModel mj_objectArrayWithKeyValuesArray:tempArray];
    
    // 把每个cell的高度保存到数组中
    for (NSInteger i = 0; i < modelArray.count; i++) {
        BuyBazaarViewModel *VM = [[BuyBazaarViewModel alloc] init];
        VM.model = modelArray[i];
        VM.cellH = 90 * BOScreenH / BOPictureH;
        [self.viewModelArray addObject:VM];
    }
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
    BuyBazaarCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.delagete = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BuyBazaarViewModel *VM = self.viewModelArray[indexPath.row];
    return VM.cellH;
}

#pragma mark - BuyBazaarCellDelegate
- (void)buyBazaarCellSpreadBtnClick:(BuyBazaarCell *)buyBazaarCell {
    // 记录当前的cell的indexpath
    NSInteger row = [self.tableView indexPathForCell:buyBazaarCell].row;
    // 取出对应得cell的模型
    BuyBazaarViewModel *VM = self.viewModelArray[row];
    VM.cellH =90 * BOScreenH / BOPictureH + 2 * 30 * BOScreenH / BOPictureH;
    buyBazaarCell.model = VM.model;
    [self.tableView reloadData];
}
- (void)buyBazaarCellSpreadBtnPackupClick:(BuyBazaarCell *)buyBazaarCell {
    // 记录当前cell的indexpath
    NSInteger row = [self.tableView indexPathForCell:buyBazaarCell].row;
    // 取出对应得cell的模型
    BuyBazaarViewModel *VM = self.viewModelArray[row];
    VM.cellH =90 * BOScreenH / BOPictureH;
    [self.tableView reloadData];
}
@end
