//
//  HomeLineHeadBarView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "HomeLineHeadBarView.h"


@implementation HeadLineTitleCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addTitleLabel];
    }
    return self;
}

- (void)addTitleLabel {
    self.titleLable = ({
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithIntRed:115 green:115 blue:115 alpha:1];
        [self.contentView addSubview:label];
        label;
    });
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

- (void)updateTitle:(NSString *)title {
    self.title = title;
    self.titleLable.text = title;
}

- (void)updateSelectStatus:(BOOL)isSelected {
    self.isSelected = isSelected;
    self.titleLable.textColor = isSelected ? [UIColor colorWithIntRed:70 green:151 blue:251 alpha:1] : [UIColor colorWithIntRed:115 green:115 blue:115 alpha:1];
}

@end

@implementation HomeLineHeadBarView


+ (instancetype)create {
    HomeLineHeadBarView *view = [[HomeLineHeadBarView alloc]init];
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureViews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.colletionView bringSubviewToFront:self.lineView];
}


- (void)configureViews {
    [self addCollectionView];
    [self addLineView];
}


- (void)addCollectionView {
    self.colletionView = ({
        UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
        collection.showsHorizontalScrollIndicator = NO;
        collection.dataSource = self;
        collection.delegate = self;
        collection.backgroundColor = [UIColor whiteColor];
        collection.decelerationRate = UIScrollViewDecelerationRateFast;
        [collection registerClass:[HeadLineTitleCell class] forCellWithReuseIdentifier:NSStringFromClass([HeadLineTitleCell class])];
        [self addSubview:collection];
        collection;
    });
    
    [self.colletionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.right.equalTo(@0);
        make.left.equalTo(@0);
    }];
}


- (void)addLineView {
    self.lineView = ({
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithIntRed:70 green:151 blue:251 alpha:1];
        [self.colletionView addSubview:lineView];
        lineView;
    });
    self.lineView.frame = CGRectMake(0, self.layout.itemSize.height - 2, 20, 2);
}



#pragma mark - reget

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumInteritemSpacing = 0;
        _layout.minimumLineSpacing = 0;
        _layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _layout.itemSize = CGSizeMake(70, 45);
    }
    return _layout;
}

#pragma mark - publicMethod

- (void)updateTitles:(NSArray *)titles {
    if (!titles || titles.count == 0) return;
    self.titles = titles;
    if (self.layout.itemSize.width * titles.count < [UIScreen screenWidth]) {
        self.layout.itemSize = CGSizeMake([UIScreen screenWidth] / titles.count, self.layout.itemSize.height);
        self.colletionView.scrollEnabled = NO;
    }
    [self.colletionView reloadData];
    if (!self.selectedIndexPath) {
        UICollectionViewLayoutAttributes *layoutAttribute = [self.colletionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        self.lineView.centerX = layoutAttribute.center.x;
        self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
}

- (void)updateLineViewWidth:(CGFloat)width {
    self.lineView.width = width;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HeadLineTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HeadLineTitleCell class]) forIndexPath:indexPath];
    [cell updateTitle:self.titles[indexPath.row]];
    cell.indexPath = indexPath;
    [self lineViewScrollToIndexPath:self.selectedIndexPath animation:NO];
    [cell updateSelectStatus:self.selectedIndexPath.row == indexPath.row];
    return cell;
}


#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self updateIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(homeLineHeadBarView: didSelectedItemWithIndexPath:)]) {
        [self.delegate homeLineHeadBarView:self didSelectedItemWithIndexPath:indexPath];
    }
}


#pragma mark - helpMethod

- (void)updateIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedIndexPath != indexPath) {
        self.selectedIndexPath = indexPath;
        [self.colletionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        [self lineViewScrollToIndexPath:indexPath animation:YES];
        [self updateCellSelectStatusWithIndexPath:indexPath];
    }
}

- (void)lineViewScrollToIndexPath:(NSIndexPath *)indexPath animation:(BOOL)animation {
    UICollectionViewLayoutAttributes *layoutAttribute = [self.colletionView layoutAttributesForItemAtIndexPath:indexPath];
    if (animation) {
        [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.lineView.centerX = layoutAttribute.center.x;
        } completion:nil];
    }else {
        self.lineView.centerX = layoutAttribute.center.x;
    }
}

- (void)updateCellSelectStatusWithIndexPath:(NSIndexPath *)indexPath {
    for (HeadLineTitleCell *cell in [self.colletionView visibleCells]) {
        [cell updateSelectStatus:self.selectedIndexPath.row == cell.indexPath.row];
    }
}

@end
