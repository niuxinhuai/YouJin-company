//
//  SwipeSubControllerCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/9.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeSubControllerCell : UICollectionViewCell


@property (nonatomic, weak) UIViewController *viewController;


- (void)addView:(UIView *)view;


@end
