//
//  UINavigationController+GONavigationController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/27.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "UINavigationController+GONavigationController.h"

@implementation UINavigationController (GONavigationController)
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated navigationLock:(id)lock
{
    if (!lock || self.topViewController == lock)
    {
        [self pushViewController:viewController animated:animated];
    }
}
- (id)navigationlock
{
    return self.topViewController;
}
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated navigationLock:(id)lock
{
    if (!lock || self.topViewController == lock)
    {
        [self popToViewController:viewController animated:animated];
    }
    return @[];
}
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated navigationLock:(id)lock
{
    if (!lock || self.topViewController == lock)
    {
        [self popToRootViewControllerAnimated:animated];
    }
    return @[];
}

@end
