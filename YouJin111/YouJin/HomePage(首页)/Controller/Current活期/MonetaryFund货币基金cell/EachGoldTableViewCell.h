//
//  EachGoldTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/8.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CurrentModel;
@interface EachGoldTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *colorPieceView;//前面的小色块
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;//logo图片
@property (weak, nonatomic) IBOutlet UILabel *oneDayLabel;//当日年化
@property (weak, nonatomic) IBOutlet UILabel *copiesLabel;//万份收益
@property (weak, nonatomic) IBOutlet UILabel *withdrawalLabel;//提现速度
@property (nonatomic ,strong)CurrentModel *item;


@property (nonatomic, retain) NSIndexPath *indexPath;


- (void)updateIndexPath:(NSIndexPath *)indexPath;

@end
