//
//  HeadLineBaseViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/18.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HeadLineBaseViewController.h"
#import "HeadLineDetailViewController.h"
#import "GoldMainViewController.h"
#import "BannerWebViewViewController.h"

@interface HeadLineBaseViewController ()

@end

@implementation HeadLineBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureSuperViews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - configureViews
- (void)configureSuperViews {
    self.isCanRefresh = YES;
    self.isCanLoadMore = YES;
    [self configureTableView];
}

- (void)configureTableView {
    [self configureDatasource];
    self.tableView.dataSource = self.datasource;
    self.tableView.delegate = self;
    [self registerCells:@[HEAD_LINE_AD_CELL_ID, HEAD_LINE_TEXT_CELL_ID, HEAD_LINE_ONE_IMAGE_CELL_ID, HEAD_LINE_THREE_IMAGE_CELL_ID]];
}

- (void)configureDatasource {
    self.datasource = [[HeadLineContentDatasource alloc]init];
    __weak typeof(self) weakSelf = self;
    self.datasource.baseHeadLineCellConfiguration = ^(BaseHeadLineCell *cell, NSIndexPath *indexPath){
        if (indexPath.row == weakSelf.datasource.mixtureDatas.count - 5) {
            [weakSelf bottomRefreshing];
        }
    };
}

#pragma mark - helpMethod

- (void)registerCells:(NSArray<NSString *> *)cells {
    for (NSString *cellID in cells) {
        [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    }
}


#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.datasource.mixtureDatas[indexPath.row] isKindOfClass:[AdvertisementModel class]]) {
        return 170;
    }
    TopContentModel *model = self.datasource.mixtureDatas[indexPath.row];
    return [model cellHeight];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[HeadLineMediaCell class]]) {
        HeadLineMediaCell *mediaCell = (HeadLineMediaCell *)cell;
        [self handleAdvertisementCellWithAdvertisementModel:mediaCell.model];
        
    }else if ([cell isKindOfClass:[BaseHeadLineCell class]]) {
        BaseHeadLineCell *baseCell = (BaseHeadLineCell *)cell;
        HeadLineDetailViewController *vc = [HeadLineDetailViewController headLineDetailViewControllerWithTid:baseCell.content.tid];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)handleAdvertisementCellWithAdvertisementModel:(AdvertisementModel *)model {
    BannerWebViewViewController *bannerWebVc = [[BannerWebViewViewController alloc]init];
    bannerWebVc.name = model.pname;
    bannerWebVc.url = model.url;
    bannerWebVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bannerWebVc animated:YES];
}


@end
