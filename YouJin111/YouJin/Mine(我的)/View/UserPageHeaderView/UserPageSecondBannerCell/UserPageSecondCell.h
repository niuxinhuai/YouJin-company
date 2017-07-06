//
//  UserPageSecondCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MinePageItem.h"

@interface UserPageSecondCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *signatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;


@property (nonatomic, retain) MinePageItem *userInfo;


- (void)updateUserInfo:(MinePageItem *)model;


@end
