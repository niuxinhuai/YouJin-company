//
//  YJRecentReviewsTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/26.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlatformServeCommentModel;
@interface YJRecentReviewsTableViewCell : UITableViewCell
@property (nonatomic ,strong)UIImageView *headImage;//头像
@property (nonatomic ,strong)UILabel *nicknameLabel;//昵称
//@property (nonatomic ,strong)UILabel *reviewLabel;//点评了一两理财
@property (nonatomic ,strong)UILabel *timeLabel;//时间
@property (nonatomic ,strong)UILabel *pointZeroLabel;//星星级别
@property (nonatomic ,strong)UILabel *detailLabel;//详情
@property (nonatomic ,strong)UIView *grayView;//灰色的view
@property (nonatomic ,strong)UIImageView *logoImage;//小logo
@property (nonatomic ,strong)UILabel *nameLabel;//公司名称
@property (nonatomic ,strong)UIView *thinView;//中间细线
@property (nonatomic ,strong)UILabel *scoreLabel;//四个评分
@property (nonatomic ,strong)PlatformServeCommentModel *item;
@property (nonatomic ,strong)NSMutableArray *xingxArr;//存放五角星的arr
@property (nonatomic ,assign)CGFloat heights;//详情文字高度
@end
