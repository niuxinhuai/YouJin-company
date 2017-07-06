//
//  HomeLineHeadBarView.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HomeLineHeadBarViewDelegate;

@interface HeadLineTitleCell : UICollectionViewCell

@property (nonatomic, retain) UILabel *titleLable;
@property (nonatomic, retain) NSString *title;

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, retain) NSIndexPath *indexPath;

- (void)updateTitle:(NSString *)title;
- (void)updateSelectStatus:(BOOL)isSelected;

@end


@interface HomeLineHeadBarView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, retain) UICollectionView *colletionView;
@property (nonatomic, retain) UIView *lineView;


@property (nonatomic, retain) UICollectionViewFlowLayout *layout;

@property (nonatomic, retain) NSArray *titles;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property (nonatomic, assign) id<HomeLineHeadBarViewDelegate> delegate;

+ (instancetype)create;

- (void)updateTitles:(NSArray *)titles;
- (void)updateIndexPath:(NSIndexPath *)indexPath;
- (void)updateLineViewWidth:(CGFloat)width;


@end


@protocol HomeLineHeadBarViewDelegate <NSObject>

@optional

- (void)homeLineHeadBarView:(HomeLineHeadBarView *)view didSelectedItemWithIndexPath:(NSIndexPath *)indexPath;

@end
