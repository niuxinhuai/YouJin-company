//
//  UserPageFirstCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MinePageItem.h"
#import "HeadView.h"

@interface UserPageFirstCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet HeadView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *subscribeCountLabel;
@property (retain, nonatomic) UIImageView *flagBottomImageView;
@property (weak, nonatomic) IBOutlet UILabel *flagLabel;

@property (nonatomic, retain) MinePageItem *userInfo;


- (void)updateUserInfo:(MinePageItem *)model;


@end
