//
//  ShareWatermarkView.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareWatermarkView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *waterMask;
@property (weak, nonatomic) IBOutlet UIImageView *shareImageView;


+ (instancetype)create;

- (void)updateShareImage:(UIImage *)image;

@end
