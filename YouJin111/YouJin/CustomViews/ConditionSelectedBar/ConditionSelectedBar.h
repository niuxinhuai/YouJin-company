//
//  ConditionSelectedBar.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef enum{
//    
//}ConditionSelectedBarStyle;

@protocol ConditionSelectedBarDelegate;

@interface ConditionSelectedModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isCanSelected;

+ (instancetype)conditionSelectedModelWithTitle:(NSString *)title isCanSelected:(BOOL)isCanSelected;

@end

@interface ConditionSelectedCell : UICollectionViewCell

@property (nonatomic, retain) UIButton *titleButton;

@property (nonatomic, strong) ConditionSelectedModel *model;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, strong) NSString *nomalIcon;
@property (nonatomic, strong) NSString *selectIcon;
@property (nonatomic, assign) BOOL isSelcted;

- (void)updateConditionSelectedModel:(ConditionSelectedModel *)model;
- (void)updateNomalIcon:(NSString *)normalIcon selectIcon:(NSString *)selectIcon;
- (void)updateSelected:(BOOL)isSelected;

@end

@interface ConditionSelectedBar : UIView


@property (nonatomic, retain) UICollectionView *colletionView;
@property (nonatomic, retain) UIView *lineView;
@property (nonatomic, retain) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSArray<ConditionSelectedModel *> *titles;
@property (nonatomic, assign) id<ConditionSelectedBarDelegate> delegate;

@property (nonatomic, strong) NSString *nomalIcon;
@property (nonatomic, strong) NSString *selectIcon;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

- (void)updateTitles:(NSArray *)titles;
- (void)updateNomalIcon:(NSString *)normalIcon selectIcon:(NSString *)selectIcon;


@end


@protocol ConditionSelectedBarDelegate <NSObject>

@optional
- (void)conditionSelectedBar:(ConditionSelectedBar *)conditionBar didSelectedIndexPath:(NSIndexPath *)indexPath;

@end
