//
//  BOOnePictureTableViewCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOOnePictureTableViewCell.h"
#import "BONameTextVIew.h"
#import "BOCommentPraiseView.h"
#import "BOOnePictureView.h"
#import "BODynamicViewModel.h"
@interface BOOnePictureTableViewCell ()
// 个人信息和发表文字的View
@property (nonatomic, weak) BONameTextVIew *nameTextView;
// 显示一张图片的View
@property (nonatomic, weak) BOOnePictureView *onePictureView;
// 显示点赞数，评论数的View
@property (nonatomic, weak) BOCommentPraiseView *CommentPraiseView;
@end
@implementation BOOnePictureTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 添加个人信息的View
        BONameTextVIew *nameTextView = [BONameTextVIew viewForXib];
        [self.contentView addSubview:nameTextView];
        _nameTextView = nameTextView;
        // 添加一张图片的View
        BOOnePictureView *onePictureView = [BOOnePictureView viewForXib];
        [self.contentView addSubview:onePictureView];
        _onePictureView = onePictureView;
        // 添加评论数，点赞数的View
        BOCommentPraiseView *CommentPraiseView = [BOCommentPraiseView viewForXib];
        [self.contentView addSubview:CommentPraiseView];
        _CommentPraiseView = CommentPraiseView;
    }
    return self;
}
- (void)setVM:(BODynamicViewModel *)VM {
    _VM = VM;
    
    // 顶部信息的View
    _nameTextView.frame = VM.nameTextFrame;
    _nameTextView.item = VM.item;
    
    // 中间的图片View
    _onePictureView.frame = VM.pictureViewFrame;
    _onePictureView.item = VM.item;
    // 点赞，评论数
    _CommentPraiseView.frame = VM.praiseNumberFrame;
    _CommentPraiseView.item = VM.item;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
