//
//  DetailOnePictureCell.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/8.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "DetailOnePictureCell.h"
#import "PlatformServeCellTopView.h"
#import "PlatformServeCellBottomView.h"
#import "BOOnePictureView.h"
#import "PlatformDetailViewModel.h"
@interface DetailOnePictureCell()
// 个人头像，信息的View
@property (nonatomic, weak) PlatformServeCellTopView *topView;
// 中间的pictureView
@property (nonatomic, weak) BOOnePictureView *onePictureView;
// 底部的评论和点赞数
@property (nonatomic, weak) PlatformServeCellBottomView *bottomView;
@end
@implementation DetailOnePictureCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加个人信息的View
        PlatformServeCellTopView *topView = [[PlatformServeCellTopView alloc] init];
        [self.contentView addSubview:topView];
        self.topView = topView;
        // 添加中部的pictureView
        BOOnePictureView *onePictureView = [BOOnePictureView viewForXib];
        [self.contentView addSubview:onePictureView];
        self.onePictureView = onePictureView;
        // 添加底部的点赞和评论
        PlatformServeCellBottomView *bottomView = [[PlatformServeCellBottomView alloc] init];
        [self.contentView addSubview:bottomView];
        self.bottomView = bottomView;
    }
    return self;
}
- (void)setVM:(PlatformDetailViewModel *)VM {
    _VM = VM;
    
    // 顶部信息的View
    self.topView.frame = VM.topFrame;
    self.topView.item = VM.item;
    
    // 中间的图片View
    self.onePictureView.frame = VM.pictureViewFrame;
    self.onePictureView.item = VM.item;
    // 点赞，评论数
    self.bottomView.frame = VM.bottomFrame;
    self.bottomView.item = VM.item;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
