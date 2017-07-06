//
//  BONameTextVIew.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/14.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BONameTextVIew.h"
#import "BODynamicItem.h"

@interface BONameTextVIew ()

/**
 头像图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

/**
 昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/**
 时间
 */
@property (weak, nonatomic) IBOutlet UILabel *timeComeLabel;

/**
 内容
 */
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end
@implementation BONameTextVIew

+ (instancetype)viewForXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}
- (void)setItem:(BODynamicItem *)item {
    _item = item;
    _commentLabel.numberOfLines = 0;
    _nameLabel.text = item.name_id;
    _timeComeLabel.text = item.time_come;
    _commentLabel.text = item.article_text;
}

@end
