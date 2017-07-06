//
//  BOExceedPictureView.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/14.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BODynamicItem;
@interface BOExceedPictureView : UIView
@property (nonatomic, strong) BODynamicItem *item;
+ (instancetype)viewForXib;
@end
