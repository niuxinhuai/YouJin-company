//
//  BaseViewController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/4.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController



+ (instancetype)create;
- (void)toast:(NSString *)message complete:(dispatch_block_t)complete;
- (void)addAutoDismissKeyboardGesture;

@end
