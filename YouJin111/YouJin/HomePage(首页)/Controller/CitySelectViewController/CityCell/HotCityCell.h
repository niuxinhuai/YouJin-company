//
//  HotCityCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/12.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"

@protocol HotCityCellDelegate;

@interface HotCityCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, assign) id<HotCityCellDelegate> delegate;


- (void)updateNames:(NSArray *)names;



@end

@protocol HotCityCellDelegate <NSObject>

@optional

- (void)hotCityCell:(HotCityCell *)cell didSelectedWithIndexPath:(NSIndexPath *)indexPath cityName:(NSString *)name;

@end

