//
//  StarView.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/1.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView

@property (nonatomic, retain) UIView *backView;
@property (nonatomic, retain) UIView *foreView;
@property (nonatomic, retain) UIImageView *backImageView;
@property (nonatomic, retain) UIImageView *foreImageView;


@property (nonatomic, assign) CGFloat score;



- (void)updateScore:(CGFloat)score;
- (void)updateForeImage:(NSString *)foreString backImage:(NSString *)backString;

@end
