//
//  HotCityCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HotCityCell.h"
#import "CityCollectionCell.h"

@implementation HotCityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCell];
}


- (void)configureCell {
    [self configureCollectionView];
}

- (void)configureCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(([UIScreen screenWidth] - 60) / 3.0, 40);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor colorWithIntRed:247 green:247 blue:247 alpha:1];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CityCollectionCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([CityCollectionCell class])];
}


#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.nameArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CityCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CityCollectionCell class]) forIndexPath:indexPath];
    [cell updateCityDetailModel:self.nameArray[indexPath.row]];
    return cell;
}


#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CityDetailModel *model = self.nameArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(hotCityCell:didSelectedWithIndexPath: cityName:)]) {
        [self.delegate hotCityCell:self didSelectedWithIndexPath:indexPath cityName:model.name];
    }
}

#pragma mark - publicMethod

- (void)updateNames:(NSArray *)names {
    self.nameArray = names;
    [self.collectionView reloadData];
}



@end
