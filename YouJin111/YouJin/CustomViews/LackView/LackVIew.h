//
//  LackVIew.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/3.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LackVIew : UIView


@property (nonatomic, retain) UIImageView *lackImageView;
@property (nonatomic, retain) UILabel *lackLabel;



- (void)updateImage:(NSString *)imageString lackText:(NSString *)text;

- (void)updateImage:(NSString *)imageString;

- (void)updateLackText:(NSString *)text;


@end
