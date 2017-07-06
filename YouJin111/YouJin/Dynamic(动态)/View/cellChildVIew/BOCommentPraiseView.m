//
//  BOCommentPraiseView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/14.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOCommentPraiseView.h"
#import "BODynamicItem.h"
@interface BOCommentPraiseView()

/**
 点赞btn
 */
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;

/**
 评论Btn
 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

/**
 打赏Btn
 */
@property (weak, nonatomic) IBOutlet UIButton *awardBtn;

@end
@implementation BOCommentPraiseView

+ (instancetype)viewForXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}
- (void)setItem:(BODynamicItem *)item {
    _item = item;
    
    // 赋值数据
    [_praiseBtn setTitle:item.zan_number forState:UIControlStateNormal];
    [_commentBtn setTitle:item.comment_number forState:UIControlStateNormal];
}
- (IBAction)praiseBtnClick:(id)sender {
    NSLog(@"点赞了----》");
}
- (IBAction)commentBtnClick:(id)sender {
    NSLog(@"点击了评论");
}
- (IBAction)awardBtnClick:(id)sender {
    NSLog(@"点击了打赏");
}

@end
