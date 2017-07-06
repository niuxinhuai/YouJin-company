//
//  BOSelfDataCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelfDataItem.h"

@interface BOSelfDataCell : UITableViewCell
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *subTitleLabel;
@property (nonatomic, retain) UIImageView *imgView;

@property (nonatomic, retain) SelfDataItem *item;
@property (nonatomic, retain) NSIndexPath *indexPath;

- (void)updateMineItem:(SelfDataItem *)item indexPath:(NSIndexPath *)indexPath;
- (void)imageViewHidden:(BOOL)hidden;


@end
