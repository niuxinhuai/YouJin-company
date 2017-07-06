//
//  SubscribeCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/11.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"
#import "AttentionModel.h"

@protocol SubscribeCellDelegate;

@interface SubscribeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet HeadView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelSubscribeButton;
@property (weak, nonatomic) IBOutlet UIButton *subscrubeButton;

@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, retain) AttentionModel *model;
@property (nonatomic, assign) id<SubscribeCellDelegate> delegate;
@property (nonatomic, assign) BOOL isFromGold;

- (void)updateAttentionModel:(AttentionModel *)model;
- (void)subscribeButtonEnable:(BOOL)enable;


@end

@protocol SubscribeCellDelegate <NSObject>

@optional
- (void)subscribeCell:(SubscribeCell *)cell didClickSubscibe:(BOOL)subscribe;

@end

