//
//  BODynamicContentTableViewCell.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BODynamicViewModel;
@interface BODynamicContentTableViewCell : UITableViewCell

// ViewModel的属性
@property (nonatomic, strong) BODynamicViewModel *VM;
@end
