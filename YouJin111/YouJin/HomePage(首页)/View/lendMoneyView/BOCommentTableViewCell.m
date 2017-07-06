//
//  BOCommentTableViewCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/7.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOCommentTableViewCell.h"
#import "PlatformServeCommentModel.h"
#import <SDWebImage/UIButton+WebCache.h>
@interface BOCommentTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourthBtn;
@property (weak, nonatomic) IBOutlet UIButton *fiveBtn;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *cotentLabel;
@property (weak, nonatomic) IBOutlet UILabel *objectLabel;
@property (weak, nonatomic) IBOutlet UIButton *logoBtn;
@property (weak, nonatomic) IBOutlet UILabel *zongPingScoreLabel;
@property (nonatomic, strong) NSArray *btnArray;
@end
@implementation BOCommentTableViewCell
- (NSArray *)btnArray {
    if (_btnArray == nil) {
        _btnArray = [NSArray arrayWithObjects:self.firstBtn,self.secondBtn,self.thirdBtn,self.fourthBtn,self.fiveBtn, nil];
    }
    return _btnArray;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setItem:(PlatformServeCommentModel *)item {
    _item = item;
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:item.head_image] placeholderImage:perchImage];
    self.nameLabel.text = item.uname;
    for (int i = 0; i < [item.score intValue]; i++) {
        UIButton *btn = self.btnArray[i];
        btn.selected = YES;
    }
    self.scoreLabel.text = item.score;
    self.objectLabel.text = item.object;
    self.cotentLabel.text = item.content;
    [self.logoBtn sd_setImageWithURL:[NSURL URLWithString:item.logo] forState:UIControlStateNormal placeholderImage:perchImage];
    self.zongPingScoreLabel.text = [NSString stringWithFormat:@"运营%@ · 风控%@ · 服务%@ · 透明%@",item.v1,item.v2,item.v3,item.v4];
}
@end
