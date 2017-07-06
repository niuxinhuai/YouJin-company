//
//  AttentionSectionVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/24.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "AttentionSectionVC.h"

#import "AttentionTableVC.h"
static NSString *const ID = @"cell";
@interface AttentionSectionVC ()<UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UIScrollView *attentionScrollView;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *pictureArray2;
@property (nonatomic, strong) NSArray *textArray2;
@end

@implementation AttentionSectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor = BOColor(244, 245, 247);
    
    // 设置AttentionScrollView
    [self setupAttentionScrollView];
    NSArray *pictureArray2 = [NSArray arrayWithObjects:@"icon_sqxqm", @"icon_lcgs",@"icon_shzt",@"icon_sbnxs",@"icon_kydzz",@"icon_fzjj",@"icon_lxms",@"icon_shgjj",nil];
    self.pictureArray2 = pictureArray2;
    NSArray *textArray2 = [NSArray arrayWithObjects:@"省钱小窍门", @"理财故事",@"生活杂谈",@"上班那些事",@"开源大作战",@"房子家居",@"旅行美食",@"社保公积金",nil];
    self.textArray2 = textArray2;
    // 注册cell
}

#pragma mark - 设置AttentionScrollView 
- (void)setupAttentionScrollView {
    UIScrollView *attentionScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH - 64)];
    attentionScrollView.delegate = self;
    self.attentionScrollView = attentionScrollView;
    attentionScrollView.backgroundColor = BOColor(244, 245, 247);
    attentionScrollView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    [self.view addSubview:attentionScrollView];
    
    // 设置topView
    [self setupTopView];
    
    // 设置底部的tableVC
    [self setupTableVC];
}
#pragma mark - 设置topView
- (void)setupTopView {
    // 创建topView
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 80 * BOHeightRate)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.attentionScrollView addSubview:topView];
    // 添加中间的View
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(0, 10 * BOHeightRate, 70 * BOWidthRate, 60 * BOHeightRate)];
//    middleView.layer.shadowColor = [UIColor blackColor].CGColor;
//    middleView.layer.shadowOffset = CGSizeMake(0, 4);
//    middleView.layer.shadowRadius = 3;
//    middleView.layer.shadowOpacity = 0.8;
    [topView addSubview:middleView];
    // 创建是否关注的label
    UILabel *attentionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10 * BOHeightRate, 70 * BOWidthRate, 15 * BOHeightRate)];
    [attentionLabel setFont:[UIFont systemFontOfSize:12]];
    attentionLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
    attentionLabel.text = @"已关注";
    attentionLabel.textAlignment = NSTextAlignmentCenter;
    [middleView addSubview:attentionLabel];
    // 创建关注个数的label
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(attentionLabel.frame) + 14 * BOHeightRate, 70 * BOWidthRate, 17 * BOHeightRate)];
    numberLabel.text = @"8";
    [numberLabel setFont:[UIFont systemFontOfSize:20]];
    numberLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    [middleView addSubview:numberLabel];
    
    // 设置uicollectView
    // 设置collectionView的样式
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.0f;
    layout.minimumInteritemSpacing = 0.0f;
    layout.itemSize = CGSizeMake(81 * BOWidthRate, 80 * BOHeightRate);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(71 * BOWidthRate, 0, BOScreenW - 71 * BOWidthRate, 80 * BOHeightRate)  collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.attentionScrollView addSubview:collectionView];
}
#pragma mark - 设置tableVC
- (void)setupTableVC {
    AttentionTableVC *attentionTabelVC = [[AttentionTableVC alloc] init];
    attentionTabelVC.tableView.frame = CGRectMake(0, 88 * BOHeightRate, BOScreenW, attentionTabelVC.tableViewHeight);
     self.attentionScrollView.contentSize = CGSizeMake(BOScreenW, CGRectGetMaxY(attentionTabelVC.tableView.frame));
    attentionTabelVC.tableView.scrollEnabled = NO;
    [self.attentionScrollView addSubview:attentionTabelVC.tableView];
   
}

#pragma mark - uicollectView datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    ChooseSectionCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    cell.headImageView.image = [UIImage imageNamed:self.pictureArray2[indexPath.row]];
//    cell.titleLabel.text = self.textArray2[indexPath.row];
//    return cell;
    return nil;
}
@end
