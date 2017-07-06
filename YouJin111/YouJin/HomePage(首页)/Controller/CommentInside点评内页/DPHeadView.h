//
//  DPHeadView.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPdetailModel;
@class HeadView;
@interface DPHeadView : UIView
@property (nonatomic ,strong)HeadView *headimageview;
@property (nonatomic ,strong)UIButton *coverButton;//覆盖头像的button
//@property (nonatomic ,strong)UILabel *nicknameLabel;//昵称
@property (nonatomic ,strong)UIButton *nicknameButton;//昵称
@property (nonatomic ,strong)UILabel *pointZeroLabel;//星星级别
@property (nonatomic ,strong)NSMutableArray *xingxArr;//存放五角星的arr
@property (nonatomic ,strong)UILabel *scoreLabel;//四个评分
@property (nonatomic ,strong)UIImageView *essenceImage;//精华点评图片
@property (nonatomic ,strong)UILabel *detailLabel;//详情
@property (nonatomic ,strong)UILabel *timeLabel;//时间
@property (nonatomic ,strong)DPdetailModel *item;
@property (nonatomic ,strong)NSMutableArray *imaurlArr;//存放多张图片的数组
@property (nonatomic ,strong)NSMutableArray *fourTLArr;//存放四个标签

@property (nonatomic ,assign)float textheight;
@property (nonatomic ,assign)float imageheight;

@end
