//
//  UINavigationController+GONavigationController.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (GONavigationController)
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated navigationLock:(id)lock;
- (id)navigationlock;
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated navigationLock:(id)lock;
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated navigationLock:(id)lock;

@end
