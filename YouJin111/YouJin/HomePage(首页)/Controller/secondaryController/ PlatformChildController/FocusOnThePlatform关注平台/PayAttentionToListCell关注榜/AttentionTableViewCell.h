//
//  AttentionTableViewCell.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/2/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GuanzhuBangModel;
@interface AttentionTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *frontImage;
@property (nonatomic, strong) UILabel *upLabel;
@property (nonatomic, strong) UILabel *downLabel;
@property (nonatomic, strong) UIButton *backbutton;
@property (nonatomic, strong) GuanzhuBangModel *item;

@property (nonatomic, assign) int yesORon;
@property (nonatomic, assign) int jishu;
@property (nonatomic, assign) int jishus;

@end
