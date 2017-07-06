//
//  HeadLineThreeImageCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BaseHeadLineCell.h"

#define HEAD_LINE_THREE_IMAGE_CELL_ID @"HeadLineThreeImageCell"

@interface HeadLineThreeImageCell : BaseHeadLineCell

@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;



@end
