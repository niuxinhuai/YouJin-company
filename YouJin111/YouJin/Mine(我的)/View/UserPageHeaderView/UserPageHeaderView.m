//
//  UserPageHeaderView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "UserPageHeaderView.h"
#import "UserPageFirstCell.h"
#import "UserPageSecondCell.h"

@interface UserPageHeaderView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation UserPageHeaderView


+ (instancetype)create {
    UserPageHeaderView *view = [[UserPageHeaderView alloc]initWithFrame:CGRectZero];
    return view;
}



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViews];
    }
    return self;
}




#pragma mark - configureViews

- (void)configureViews {
    self.backgroundColor = [UIColor whiteColor];
    [self addBackgroundImageView];
    [self configureCollectionView];
    [self addPageControl];
   // [self addBlurView];
    self.clipsToBounds = YES;
}

- (void)addBackgroundImageView {
    self.backgroundImageView = ({
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.backgroundColor = [UIColor colorWithIntRed:58 green:142 blue:245 alpha:1];
        [self addSubview:imageView];
        imageView;
    });
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

- (void)configureCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = self.bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"UserPageFirstCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([UserPageFirstCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:@"UserPageSecondCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([UserPageSecondCell class])];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
}

- (void)addPageControl {
    self.pageControl = ({
        UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectZero];
        pageControl.numberOfPages = 2;
        pageControl.currentPage = 0;
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

- (void)addBlurView {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.blurView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    self.blurView.backgroundColor = [UIColor grayColor];
    self.blurView.alpha = 0.3;
    [self insertSubview:self.blurView aboveSubview:self.backgroundImageView];
    
    [self.blurView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

#pragma mark - publicMethod

- (void)updateUserInfo:(MinePageItem *)model {
    self.userInfo = model;
  //  [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:model.head_image] placeholderImage:[UIImage imageNamed:@"pic_touxiang"] options:SDWebImageCacheMemoryOnly];
    [self.collectionView reloadData];
}


#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UserPageFirstCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UserPageFirstCell class]) forIndexPath:indexPath];
        [cell updateUserInfo:self.userInfo];
        return cell;
    }
    
    UserPageSecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UserPageSecondCell class]) forIndexPath:indexPath];
    [cell updateUserInfo:self.userInfo];
    return cell;
}


#pragma - mark <UIScrollViewDelegate>

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        self.pageControl.currentPage = scrollView.contentOffset.x / [UIScreen screenWidth];
    }
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x / [UIScreen screenWidth];
}





@end
