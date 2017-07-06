//
//  UserCommentTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/20.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BiaoQianModel;
@interface UserCommentTableViewCell : UITableViewCell
@property (nonatomic ,strong)UIImageView *headImage;//头像
@property (nonatomic ,strong)UILabel *nicknameLabel;//昵称
@property (nonatomic ,strong)UILabel *pointZeroLabel;//星星级别
@property (nonatomic ,strong)NSMutableArray *xingxArr;//存放五角星的arr
@property (nonatomic ,strong)UILabel *scoreLabel;//四个评分
@property (nonatomic ,strong)UIImageView *essenceImage;//精华点评图片
@property (nonatomic ,strong)UILabel *detailLabel;//详情
@property (nonatomic ,strong)UILabel *timeLabel;//时间
@property (nonatomic ,strong)BiaoQianModel *item;
@property (nonatomic ,strong)UIButton *commentbutton;//评论
@property (nonatomic ,strong)UIButton *zanabutton;//赞

@property (nonatomic ,strong)NSMutableArray *imaurlArr;//存放多张图片的数组

@property (nonatomic ,assign)CGFloat tzpFloat;
@property (nonatomic ,strong)UIImageView *pictureImage;
@property (nonatomic ,assign)CGFloat detailLabelY;


//@property (nonatomic ,assign)CGFloat cellheight;
//- (CGFloat)topCommentCellHeight;


@end
