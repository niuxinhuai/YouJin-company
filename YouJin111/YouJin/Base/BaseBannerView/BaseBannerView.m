//
//  BaseBannerView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseBannerView.h"

@implementation BaseBannerView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - configure 


- (void)configureBaseViews {
    
}

- (void)addCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = self.bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.pagingEnabled = YES;
        collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:collectionView];
        collectionView;
    });
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
    }];
    
}

- (void)addPageControl {
    self.pageControl = ({
        UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectZero];
        pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:pageControl];
        pageControl;
    });
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
}




@end
