//
//  OperationsTeamTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/24.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OperationsTeamModel;
@class OperationsTeamTableViewCell;
@protocol OperationsTeamTableViewCellDelegate <NSObject>

-(void)userDidSelectTableViewCell:(OperationsTeamTableViewCell *)cells;

@end
@interface OperationsTeamTableViewCell : UITableViewCell
@property (nonatomic, weak)id<OperationsTeamTableViewCellDelegate>delegate;
@property (nonatomic ,strong)UIImageView *headImage;//logo
@property (nonatomic ,strong)UILabel *namesLabel;//ceo
@property (nonatomic ,strong)UILabel *detailsLabel;
@property (nonatomic ,strong)UIButton *anButton;
@property (nonatomic ,strong)OperationsTeamModel *item;
@property (nonatomic, assign)NSInteger senderTag;
@end
