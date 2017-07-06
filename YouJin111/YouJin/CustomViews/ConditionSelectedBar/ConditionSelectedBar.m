//
//  ConditionSelectedBar.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "ConditionSelectedBar.h"


@implementation ConditionSelectedModel

+ (instancetype)conditionSelectedModelWithTitle:(NSString *)title isCanSelected:(BOOL)isCanSelected {
    ConditionSelectedModel *model = [ConditionSelectedModel new];
    model.title = title;
    model.isCanSelected = isCanSelected;
    return model;
}


@end

@implementation ConditionSelectedCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addTitleButton];
    }
    return self;
}

- (void)addTitleButton {
    self.titleButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor colorWithIntRed:153 green:153 blue:153 alpha:1] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:button];
        button.userInteractionEnabled = NO;
        button;
    });
    [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

- (void)updateConditionSelectedModel:(ConditionSelectedModel *)model {
    self.model = model;
    NSString *normalIconString = model.isCanSelected ? self.nomalIcon : @"";
    NSString *selectIconString = model.isCanSelected ? self.selectIcon : @"";
    [self.titleButton setImage:[UIImage imageNamed:normalIconString] forState:UIControlStateNormal];
    [self.titleButton setImage:[UIImage imageNamed:selectIconString] forState:UIControlStateSelected];
    [self.titleButton setTitle:model.title forState:UIControlStateNormal];
    [self layoutSubviews];
}


- (void)updateNomalIcon:(NSString *)normalIcon selectIcon:(NSString *)selectIcon {
    self.nomalIcon = normalIcon;
    self.selectIcon = selectIcon;
}

- (void)updateSelected:(BOOL)isSelected {
    self.isSelcted = isSelected;
    self.titleButton.selected = isSelected;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleButton setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleButton.titleLabel.width, 0, -self.titleButton.titleLabel.width)];
    [self.titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.titleButton.imageView.width, 0, self.titleButton.imageView.width)];
}

- (NSString *)nomalIcon {
    if (!_nomalIcon) {
        _nomalIcon = @"common_icon_paixu_nor";
    }
    return _nomalIcon;
}

- (NSString *)selectIcon {
    if (!_selectIcon) {
        _selectIcon = @"common_icon_paixu_nor";
    }
    return _selectIcon;
}

@end

@interface ConditionSelectedBar()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation ConditionSelectedBar

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
}


- (void)configureViews {
    self.userInteractionEnabled = YES;
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
        [collection registerClass:[ConditionSelectedCell class] forCellWithReuseIdentifier:NSStringFromClass([ConditionSelectedCell class])];
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
        lineView.backgroundColor = [UIColor placeholderColor];
        [self addSubview:lineView];
        lineView;
    });
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.height.equalTo(@1);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
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

- (NSIndexPath *)selectedIndexPath {
    if (!_selectedIndexPath) {
        _selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return _selectedIndexPath;
}

#pragma mark - publicMethod

- (void)updateTitles:(NSArray *)titles {
    if (!titles || titles.count == 0) return;
    self.titles = titles;
    if (self.layout.itemSize.width * titles.count < self.width) {
        self.layout.itemSize = CGSizeMake([UIScreen screenWidth] / titles.count, self.layout.itemSize.height);
        self.colletionView.scrollEnabled = NO;
    }
    [self.colletionView reloadData];
}

- (void)updateNomalIcon:(NSString *)normalIcon selectIcon:(NSString *)selectIcon {
    self.nomalIcon = normalIcon;
    self.selectIcon = selectIcon;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ConditionSelectedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ConditionSelectedCell class]) forIndexPath:indexPath];
    [cell updateNomalIcon:self.nomalIcon selectIcon:self.selectIcon];
    [cell updateConditionSelectedModel:self.titles[indexPath.row]];
    [cell updateSelected:self.selectedIndexPath.row == indexPath.row];
    cell.indexPath = indexPath;
    return cell;
}


#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ConditionSelectedCell *cell = (ConditionSelectedCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (!cell.model.isCanSelected) return;
    self.selectedIndexPath = indexPath;
    for (ConditionSelectedCell *cell in [collectionView visibleCells]) {
        [cell updateSelected:self.selectedIndexPath.row == cell.indexPath.row];
    }
    if ([self.delegate respondsToSelector:@selector(conditionSelectedBar: didSelectedIndexPath:)]) {
        [self.delegate conditionSelectedBar:self didSelectedIndexPath:indexPath];
    }
}


#pragma mark - helpMethod





@end
