//
//  UserCommentCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/24.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
#import "StarView.h"
#import "BiaoQianModel.h"
#import "HeadView.h"

@protocol UserCommentCellDelegate;


@interface ImageCollectionCell : UICollectionViewCell

@property (nonatomic, retain) UIImageView *imageview;

@property (nonatomic, retain) NSString *urlString;

- (void)updateUrlString:(NSString *)url;

@end


@interface UserCommentCell : UITableViewCell<UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet HeadView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *contentLabel;
@property (weak, nonatomic) IBOutlet StarView *starView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *favourButton;
@property (weak, nonatomic) IBOutlet UIImageView *creamImageView;

@property (nonatomic, assign) NSInteger row;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelBottomToContentImageViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionContainerHeight;

@property (nonatomic, retain) BiaoQianModel *model;
@property (nonatomic, retain) UICollectionViewFlowLayout *layout;
@property (nonatomic, assign) id<UserCommentCellDelegate> delegate;

- (void)updateBiaoQianModel:(BiaoQianModel *)model;



@end

@protocol UserCommentCellDelegate <NSObject>

@optional

- (void)userCommentCellDidCilckComment:(UserCommentCell *)cell;
- (void)userCommentCellDidCilckFavour:(UserCommentCell *)cell;
- (void)userCommentCellAlertToLogin:(UserCommentCell *)cell;

@end

