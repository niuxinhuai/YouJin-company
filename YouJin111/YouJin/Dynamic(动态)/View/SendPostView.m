//
//  SendPostView.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/23.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "SendPostView.h"

@implementation SendPostView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
            // 添加发表动态的按钮
            CGFloat sendConX = (BOScreenW - 230 * BOWidthRate) * 0.5;
            CGFloat sendConY = 279 * BOHeightRate;
            CGFloat sendConWH = 75 * BOWidthRate;
            UIButton *sendConditionBtn = [[UIButton alloc] initWithFrame:CGRectMake(sendConX, sendConY, sendConWH, sendConWH)];
            [sendConditionBtn setImage:[UIImage imageNamed:@"icon_fbdt"] forState:UIControlStateNormal];
            [self addSubview:sendConditionBtn];
            
            // 添加参与话题的按钮
            CGFloat participationX = CGRectGetMaxX(sendConditionBtn.frame) + 80 * BOWidthRate;
            CGFloat participationY = sendConY;
            CGFloat participationWH = sendConWH;
            UIButton *participationBtn = [[UIButton alloc] initWithFrame:CGRectMake(participationX, participationY, participationWH, participationWH)];
            [participationBtn setImage:[UIImage imageNamed:@"icon_cyht"] forState:UIControlStateNormal];
            [self addSubview:participationBtn];
            
            // 添加发表动态的label
            CGFloat sendX = sendConX;
            CGFloat sendY = CGRectGetMaxY(sendConditionBtn.frame) + 12 * BOHeightRate;
            CGFloat sendW = 75 * BOWidthRate;
            CGFloat sendH = 15 * BOHeightRate;
            UILabel *sendConditionLabel = [[UILabel alloc] initWithFrame:CGRectMake(sendX, sendY, sendW, sendH)];
            sendConditionLabel.text = @"发表动态";
            sendConditionLabel.textAlignment = NSTextAlignmentCenter;
            sendConditionLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
            [self addSubview:sendConditionLabel];
            // 添加参与话题的label
            CGFloat takeX = CGRectGetMaxX(sendConditionLabel.frame) + 80 * BOWidthRate;
            CGFloat takeY = CGRectGetMaxY(sendConditionBtn.frame) + 12 * BOHeightRate;
            CGFloat takeW = 75 * BOWidthRate;
            CGFloat takeH = 15 * BOHeightRate;
            UILabel *takePartInLabel = [[UILabel alloc] initWithFrame:CGRectMake(takeX, takeY, takeW, takeH)];
            takePartInLabel.text = @"参与话题";
            takePartInLabel.textAlignment = NSTextAlignmentCenter;
            takePartInLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
            [self addSubview:takePartInLabel];
        
    }
    return self;
}

@end
