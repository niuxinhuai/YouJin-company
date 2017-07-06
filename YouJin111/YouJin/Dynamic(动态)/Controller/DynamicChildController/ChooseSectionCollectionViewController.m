//
//  ChooseSectionCollectionViewController.m
//  CustomMessageView
//
//  Created by 李智权 on 17/3/23.
//  Copyright © 2017年 ZJS. All rights reserved.
//
#import "ChooseSectionCollectionViewController.h"
#import "ChooseSectionCollectionViewCell.h"
#import "CustomHeaderCollectionReusableView.h"


static NSString *const viewIndentifier = @"viewIndentifier";
static NSString *const reuseIdentifier = @"Cell";

@interface ChooseSectionCollectionViewController ()

/**
 *  @brief  数据
 */
@property (strong, nonatomic) NSMutableArray *sectionsArray;

/**
 *  @brief  标题的数据
 */
@property (strong, nonatomic) NSMutableArray *titleArray;

@end

@implementation ChooseSectionCollectionViewController


- (instancetype)init {
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.0f;
    layout.minimumInteritemSpacing = 0.0f;
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        [self.collectionView registerClass:[ChooseSectionCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [self.collectionView registerClass:[CustomHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:viewIndentifier];
        self.collectionView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *pictureArray1 = [NSArray arrayWithObjects:@"icon_lcrm", @"icon_yhlc",@"icon_wzxyk",@"icon_gpzzz",@"icon_jjzmw",@"icon_wdbx",@"icon_wdlc",@"icon_zhlc",@"icon_bgt",@"icon_jqnds",nil];
    NSArray *textArray1 = [NSArray arrayWithObjects:@"理财入门", @"银行理财",@"玩转信用卡",@"股票涨涨涨",@"基金这么玩",@"我的保险",@"网贷理财",@"综合理财",@"曝光台",@"借钱那点事",nil];
    NSArray *pictureArray2 = [NSArray arrayWithObjects:@"icon_sqxqm", @"icon_lcgs",@"icon_shzt",@"icon_sbnxs",@"icon_kydzz",@"icon_fzjj",@"icon_lxms",@"icon_shgjj",nil];
    NSArray *textArray2 = [NSArray arrayWithObjects:@"省钱小窍门", @"理财故事",@"生活杂谈",@"上班那些事",@"开源大作战",@"房子家居",@"旅行美食",@"社保公积金",nil];
        CollectionCellItem *tilteItem1 = [[CollectionCellItem alloc] initWithPic:@"icon_licai" title:[NSString stringWithFormat:@"理财"] height:50.0f width:self.view.width];
        [self.titleArray addObject:tilteItem1];

        NSMutableArray *rowArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 10; i ++) {
            CollectionCellItem *item = [[CollectionCellItem alloc] initWithPic:pictureArray1[i] title:textArray1[i] height:80 width:self.view.width / 4];
            [rowArray addObject:item];
        }
        [self.sectionsArray addObject:rowArray];
    CollectionCellItem *tilteItem2 = [[CollectionCellItem alloc] initWithPic:@"icon_shenghuo" title:[NSString stringWithFormat:@"理财"] height:50.0f width:self.view.width];
    [self.titleArray addObject:tilteItem2];
    
    NSMutableArray *rowArray1 = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i ++) {
        CollectionCellItem *item = [[CollectionCellItem alloc] initWithPic:pictureArray2[i] title:textArray2[i] height:80 width:self.view.width / 4];
        [rowArray1 addObject:item];
    }
    [self.sectionsArray addObject:rowArray1];

    
    //数据传输过来后再刷新
    [self performSelector:@selector(performSelectorAfterTime) withObject:nil afterDelay:1];
    
}

- (void)performSelectorAfterTime {
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.sectionsArray count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.sectionsArray objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChooseSectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    CollectionCellItem *item = [[self.sectionsArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.item];
    cell.item = item;    
    return cell;
}


- (NSMutableArray *)sectionsArray {
    if (!_sectionsArray) {
        _sectionsArray = [[NSMutableArray alloc] init];
    }
    return _sectionsArray;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc] init];
    }
    return _titleArray;
}
#pragma mark <UICollectionViewDelegate>

#pragma mark - <UICollectionViewDelegateFlowLayout>
/**
 *  @brief  单元格大小的回调
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCellItem *rowItem =  [[self.sectionsArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.item];
    return (CGSizeMake(rowItem.cellWidth, rowItem.cellHeight));
}

/**
 *  @brief  分区头视图的回调
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if(kind && [kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CustomHeaderCollectionReusableView *view = (CustomHeaderCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:viewIndentifier forIndexPath:indexPath];
        CollectionCellItem *item = [self.titleArray objectAtIndex:indexPath.section];
        view.item = item;
        return view;
    }
    return ([[UICollectionReusableView alloc] init]);
}

/**
 *  @brief  分区头大小的回调
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CollectionCellItem *sectionItem = [self.titleArray objectAtIndex:section];
    if(!sectionItem.cellHeight) {
        return (CGSizeZero);
    }
    return (CGSizeMake(sectionItem.cellWidth, sectionItem.cellHeight));
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
