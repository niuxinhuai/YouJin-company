//
//  BaseTableViewCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/5.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, retain) UIView *lineView;


- (void)hiddenLineView:(BOOL)hidden;


@end
