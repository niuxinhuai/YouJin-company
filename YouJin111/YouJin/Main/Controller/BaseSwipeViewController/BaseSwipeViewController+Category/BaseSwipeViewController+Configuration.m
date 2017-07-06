//
//  BaseSwipeViewController+Configuration.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseSwipeViewController+Configuration.h"
#import "BaseSwipeViewController+Delegate.h"

@implementation BaseSwipeViewController (Configuration)


- (void)configureSuperViews {
    [self configureCollectionView];
}


- (void)configureCollectionView {
    [self configureCollectionLayout];
    self.collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.pagingEnabled = YES;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[SwipeSubControllerCell class] forCellWithReuseIdentifier:NSStringFromClass([SwipeSubControllerCell class])];
        [self.view insertSubview:collectionView atIndex:0];
        collectionView;
    });
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
    }];
}


- (void)configureCollectionLayout {
    self.layout = [[UICollectionViewFlowLayout alloc]init];
    self.layout.minimumLineSpacing = 0;
    self.layout.minimumInteritemSpacing = 0;
    self.layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.layout.itemSize = CGSizeMake([UIScreen screenWidth], [UIScreen screenHeight]);
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}


@end
